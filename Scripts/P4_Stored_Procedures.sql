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

-- EXEC AddResident 100, 'John', 'Doe', '0987654322', 'johndoe@email.com', NULL, 'Owner', '123-45-6789';
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
        ((@BuildingID IS NOT NULL AND b.BuildingID = @BuildingID)
        OR
        (@BuildingID IS NULL AND b.[Name] = @BuildingName AND b.[Number] = @BuildingNumber))
        AND 
        (@OccupancyType IS NULL OR r.OccupancyType = @OccupancyType)
    ORDER BY
        a.ApartmentID, r.ResidentID;
END;
GO

-- EXEC GetResidentsByBuilding @BuildingID=1, @OccupancyType='Tenant';
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

-- EXEC GetServiceRequestsByStaff @StaffID=5;
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
    @OutputMessage VARCHAR(500) OUTPUT
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
    DECLARE @TransactionRefNum UNIQUEIDENTIFIER;

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

        UPDATE Invoice
        SET [Status] = CASE WHEN @BalanceAmount > 0 THEN 'Partial' ELSE 'Paid' END
        WHERE InvoiceID = @EntityID;

        SET @OutputMessage = 'Payment successful for Invoice Number: ' + (SELECT [Number] FROM Invoice WHERE InvoiceID = @EntityID) 
                            + ' ' + CASE WHEN @BalanceAmount > 0 THEN 'partially' ELSE 'fully' END
                            + ' | Transaction Reference Number:' + CAST(@TransactionRefNum AS VARCHAR(36));
    END
    ELSE IF @PaymentType = 'ServiceRequest'
    BEGIN
        INSERT INTO ServiceRequestFee (PaymentID, ServiceRequestID)
        VALUES (@PaymentID, @EntityID);

        SET @OutputMessage = 'Payment successful for Service Request';
    END
    ELSE IF @PaymentType = 'AmenityBooking'
    BEGIN
        INSERT INTO AmenityBookingFee (PaymentID, AmenityBookingID)
        VALUES (@PaymentID, @EntityID);

        SET @OutputMessage = 'Payment successful for Amenity Booking';
    END
END;
GO

-- DECLARE @OutputMsg VARCHAR(500);
-- EXEC MakePayment @ResidentID=2, @Amount= 1000, @PaymentType= 'Maintenance', @PaymentMethod='CC', @PaymentMethodLastFour='8267', @EntityID=2, @OutputMessage= OUTPUT
-- SELECT @OutputMsg;
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
    @OutputMessage VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Resident WHERE ResidentID = @ResidentID)
    BEGIN
        RAISERROR('Resident not found.', 16, 1);
        RETURN;
    END
 
    DECLARE @StaffAssignedID INT = NULL;
    DECLARE @StaffFullName VARCHAR(255);
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
        WHEN @RequestType = 'Car Parking' THEN 'ParkingCoordinator'
        WHEN @RequestType = 'Common Area' THEN 'Facilitator'
        WHEN @RequestType = 'Electrical' THEN 'Electrician'
        WHEN @RequestType = 'Plumbing' THEN 'Plumber'
        WHEN @RequestType = 'Other' THEN 'GeneralMaintenance'
    END

    -- Find an available staff member whose role matches the request type and
    -- who is not assigned to any service request on the ScheduledDate
    SELECT TOP 1 @StaffAssignedID = s.StaffID, @StaffFullName = CONCAT(s.FirstName, ' ', s.LastName)
    FROM Staff s
    OUTER APPLY (
        SELECT COUNT(*) AS Assignments
        FROM ServiceRequest sr
        WHERE sr.StaffAssignedID = s.StaffID
        AND sr.ScheduledDate = @ScheduledDate
    ) as AssignmentCount
    WHERE s.[Role] = @RoleRequired
    AND (s.EmploymentEndDate < GETDATE() OR s.EmploymentEndDate IS NULL)
    AND AssignmentCount.Assignments < 5
    ORDER BY NEWID();

    -- Insert the service request into the table
    INSERT INTO ServiceRequest (ResidentID, [Description], RequestType, RequestDate, ScheduledDate, [Status], [Priority], RequestFee, StaffAssignedID)
    VALUES (@ResidentID, @Description, @RequestType, GETDATE(), @ScheduledDate, 'Open', @Priority, @RequestFee, @StaffAssignedID);

    IF @StaffAssignedID IS NOT NULL
    BEGIN
        SET @OutputMessage = 'Service request created successfully and assigned to staff ' + @StaffFullName + '.';
    END
    ELSE
    BEGIN
        SET @OutputMessage = 'Service request created successfully but not assigned to any staff.';
    END
