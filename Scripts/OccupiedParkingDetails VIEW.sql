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