USE CMS;

--------------------------------------------------------------------------------------------------------------------------------
-- View to get summary of service requests
GO
CREATE VIEW ServiceRequestSummary 
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
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
GO
CREATE VIEW AmenityBookingsDetails
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
        WHEN ab.BookingFee > 0 THEN CAST(ab.BookingFee AS VARCHAR) + ' $'
        ELSE 'Free'
    END AS BookingFee,
    ab.NumOfAttendees
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
CREATE VIEW OccupiedParkingDetails
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
--------------------------------------------------------------------------------------------------------------------------------