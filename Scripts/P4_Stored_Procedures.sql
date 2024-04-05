USE CMS;

--------------------------------------------------------------------------------------------------------------------------------
-- Trigger to update the lease end date for tenant residents based on the start date of the lease
GO
CREATE PROCEDURE MakePayment
    @ResidentID INT,
    @Amount DECIMAL(10, 2),
    @PaymentType VARCHAR(50),
    @Method VARCHAR(50),
    @EntityID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate Amount
    IF @Amount <= 0
    BEGIN
        RAISERROR ('Amount must be greater than zero.', 16, 1);
        RETURN;
    END

    -- Validate PaymentType
    IF @PaymentType NOT IN ('Maintenance', 'ServiceRequest', 'AmenityBooking')
    BEGIN
        RAISERROR ('Invalid PaymentType provided.', 16, 1);
        RETURN;
    END

    DECLARE @PaymentID INT;
    DECLARE @PaymentDate DATETIME = GETDATE();

    -- Insert into Payment table
    INSERT INTO Payment (ResidentID, Amount, PaymentDate, PaymentType, [Status], Method)
    VALUES (@ResidentID, @Amount, @PaymentDate, @PaymentType, 'Completed', @Method);

    SET @PaymentID = SCOPE_IDENTITY();

    -- Insert into respective fee table based on PaymentType
    IF @PaymentType = 'Maintenance'
    BEGIN
        INSERT INTO MaintenanceFee (PaymentID, InvoiceID, BalanceAmount)
        VALUES (@PaymentID, @EntityID, @Amount);
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