USE CMS;

--------------------------------------------------------------------------------------------------------------------------------
-- Stored procedure to add a resident
GO
CREATE OR ALTER PROCEDURE AddResident
    @ApartmentID INT,
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @ContactNumber VARCHAR(20),
    @Email VARCHAR(255),
    @EmergencyContact VARCHAR(20),
    @OccupancyType VARCHAR(50),
    @SSN VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @EncryptedSSN VARBINARY(MAX);

    OPEN SYMMETRIC KEY SSNEncryptionKey
    DECRYPTION BY CERTIFICATE SSNEncryptionCert;

    SET @EncryptedSSN = EncryptByKey(Key_GUID('SSNEncryptionKey'), @SSN);

    CLOSE SYMMETRIC KEY SSNEncryptionKey;

    INSERT INTO Resident (ApartmentID, FirstName, LastName, ContactNumber, Email, EmergencyContact, OccupancyType, SSN)
    VALUES (@ApartmentID, @FirstName, @LastName, @ContactNumber, @Email, @EmergencyContact, @OccupancyType, @EncryptedSSN);
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Stored procedure to get all apartments
-- which can also filter apartments based on the status optionally
GO
CREATE OR ALTER PROCEDURE GetApartments
    @Status VARCHAR(50) = NULL
AS
BEGIN
    SELECT
        a.ApartmentID,
        a.[Number] AS ApartmentNumber,
        a.NumOfBedrooms,
        a.NumOfBathrooms,
        a.[Status],
        a.LeaseStartDate,
        a.LeaseEndDate,
        b.BuildingID,
        b.[Name] AS BuildingName,
        b.[Number] AS BuildingNumber
    FROM
        Apartment a
        JOIN Building b ON a.BuildingID = b.BuildingID
    WHERE
        (@Status IS NULL OR a.[Status] = @Status)
    ORDER BY
        b.BuildingID, a.ApartmentID;
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Stored procedure to retrieve a list of residents by building ID or a combination of building name and number
-- which can also filter residents based on their occupancy status optionally
GO
CREATE OR ALTER PROCEDURE GetResidentsByBuilding
    @BuildingID INT = NULL,
    @BuildingName VARCHAR(255) = NULL,
    @BuildingNumber VARCHAR(50) = NULL,
    @OccupancyType VARCHAR(50) = NULL
AS
BEGIN
    SELECT
        a.ApartmentID,
        a.[Number] AS ApartmentNumber,
        r.ResidentID,
        r.FirstName,
        r.LastName,
        r.ContactNumber,
        r.Email,
        r.OccupancyType
    FROM
        Building b
        JOIN Apartment a ON b.BuildingID = a.BuildingID
        JOIN Resident r ON a.ApartmentID = r.ApartmentID
    WHERE
        (@BuildingID IS NOT NULL AND b.BuildingID = @BuildingID)
        OR
        (@BuildingID IS NULL AND b.[Name] = @BuildingName AND b.[Number] = @BuildingNumber)
        AND 
        (@OccupancyType IS NULL OR r.OccupancyType = @OccupancyType)
    ORDER BY
        a.ApartmentID, r.ResidentID;
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Stored procedure to get upcoming scheduled service requests assigned to a staff
GO
CREATE OR ALTER PROCEDURE GetServiceRequestsByStaff
    @StaffID INT
