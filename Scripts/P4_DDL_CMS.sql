CREATE DATABASE CMS;
GO

USE CMS;


CREATE TABLE Building (
    BuildingID INT IDENTITY(1,1) NOT NULL,
    [Name] VARCHAR(255) NOT NULL,
    [Number] VARCHAR(50) NOT NULL,
    [Location] VARCHAR(255) NOT NULL,
    ConstructionYear INT NOT NULL,

    CONSTRAINT Building_PK PRIMARY KEY (BuildingID),
    CONSTRAINT Building_Number_Location_UQ UNIQUE ([Name], [Number])
);

--------------------------------------------------------------------------------------------------------------------------------
-- Function to generate unique apartment number based on building number
GO
CREATE FUNCTION GenerateApartmentNumber (@BuildingID INT, @ApartmentID INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @BuildingNumber VARCHAR(50);
    SELECT @BuildingNumber = [Number] FROM Building WHERE BuildingID = @BuildingID;
    RETURN @BuildingNumber + ' ' + CAST(@ApartmentID AS VARCHAR(20));
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Apartment (
    ApartmentID INT IDENTITY(100,1) NOT NULL,
    BuildingID INT NOT NULL,
    [Number] AS (dbo.GenerateApartmentNumber(BuildingID, ApartmentID)),
    NumOfBedrooms INT NOT NULL,
    NumOfBathrooms INT NOT NULL,
    [Status] VARCHAR(50) NOT NULL,
    LeaseStartDate DATE NULL,
    LeaseEndDate DATE NULL,

    CONSTRAINT Apartment_PK PRIMARY KEY (ApartmentID),
    CONSTRAINT Apartment_BuildingID_FK FOREIGN KEY (BuildingID) REFERENCES Building(BuildingID),

    CONSTRAINT Apartment_Status_CHK CHECK ([Status] IN ('Occupied', 'Available'))
);

CREATE TABLE Resident (
    ResidentID INT IDENTITY(1,1) NOT NULL,
    ApartmentID INT NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    EmergencyContact VARCHAR(20) NULL,
    OccupancyType VARCHAR(50) NOT NULL,
    SSN VARBINARY(MAX) NOT NULL

    CONSTRAINT Resident_PK PRIMARY KEY (ResidentID),
    CONSTRAINT Resident_ApartmentID_FK FOREIGN KEY (ApartmentID) REFERENCES Apartment(ApartmentID),
    CONSTRAINT Resident_OccupancyType_CHK CHECK (OccupancyType IN ('Owner', 'Tenant')),

    -- CONSTRAINT Resident_SSN_UQ UNIQUE (SSN)
);

CREATE TABLE Staff (
    StaffID INT IDENTITY(1,1) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    [Role] VARCHAR(255) NOT NULL,
    [Address] VARCHAR(1000) NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    SSN VARBINARY(MAX) NOT NULL,
    EmployeeStartDate DATE NOT NULL,
    EmploymentEndDate DATE NULL,

	CONSTRAINT Staff_PK PRIMARY KEY (StaffID),
    CONSTRAINT Staff_Role_CHK CHECK ([Role] IN ('ParkingCoordinator', 'Facilitator', 'Electrician', 'Plumber', 'GeneralMaintenance')),
);

CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) NOT NULL,
    ResidentID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME NOT NULL,
    PaymentType VARCHAR(50) NOT NULL,
    [Status] VARCHAR(50) NOT NULL, 
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentMethodLastFour VARCHAR(4) NULL,
    TransactionRefNum UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    CONSTRAINT Payment_PK PRIMARY KEY (PaymentID),
    CONSTRAINT Payment_ResidentID_FK FOREIGN KEY (ResidentID) REFERENCES Resident(ResidentID),
    
    CONSTRAINT Payment_PaymentType_CHK CHECK (PaymentType IN ('Maintenance', 'AmenityBooking', 'ServiceRequest')),
    CONSTRAINT Payment_Status_CHK CHECK ([Status] IN ('Paid', 'Partial', 'Cancelled')),
    CONSTRAINT Payment_PaymentMethod_CHK CHECK (PaymentMethod IN ('CC', 'ACH', 'Cash'))
);

