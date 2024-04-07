USE CMS;

--------------------------------------------------------------------------------------------------------------------------------
-- View to get summary of service requests
GO
CREATE VIEW ServiceRequestSummary AS
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