AS
BEGIN
    SELECT
        sr.ServiceRequestID,
        sr.ResidentID,
        r.FirstName AS ResidentFirstName,
        r.LastName AS ResidentLastName,
        sr.Description,
        sr.RequestType,
        sr.RequestDate,
        sr.ScheduledDate,
        sr.[Status],
        sr.[Priority],
        sr.RequestFee
    FROM
        ServiceRequest sr
        JOIN Staff s ON sr.StaffAssignedID = s.StaffID
        JOIN Resident r ON sr.ResidentID = r.ResidentID
    WHERE 
        sr.StaffAssignedID = @StaffID AND sr.ScheduledDate >= CAST(GETDATE() AS DATE)
    ORDER BY
        CASE sr.[Priority]
            WHEN 'High' THEN 1
            WHEN 'Medium' THEN 2
            WHEN 'Low' THEN 3
            ELSE 4
        END,
        sr.ScheduledDate;
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Stored procedure to get all amenity bookings made for today
CREATE OR ALTER PROCEDURE GetAmenityBookingsForToday
AS
BEGIN
    SELECT
        ab.AmenityBookingID,
        a.AmenityID,
        a.[Name] AS AmenityName,
        ab.ResidentID,
        r.FirstName AS ResidentFirstName,
        r.LastName AS ResidentLastName,
        ab.StartTime,
        ab.EndTime,
        ab.NumOfAttendees,
        ab.BookingFee
    FROM
        AmenityBooking ab
        JOIN Amenity a ON ab.AmenityID = a.AmenityID
        JOIN Resident r ON ab.ResidentID = r.ResidentID
    WHERE
        ab.BookingDate = CAST(GETDATE() AS DATE)
    ORDER BY
        ab.StartTime;
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Stored procedure to process payments of various payment types such as 
-- maintenance charges, service request fees, and mmenity booking fees
GO
CREATE OR ALTER PROCEDURE MakePayment
    @ResidentID INT,
    @Amount DECIMAL(10, 2),
    @PaymentType VARCHAR(50),
    @PaymentMethod VARCHAR(50),
    @PaymentMethodLastFour VARCHAR(4),
    @EntityID INT,
    @TransactionRefNum UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF @Amount <= 0
    BEGIN
        RAISERROR ('Amount must be greater than zero.', 16, 1);
        RETURN;
    END

    IF @PaymentType NOT IN ('Maintenance', 'ServiceRequest', 'AmenityBooking')
    BEGIN
        RAISERROR ('Invalid PaymentType provided.', 16, 1);
        RETURN;
    END


    DECLARE @PaymentID INT;
    DECLARE @PaymentDate DATETIME = GETDATE();
    DECLARE @BalanceAmount DECIMAL(10, 2);

    IF @PaymentType = 'Maintenance'
    BEGIN
        DECLARE @TotalPaid DECIMAL(10, 2);

        -- Calculate the total amount paid so far for this invoice
        SELECT @TotalPaid = ISNULL(SUM(Amount), 0)
        FROM Payment
        WHERE PaymentID IN (
            SELECT PaymentID 
            FROM MaintenanceFee 
            WHERE InvoiceID = @EntityID
        );

        SELECT @BalanceAmount = TotalAmount - (@TotalPaid + @Amount)
        FROM Invoice
        WHERE InvoiceID = @EntityID;

        IF @BalanceAmount < 0
        BEGIN
            RAISERROR('Payment exceeds the balance amount.', 16, 1);
            RETURN;
        END
    END

    -- Insert into Payment table
    INSERT INTO Payment (ResidentID, Amount, PaymentDate, PaymentType, [Status], PaymentMethod, PaymentMethodLastFour)
    VALUES (@ResidentID, @Amount, @PaymentDate, @PaymentType, CASE WHEN @BalanceAmount > 0 THEN 'Partial' ELSE 'Paid' END, @PaymentMethod, @PaymentMethodLastFour);

    SET @PaymentID = SCOPE_IDENTITY();

    SELECT @TransactionRefNum = TransactionRefNum 
    FROM Payment 
    WHERE PaymentID = @PaymentID;

    -- Insert into respective fee table based on PaymentType
    IF @PaymentType = 'Maintenance'
    BEGIN
        INSERT INTO MaintenanceFee (PaymentID, InvoiceID, BalanceAmount)
        VALUES (@PaymentID, @EntityID, @BalanceAmount);

        -- Update the Invoice status
        IF @BalanceAmount = 0
        BEGIN
            UPDATE Invoice
            SET [Status] = 'Paid'
            WHERE InvoiceID = @EntityID;
        END
    END
    ELSE IF @PaymentType = 'ServiceRequest'
    BEGIN
        INSERT INTO ServiceRequestFee (PaymentID, ServiceRequestID)
        VALUES (@PaymentID, @EntityID);
    END
    ELSE IF @PaymentType = 'AmenityBooking'
    BEGIN
        INSERT INTO AmenityBookingFee (PaymentID, AmenityBookingID)
        VALUES (@PaymentID, @EntityID);
    END
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Stored procedure to submit a new service request based on the request type, priority, and scheduled date, 
-- and automatically assigns a staff member to handle the request.
-- Returns:
--  The message of newly created service request along with request ID and the assigned staff's ID.

