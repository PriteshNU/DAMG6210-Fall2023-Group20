USE CMS;

--------------------------------------------------------------------------------------------------------------------------------
-- View to generate reports on service requests
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
-- views to generate reports on amenity bookings
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

GO
CREATE OR ALTER VIEW vw_TodayAmenityBookings AS
SELECT 
    A.AmenityID,
    A.[Name] AS AmenityName,
    A.[Location] AS AmenityLocation,
    AB.BookingDate,
    AB.StartTime,
    AB.EndTime,
    AB.NumOfAttendees,
    R.FirstName AS ResidentFirstName,
    R.LastName AS ResidentLastName
FROM AmenityBooking AB
JOIN Amenity A ON AB.AmenityID = A.AmenityID
JOIN Resident R ON AB.ResidentID = R.ResidentID
WHERE CONVERT(DATE, AB.BookingDate) = CONVERT(DATE, GETDATE());
GO

--------------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER VIEW vw_MonthlyVisitorCount AS
SELECT
    r.ResidentID,
    r.FirstName + ' ' + r.LastName AS ResidentName,
    YEAR(v.VisitDate) AS VisitYear,
    CASE 
        WHEN MONTH(v.VisitDate) = 1 THEN 'January'
        WHEN MONTH(v.VisitDate) = 2 THEN 'February'
        WHEN MONTH(v.VisitDate) = 3 THEN 'March'
        WHEN MONTH(v.VisitDate) = 4 THEN 'April'
		WHEN MONTH(v.VisitDate) = 5 THEN 'May'
		WHEN MONTH(v.VisitDate) = 6 THEN 'June'
		WHEN MONTH(v.VisitDate) = 7 THEN 'July'
		WHEN MONTH(v.VisitDate) = 8 THEN 'August'
		WHEN MONTH(v.VisitDate) = 9 THEN 'September'
		WHEN MONTH(v.VisitDate) = 10 THEN 'October'
		WHEN MONTH(v.VisitDate) = 11 THEN 'November'
		WHEN MONTH(v.VisitDate) = 12 THEN 'December'
    END AS VisitMonth,
    COUNT(*) AS VisitorCount
FROM
    Resident r
JOIN
    VisitorLog vl ON r.ResidentID = vl.ResidentID
JOIN 
    Visitor v ON vl.VisitorID = v.VisitorID
GROUP BY
    r.ResidentID,
    r.FirstName,
    r.LastName,
    YEAR(v.VisitDate),
    MONTH(v.VisitDate);

GO
--------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------
-- views to generate reports on parking
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

CREATE VIEW OccupiedGuestParking 
AS
SELECT 
    ps.ParkingSlotID,
    ps.[Type] AS ParkingSlotType,
    v.LicensePlate,
    v.Make,
    v.Model,
    vis.VisitorID,
    vis.FirstName,
    vis.LastName,
    vis.ExitTime
FROM 
    ParkingSlot ps
JOIN 
    Vehicle v ON ps.VehicleID = v.VehicleID
JOIN 
    Visitor vis ON v.OwnerID = vis.VisitorID
WHERE 
    ps.[Type] = 'Guest' AND 
    ps.[Status] = 'Occupied' AND
    vis.ExitTime IS NOT NULL;
GO
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- views to generate reports on residents and apartments
GO
CREATE VIEW vw_ApartmentResidentSummary 
AS
SELECT 
    b.BuildingID,
    b.[Name] AS BuildingName,
    b.[Number] AS BuildingNumber,
    a.ApartmentID,
    a.[Number] AS ApartmentNumber,
    COUNT(r.ResidentID) AS NumberOfResidents
FROM 
    Building b
JOIN 
    Apartment a ON b.BuildingID = a.BuildingID
LEFT JOIN 
    Resident r ON a.ApartmentID = r.ApartmentID
GROUP BY 
    b.BuildingID, 
    b.[Name], 
    b.[Number], 
    a.ApartmentID, 
    a.[Number];
GO