END;
GO

-- DECLARE @OutputMsg VARCHAR(500);
-- EXEC SubmitServiceRequest @ResidentID=7, @Description='Test', @RequestType='Plumbing', @ScheduledDate='2024-08-05', @Priority='High', @RequestFee=NULL, @OutputMessage=@OutputMsg OUTPUT
-- SELECT @OutputMsg;
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Procedure to insert Visitor Details, Visitor Logs, and ParkingSlot allotment
GO
CREATE OR ALTER PROCEDURE InsertVisitorDetailsAndParkingDetailsProcedure
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @ContactNumber VARCHAR(20),
    @VisitDate DATE,
    @ResidentID INT,
	@VisitPurpose VARCHAR(255),
    @LicensePlate VARCHAR(255),
    @Make VARCHAR(255),
    @Model VARCHAR(255),
    @VehicleType VARCHAR(255),
    @OutputMessage VARCHAR(255) OUTPUT
AS
BEGIN
    DECLARE @EntryTime DATETIME;
    DECLARE @ExitTime DATETIME;
    DECLARE @VisitorID INT;
    DECLARE @VehicleID INT;
    DECLARE @ParkingSlotID INT;
    DECLARE @ApartmentVisited INT;

    IF @VisitDate IS NULL
    BEGIN
        SET @VisitDate = GETDATE();
    END;

    SET @EntryTime = GETDATE();

    INSERT INTO Visitor (FirstName, LastName, ContactNumber, VisitDate, EntryTime)
    VALUES (@FirstName, @LastName, @ContactNumber, @VisitDate, @EntryTime);

    SET @VisitorID = SCOPE_IDENTITY();

    IF @LicensePlate IS NOT NULL AND @Make IS NOT NULL AND @Model IS NOT NULL AND @VehicleType IS NOT NULL
    BEGIN
        INSERT INTO Vehicle (OwnerID, LicensePlate, Make, Model, [Type])
        VALUES (@VisitorID, @LicensePlate, @Make, @Model, @VehicleType);

        SET @VehicleID = SCOPE_IDENTITY();

        SELECT TOP 1 @ParkingSlotID = ParkingSlotID
        FROM ParkingSlot
        WHERE [Type] = 'Guest' AND [Status] = 'Available';

        IF @ParkingSlotID IS NOT NULL
        BEGIN
            UPDATE ParkingSlot
            SET [Status] = 'Occupied', VehicleID = @VehicleID
            WHERE ParkingSlotID = @ParkingSlotID;
        END;
    END;

    INSERT INTO VisitorLog (VisitorID, ResidentID, Purpose)
    VALUES (@VisitorID, @ResidentID, @visitPurpose);

    SELECT @ApartmentVisited = ApartmentID FROM Resident WHERE ResidentID = @ResidentID;

    SET @OutputMessage = CONCAT('Name: ', @FirstName, ' ', @LastName, ' | ');

    IF @LicensePlate IS NOT NULL AND @Make IS NOT NULL AND @Model IS NOT NULL AND @VehicleType IS NOT NULL
    BEGIN
        SET @OutputMessage = CONCAT(@OutputMessage, 'Vehicle parked at Slot: ', CAST(@ParkingSlotID AS VARCHAR(20)), ' | ');
    END;

    SET @OutputMessage = CONCAT(@OutputMessage, 'Apartment Visited: ', CAST(@ApartmentVisited AS VARCHAR(20)));
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Procedure to book an Amenity by Resident
CREATE OR ALTER PROCEDURE BookAmenity
    @AmenityID INT,
    @ResidentID INT,
    @BookingDate DATE,
    @StartTime TIME,
    @EndTime TIME,
    @BookingFee DECIMAL(10, 2),
    @NumOfAttendees INT,
    @OutputMessage VARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ReservationRequired BIT;
    DECLARE @AvailabilityHours VARCHAR(50);

    SELECT @ReservationRequired = ReservationRequired, @AvailabilityHours = AvailabilityHours
    FROM Amenity
    WHERE AmenityID = @AmenityID;

    IF @ReservationRequired = 0
    BEGIN
        INSERT INTO AmenityBooking (AmenityID, ResidentID, BookingDate, StartTime, EndTime, BookingFee, NumOfAttendees)
        VALUES (@AmenityID, @ResidentID, @BookingDate, @StartTime, @EndTime, @BookingFee, @NumOfAttendees);

        SET @OutputMessage = 'Amenity booked successfully.';
    END
    ELSE
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM Amenity
            WHERE AmenityID = @AmenityID
            AND CONVERT(TIME, LEFT(@AvailabilityHours, 5)) <= @StartTime
            AND CONVERT(TIME, RIGHT(@AvailabilityHours, 5)) >= @EndTime
        )
        BEGIN
            IF NOT EXISTS (
                SELECT 1
                FROM AmenityBooking
                WHERE AmenityID = @AmenityID
                AND BookingDate = @BookingDate
                AND (
                    (@StartTime >= StartTime AND @StartTime < EndTime)
                    OR (@EndTime > StartTime AND @EndTime <= EndTime)
                    OR (@StartTime <= StartTime AND @EndTime >= EndTime)
                )
            )
            BEGIN
                INSERT INTO AmenityBooking (AmenityID, ResidentID, BookingDate, StartTime, EndTime, BookingFee, NumOfAttendees)
                VALUES (@AmenityID, @ResidentID, @BookingDate, @StartTime, @EndTime, @BookingFee, @NumOfAttendees);

                SET @OutputMessage = 'Amenity booked successfully.';
            END
            ELSE
            BEGIN
                SET @OutputMessage = 'The selected time slot is not available for booking.';
            END
        END
        ELSE
        BEGIN
            SET @OutputMessage = 'The booking time is outside the available hours for this amenity.';
        END
    END
