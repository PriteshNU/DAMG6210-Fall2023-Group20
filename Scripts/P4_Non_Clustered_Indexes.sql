--------------------------------------------------------------------------------------------------------------------------------
-- Non-Clustered Index to improve the performance of range queries and sorting
CREATE NONCLUSTERED INDEX IDX_Visitor_VisitDate ON Visitor (VisitDate);
CREATE NONCLUSTERED INDEX IDX_Invoice_IssueDate ON Invoice (IssueDate);
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Non-Clustered Index to improve the performance of common joins on foreign key relationships
CREATE NONCLUSTERED INDEX IDX_Apartment_BuildingID ON Apartment (BuildingID);
CREATE NONCLUSTERED INDEX IDX_Payment_ResidentID ON Payment (ResidentID);
CREATE NONCLUSTERED INDEX IDX_Invoice_ApartmentID ON Invoice (ApartmentID);
--------------------------------------------------------------------------------------------------------------------------------
