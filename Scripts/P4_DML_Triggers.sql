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