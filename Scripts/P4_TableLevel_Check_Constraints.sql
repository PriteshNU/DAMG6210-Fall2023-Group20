USE CMS;

ALTER TABLE Apartment
ADD CONSTRAINT Apartment_LeaseEndDate_CHK  CHECK (LeaseEndDate IS NULL OR LeaseEndDate > LeaseStartDate)

ALTER TABLE Staff
ADD CONSTRAINT Staff_EmploymentEndDate_CHK CHECK (EmploymentEndDate > EmployeeStartDate OR EmploymentEndDate IS NULL)

ALTER TABLE ServiceRequest
ADD CONSTRAINT ServiceRequest_ScheduledDate_CHK CHECK (ScheduledDate >= RequestDate OR ScheduledDate IS NULL)

ALTER TABLE Visitor
ADD CONSTRAINT Visitor_EntryExitTime_CHK CHECK (ExitTime IS NULL OR EntryTime < ExitTime)