--------------------------------------------------------------------------------------------------------------------------------
-- Function to generate unique invoice number
GO
CREATE FUNCTION GenerateInvoiceNumber (@InvoiceID INT, @IssueDate DATE)
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN 'INV-' + REPLACE(CONVERT(VARCHAR(20), @IssueDate, 112), '-', '') + '-' + RIGHT('0000' + CAST(@InvoiceID AS VARCHAR(20)), 4);
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Invoice (
    InvoiceID INT IDENTITY(1,1) NOT NULL,
    ApartmentID INT NOT NULL,
    [Number] AS (dbo.GenerateInvoiceNumber(InvoiceID, IssueDate)),
    IssueDate DATE NOT NULL DEFAULT GETDATE(),
    DueDate AS (DATEADD(MONTH, 1, IssueDate)),
    TotalAmount DECIMAL(10, 2) NOT NULL,
    [Status] VARCHAR(50) NOT NULL DEFAULT 'Issued',

    CONSTRAINT Invoice_PK PRIMARY KEY (InvoiceID),
    CONSTRAINT Invoice_ApartmentID_FK FOREIGN KEY (ApartmentID) REFERENCES Apartment(ApartmentID),

    CONSTRAINT Invoice_Status_CHK CHECK ([Status] IN ('Issued', 'Paid', 'Partial', 'Overdue'))
);

CREATE TABLE MaintenanceFee (
    PaymentID INT NOT NULL,
    InvoiceID INT NOT NULL,
    BalanceAmount DECIMAL(10, 2) NULL,

    CONSTRAINT MaintenanceFee_PK PRIMARY KEY (PaymentID, InvoiceID),
    CONSTRAINT MaintenanceFee_PaymentID_FK FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID),
    CONSTRAINT MaintenanceFee_InvoiceID_FK FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
);

--------------------------------------------------------------------------------------------------------------------------------
-- Function to generate unique service request number
GO
CREATE FUNCTION GenerateServiceRequestNumber (@ServiceRequestID INT, @RequestDate DATETIME)
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN 'SR-' + REPLACE(CONVERT(VARCHAR(20), @RequestDate, 112), '-', '') + '-' + RIGHT('0000' + CAST(@ServiceRequestID AS VARCHAR(20)), 4);
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ServiceRequest (
    ServiceRequestID INT IDENTITY(1,1) NOT NULL,
    ResidentID INT NOT NULL,
    [Number] AS (dbo.GenerateServiceRequestNumber(ServiceRequestID, RequestDate)),
    [Description] VARCHAR(2500) NULL,
    RequestType VARCHAR(50) NOT NULL,
    RequestDate DATE NOT NULL DEFAULT GETDATE(),
    ScheduledDate DATE,
    [Status] VARCHAR(50) NOT NULL,
    [Priority] VARCHAR(50),
    RequestFee DECIMAL(10, 2) NULL,
    StaffAssignedID INT NULL,

    CONSTRAINT ServiceRequest_PK PRIMARY KEY (ServiceRequestID),
    CONSTRAINT ServiceRequest_ResidentID_FK FOREIGN KEY (ResidentID) REFERENCES Resident(ResidentID),
    CONSTRAINT ServiceRequest_StaffAssignedID_FK FOREIGN KEY (StaffAssignedID) REFERENCES Staff(StaffID),

    CONSTRAINT ServiceRequest_RequestType_CHK CHECK ([RequestType] IN ('Plumbing', 'Electrical', 'Car Parking', 'Common Area', 'Other')),
    CONSTRAINT ServiceRequest_Priority_CHK CHECK ([Priority] IN ('High', 'Medium', 'Low')),
    CONSTRAINT ServiceRequest_Status_CHK CHECK ([Status] IN ('Open', 'Resolved'))
);

CREATE TABLE ServiceRequestFee (
    PaymentID INT NOT NULL,
    ServiceRequestID INT NOT NULL,

    CONSTRAINT ServiceRequestFee_PK PRIMARY KEY (PaymentID, ServiceRequestID),
    CONSTRAINT ServiceRequestFee_PaymentID_FK FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID),
    CONSTRAINT ServiceRequestFee_ServiceRequestID_FK FOREIGN KEY (ServiceRequestID) REFERENCES ServiceRequest(ServiceRequestID)
);

CREATE TABLE Visitor (
	VisitorID INT IDENTITY(1,1) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	ContactNumber VARCHAR(20) NOT NULL,
	VisitDate DATE NOT NULL,
	EntryTime DATETIME NOT NULL,
	ExitTime DATETIME NULL,

	CONSTRAINT Visitor_PK PRIMARY KEY (VisitorId)
);

CREATE TABLE VisitorLog (
	VisitorID INT NOT NULL,
	ResidentID INT NOT NULL,
	Purpose VARCHAR(255) NULL,

    CONSTRAINT VisitorLog_PK PRIMARY KEY (VisitorID, ResidentID),
    CONSTRAINT VisitorLog_VisitorID_FK FOREIGN KEY (VisitorID) REFERENCES Visitor(VisitorID),
    CONSTRAINT VisitorLog_ResidentID_FK FOREIGN KEY (ResidentID) REFERENCES Resident(ResidentID)
);

