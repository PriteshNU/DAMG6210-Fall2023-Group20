USE CMS;

--------------------------------------------------------------------------------------------------------------------------------
-- Trigger to update the lease end date for tenant residents based on the start date of the lease
GO
CREATE TRIGGER trg_UpdateLeaseEndDate
ON Apartment
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE a
    SET a.LeaseEndDate = DATEADD(YEAR, 1, i.LeaseStartDate)
    FROM Apartment a
    INNER JOIN inserted i ON a.ApartmentID = i.ApartmentID
    INNER JOIN Resident r ON a.ApartmentID = r.ApartmentID
    WHERE r.OccupancyType = 'Tenant' AND i.LeaseStartDate IS NOT NULL;
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Trigger to generate a unique invoice number
GO
CREATE TRIGGER trg_SetInvoiceNumber
ON Invoice
AFTER INSERT
AS
BEGIN
    UPDATE Invoice
    SET Invoice.Number = 'INV-' + REPLACE(CONVERT(VARCHAR, Invoice.IssueDate, 112), '-', '') + '-' + RIGHT('0000' + CAST(Invoice.InvoiceID AS VARCHAR), 4)
    FROM Inserted i
    WHERE i.InvoiceID = i.InvoiceID;
END;
GO
--------------------------------------------------------------------------------------------------------------------------------