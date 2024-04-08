USE CMS;

--------------------------------------------------------------------------------------------------------------------------------
-- View to get summary of service requests
GO
CREATE OR ALTER VIEW vw_ServiceRequestSummary 
AS
SELECT
    sr.ServiceRequestID,
    sr.[Description],
    sr.RequestType,
    sr.RequestDate,
    sr.ScheduledDate,
    sr.[Status],
    sr.Priority,
    sr.RequestFee,
    CONCAT(r.FirstName, ' ', r.LastName) AS ResidentFullName,
    CONCAT(s.FirstName, ' ', s.LastName) AS StaffFullName
FROM
    ServiceRequest sr
    LEFT JOIN Resident r ON sr.ResidentID = r.ResidentID
    LEFT JOIN Staff s ON sr.StaffAssignedID = s.StaffID;
GO

GO
CREATE  OR ALTER VIEW vw_ServiceRequestByStatus AS
SELECT
    sr.Status,
    YEAR(sr.RequestDate) AS Year,
    MONTH(sr.RequestDate) AS Month,
    COUNT(*) AS NumberOfRequests
FROM
    ServiceRequest sr
GROUP BY
    sr.Status, YEAR(sr.RequestDate), MONTH(sr.RequestDate)
GO

GO
CREATE  OR ALTER VIEW vw_ServiceRequestByType
AS
SELECT
    sr.RequestType,
    COUNT(*) AS RequestCount
FROM
    ServiceRequest sr
WHERE
    sr.[Status] = 'Open'
GROUP BY
    sr.RequestType
GO

GO
CREATE  OR ALTER VIEW vw_ServiceRequestByPriority
AS
SELECT
    sr.Priority,
    COUNT(*) AS NumberOfRequests
FROM
    ServiceRequest sr
WHERE
    sr.[Status] = 'Open'
GROUP BY
    sr.Priority
GO

GO
CREATE  OR ALTER VIEW vw_StaffByMostServiceRequestAssigned
AS
SELECT TOP 5
        s.StaffID,
        s.FirstName + ' ' + s.LastName AS StaffName,
        COUNT(sr.ServiceRequestID) AS ServiceRequestCount
    FROM
        Staff s
    JOIN
        ServiceRequest sr ON s.StaffID = sr.StaffAssignedID
    WHERE
        sr.[Status] = 'Open'
    GROUP BY
        s.StaffID,
        s.FirstName,
        s.LastName
    ORDER BY
        COUNT(sr.ServiceRequestID) DESC;
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
GO
CREATE  OR ALTER VIEW vw_AmenityBookingsDetails
AS
SELECT
    ab.AmenityBookingID,
    a.Name AS AmenityName,
    r.ResidentID,
    r.FirstName + ' ' + r.LastName AS ResidentName,
    r.ContactNumber,
    ab.BookingDate,
    CONVERT(VARCHAR, ab.StartTime, 108) + ' - ' + CONVERT(VARCHAR, ab.EndTime, 108) AS BookingTime,
    ab.NumOfAttendees,
    CASE 
        WHEN ab.BookingFee > 0 THEN '$' + CAST(ab.BookingFee AS VARCHAR)
        ELSE 'N/A'
    END AS BookingFee
FROM
    AmenityBooking ab
JOIN
    Amenity a ON ab.AmenityID = a.AmenityID
JOIN
    Resident r ON ab.ResidentID = r.ResidentID
WHERE
    ab.BookingDate >= CAST(GETDATE() AS DATE);
GO
--------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------
GO
CREATE  OR ALTER VIEW vw_OccupiedParkingDetails
AS
SELECT
    ps.ParkingSlotID,
    CASE 
        WHEN r.ResidentID IS NOT NULL THEN 'Resident'
        WHEN v.VisitorID IS NOT NULL THEN 'Visitor'
        ELSE 'Unknown'
    END AS OccupantType,
    COALESCE(r.ResidentID, v.VisitorID) AS OccupantID,
    COALESCE(r.FirstName + ' ' + r.LastName, v.FirstName + ' ' + v.LastName) AS OccupantName,
    COALESCE(r.ContactNumber, v.ContactNumber) AS ContactNumber,
    COALESCE(vehicle.LicensePlate, 'N/A') AS VehicleLicense
FROM
    ParkingSlot ps
LEFT JOIN
    Resident r ON ps.VehicleID = r.ResidentID
LEFT JOIN
    Visitor v ON ps.VehicleID = v.VisitorID
LEFT JOIN
    Vehicle vehicle ON ps.VehicleID = vehicle.VehicleID
WHERE
    ps.Status = 'Occupied';
GO

GO
CREATE  OR ALTER VIEW vw_ParkingSlotUtilization AS
SELECT
    [Type],
    COUNT(*) AS TotalSlots,
    SUM(CASE WHEN [Status] = 'Occupied' THEN 1 ELSE 0 END) AS OccupiedSlots,
    SUM(CASE WHEN [Status] = 'Available' THEN 1 ELSE 0 END) AS AvailableSlots
FROM
    ParkingSlot
GROUP BY
    [Type];
GO

GO
CREATE  OR ALTER VIEW vw_VisitorParkingTrends AS
SELECT
    VisitorID,
    COUNT(*) AS NumberOfVisits,
    AVG(DATEDIFF(MINUTE, EntryTime, ExitTime)) AS AverageDuration,
    MAX(EntryTime) AS LastVisit
FROM
    Visitor
GROUP BY
    VisitorID;
GO

GO
CREATE  OR ALTER VIEW vw_VehicleParkingSlotMapping AS
SELECT
    v.LicensePlate,
    v.Make,
    v.Model,
    p.ParkingSlotID,
    p.[Type],
    p.[Status]
FROM
    Vehicle v
JOIN
    ParkingSlot p ON v.VehicleID = p.VehicleID;
GO
--------------------------------------------------------------------------------------------------------------------------------