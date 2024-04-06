USE CMS;

--------------------------------------------------------------------------------------------------------------------------------
-- Stored procedure to process payments of various payment types, 
-- including Maintenance charges, Service request fees, and Amenity booking fees. 

GO
CREATE OR ALTER PROCEDURE MakePayment
    @ResidentID INT,
    @Amount DECIMAL(10, 2),
    @PaymentType VARCHAR(50),
    @Method VARCHAR(50),
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

        -- Calculate the new balance after the current payment
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
    INSERT INTO Payment (ResidentID, Amount, PaymentDate, PaymentType, [Status], Method)
    VALUES (@ResidentID, @Amount, @PaymentDate, @PaymentType, CASE WHEN @BalanceAmount > 0 THEN 'Partial' ELSE 'Paid' END, @Method);

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
        INSERT INTO AmentityBookingFee (PaymentID, AmenityBookingID)
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