CREATE TABLE Vehicle (
	VehicleID INT IDENTITY(1,1) NOT NULL,
	OwnerID INT NOT NULL,
	LicensePlate VARCHAR(255) NOT NULL,
	Make VARCHAR(255) NULL,
	Model VARCHAR(255) NULL,
	[Type] VARCHAR(255) NULL,

	CONSTRAINT Vehicle_PK PRIMARY KEY (VehicleID),
    CONSTRAINT Vehicle_LicensePlate_UQ UNIQUE (LicensePlate)
);

CREATE TABLE ParkingSlot (
	ParkingSlotID INT IDENTITY(1,1) NOT NULL,
	VehicleID INT NULL,
	[Type] VARCHAR(50) NOT NULL,
	[Status] VARCHAR(50) NOT NULL,

	CONSTRAINT ParkingSlot_PK PRIMARY KEY (ParkingSlotID),
    CONSTRAINT ParkingSlot_VehicleID_FK FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),
    
    CONSTRAINT ParkingSlot_Type_CHK CHECK ([Type] IN ('Reserved', 'Guest')),
    CONSTRAINT ParkingSlot_Status_CHK CHECK ([Status] IN ('Occupied', 'Available')),
);

CREATE TABLE ReservedParking (
	ParkingSlotID INT NOT NULL,
	ApartmentID INT NOT NULL,

    CONSTRAINT ReservedParking_PK PRIMARY KEY (ParkingSlotID, ApartmentID),
    CONSTRAINT ReservedParking_ParkingSlotID_FK FOREIGN KEY (ParkingSlotID) REFERENCES ParkingSlot(ParkingSlotID),
    CONSTRAINT ReservedParking_ApartmentID_FK FOREIGN KEY (ApartmentID) REFERENCES Apartment(ApartmentID)
);

CREATE TABLE Amenity (
    AmenityID INT IDENTITY(1,1) NOT NULL,
    [Name] VARCHAR(255) NOT NULL,
    [Location] VARCHAR(255) NOT NULL,
    Capacity INT NOT NULL,
    AvailabilityHours VARCHAR(50) NOT NULL,
    ReservationRequired BIT NOT NULL DEFAULT 0,

    CONSTRAINT Amentity_PK PRIMARY KEY (AmenityID)
);

CREATE TABLE AmenityBooking (
    AmenityBookingID INT IDENTITY(1,1) NOT NULL,
    AmenityID INT NOT NULL,
    ResidentID INT NOT NULL,
    BookingDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    BookingFee DECIMAL(10, 2) NULL,
    NumOfAttendees INT NOT NULL,

	CONSTRAINT AmenityBooking_PK PRIMARY KEY (AmenityBookingID),
    CONSTRAINT AmenityBooking_AmenityID_FK FOREIGN KEY (AmenityID) REFERENCES Amenity(AmenityID),
    CONSTRAINT AmenityBooking_ResidentID_FK FOREIGN KEY (ResidentID) REFERENCES Resident(ResidentID)
);

CREATE TABLE AmenityBookingFee (
    PaymentID INT NOT NULL,
    AmenityBookingID INT NOT NULL,

    CONSTRAINT AmenityBookingFee_PK PRIMARY KEY (PaymentID, AmenityBookingID),
    CONSTRAINT AmenityBookingFee_PaymentID_FK FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID),
    CONSTRAINT AmenityBookingFee_AmenityBookingID_FK FOREIGN KEY (AmenityBookingID) REFERENCES AmenityBooking(AmenityBookingID)
);

CREATE TABLE IncidentLog (
    IncidentLogID INT IDENTITY(1,1) NOT NULL,
    IncidentDateTime DATETIME NOT NULL,
    IncidentLocation VARCHAR(255) NOT NULL,
    [Description] VARCHAR(2500) NULL,
    ActionTaken VARCHAR(2500) NULL,
    ReportedBy VARCHAR(255) NULL,
    HandledBy VARCHAR(255) NULL,
    [Status] VARCHAR(50) NOT NULL,

    CONSTRAINT IncidentLog_PK PRIMARY KEY (IncidentLogID),
	-- CONSTRAINT fk_reportedBy FOREIGN KEY (ReportedBy) REFERENCES staff(staffID), 
    -- CONSTRAINT fk_handledBy FOREIGN KEY (HandledBy)  REFERENCES staff(staffID)
);