END;
GO

-- Procedure to book an random amenity bookings for today
CREATE OR ALTER PROCEDURE BookRandomAmenityToday
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ab INT = 1;
    DECLARE @AmenityID INT;
    DECLARE @BookingDate DATE;
    DECLARE @StartTime TIME;
    DECLARE @EndTime TIME;
    DECLARE @BookingFee DECIMAL(10, 2);
    DECLARE @NumOfAttendees INT;
    DECLARE @abOutputMsg VARCHAR(500);

    WHILE @ab <= 20
    BEGIN
        SELECT TOP 1 @AmenityID = AmenityID
        FROM Amenity
        ORDER BY NEWID();

        -- SET @BookingDate = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, GETDATE());
        SET @BookingDate = GETDATE();

        SELECT @StartTime = DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 120, '08:00'),
            @EndTime = DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 120 + 60, '08:00');

        IF @ab <= 10
            SET @BookingFee = ROUND(RAND() * 100, 2);
        ELSE
            SET @BookingFee = NULL;

        SET @NumOfAttendees = ABS(CHECKSUM(NEWID())) % 5 + 1;

        -- Execute the procedure
        EXEC dbo.BookAmenity 
            @AmenityID = @AmenityID,
            @ResidentID = @ab, 
            @BookingDate = @BookingDate, 
            @StartTime = @StartTime, 
            @EndTime = @EndTime, 
            @BookingFee = @BookingFee, 
            @NumOfAttendees = @NumOfAttendees, 
            @OutputMessage = @abOutputMsg OUTPUT;

        PRINT @abOutputMsg;

        SET @ab = @ab + 1;
    END
END;
--------------------------------------------------------------------------------------------------------------------------------