CREATE OR ALTER PROCEDURE SubmitServiceRequest
    @ResidentID INT,
    @Description VARCHAR(2500),
    @RequestType VARCHAR(50),
    @ScheduledDate DATE,
    @Priority VARCHAR(50),
    @RequestFee DECIMAL(10, 2) = NULL,
    @OutputMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Resident WHERE ResidentID = @ResidentID)
    BEGIN
        RAISERROR('Resident not found.', 16, 1);
        RETURN;
    END

    DECLARE @ServiceRequestID INT;
    DECLARE @StaffAssignedID INT = NULL;
    DECLARE @RoleRequired VARCHAR(50);

    -- Calculate fee if not provided and if the request type is Plumbing or Electrical
    IF @RequestFee IS NULL AND @RequestType IN ('Plumbing', 'Electrical')
    BEGIN
        SET @RequestFee = 
        CASE @Priority
            WHEN 'High' THEN 50.00
            WHEN 'Medium' THEN 25.00
            WHEN 'Low' THEN 10.00
            ELSE NULL
        END;
    END

    -- Define the role of the staff required based on the request type
    SET @RoleRequired = 
    CASE 
        WHEN @RequestType = 'Car Parking' THEN 'Parking Coordinator'
        WHEN @RequestType = 'Common Area' THEN 'Facilitator'
        WHEN @RequestType = 'Electrical' THEN 'Electrician'
        WHEN @RequestType = 'Plumbing' THEN 'Plumber'
        WHEN @RequestType = 'Other' THEN 'Maintenance Specialist'
    END

    -- Find an available staff member whose role matches the request type and
    -- who is not assigned to any service request on the ScheduledDate
    SELECT TOP 1 @StaffAssignedID = s.StaffID
    FROM Staff s
    WHERE s.[Role] = @RoleRequired AND s.EmploymentEndDate < GETDATE()
    AND NOT EXISTS (
        SELECT 1
        FROM ServiceRequest sr
        WHERE sr.StaffAssignedID = s.StaffID AND sr.ScheduledDate = @ScheduledDate
    )
    ORDER BY NEWID();

    -- Insert the service request into the table
    INSERT INTO ServiceRequest (
        ResidentID, [Description], RequestType, RequestDate, ScheduledDate, [Status], [Priority], RequestFee, StaffAssignedID
    )
    VALUES (
        @ResidentID, @Description, @RequestType, GETDATE(), @ScheduledDate, 'Open', @Priority, @RequestFee, @StaffAssignedID
    );

    SET @ServiceRequestID = SCOPE_IDENTITY();

    IF @StaffAssignedID IS NOT NULL
    BEGIN
        SET @OutputMessage = 'Service request with ID ' + CAST(@ServiceRequestID AS VARCHAR) + 
                             ' created successfully and assigned to staff with ID ' + 
                             CAST(@StaffAssignedID AS VARCHAR) + '.';
    END
    ELSE
    BEGIN
        SET @OutputMessage = 'Service request with ID ' + CAST(@ServiceRequestID AS VARCHAR) + 
                             ' created successfully but not assigned to any staff.';
    END

END;
GO
--------------------------------------------------------------------------------------------------------------------------------