CREATE DATABASE CMS;
GO

USE CMS;


CREATE TABLE Building (
    BuildingID INT IDENTITY(1,1) NOT NULL,
    [Name] VARCHAR(255) NOT NULL,
    [Number] VARCHAR(50) NOT NULL,
    [Location] VARCHAR(255) NOT NULL,
    ConstructionYear INT,

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
    LeaseStartDate DATE,
    LeaseEndDate DATE,

    CONSTRAINT Apartment_PK PRIMARY KEY (ApartmentID),
    CONSTRAINT Apartment_BuildingID_FK FOREIGN KEY (BuildingID) REFERENCES Building(BuildingID),

    CONSTRAINT Apartment_Status_CHK CHECK ([Status] IN ('Occupied', 'Available'))
);

CREATE TABLE Resident (
    ResidentID INT IDENTITY(1,1) NOT NULL,
    ApartmentID INT NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(255),
    EmergencyContact VARCHAR(20),
    OccupancyType VARCHAR(50),
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
    [Address] VARCHAR(1000),
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(255),
    SSN VARBINARY(MAX) NOT NULL,
    EmployeeStartDate DATE NOT NULL,
    EmploymentEndDate DATE,

	CONSTRAINT Staff_PK PRIMARY KEY (StaffID)
);

CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) NOT NULL,
    ResidentID INT NOT NULL,
    Amount DECIMAL(10, 2),
    PaymentDate DATETIME,
    PaymentType VARCHAR(50),
    [Status] VARCHAR(50), 
    PaymentMethod VARCHAR(50),
    PaymentMethodLastFour VARCHAR(4),
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
    RETURN'INV-' + REPLACE(CONVERT(VARCHAR, @IssueDate, 112), '-', '') + '-' + RIGHT('0000' + CAST(@InvoiceID AS VARCHAR), 4);
END;
GO
--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Invoice (
    InvoiceID INT IDENTITY(1,1) NOT NULL,
    ApartmentID INT NOT NULL,
    [Number] AS (dbo.GenerateInvoiceNumber(IssueDate, InvoiceID)) PERSISTED,
    IssueDate DATE NOT NULL DEFAULT GETDATE(),
    DueDate AS (DATEADD(MONTH, 1, IssueDate)),
    TotalAmount DECIMAL(10, 2) NOT NULL,
    [Status] VARCHAR(50) DEFAULT 'Issued',

    CONSTRAINT Invoice_PK PRIMARY KEY (InvoiceID),
    CONSTRAINT Invoice_ApartmentID_FK FOREIGN KEY (ApartmentID) REFERENCES Apartment(ApartmentID),

    CONSTRAINT Invoice_Status_CHK CHECK ([Status] IN ('Issued', 'Paid', 'Overdue'))
);

CREATE TABLE MaintenanceFee (
    PaymentID INT NOT NULL,
    InvoiceID INT NOT NULL,
    BalanceAmount DECIMAL(10, 2),

    CONSTRAINT MaintenanceFee_PK PRIMARY KEY (PaymentID, InvoiceID),
    CONSTRAINT MaintenanceFee_PaymentID_FK FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID),
    CONSTRAINT MaintenanceFee_InvoiceID_FK FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
);

CREATE TABLE ServiceRequest (
    ServiceRequestID INT IDENTITY(1,1) NOT NULL,
    ResidentID INT NOT NULL,
    [Description] VARCHAR(2500),
    RequestType VARCHAR(50) NOT NULL,
    RequestDate DATE NOT NULL,
    ScheduledDate DATE,
    [Status] VARCHAR(50) NOT NULL,
    [Priority] VARCHAR(50),
    RequestFee DECIMAL(10, 2),
    StaffAssignedID INT,

    CONSTRAINT ServiceRequest_PK PRIMARY KEY (ServiceRequestID),
    CONSTRAINT ServiceRequest_ResidentID_FK FOREIGN KEY (ResidentID) REFERENCES Resident(ResidentID),
    CONSTRAINT ServiceRequest_StaffAssignedID_FK FOREIGN KEY (StaffAssignedID) REFERENCES Staff(StaffID),

    CONSTRAINT ServiceRequest_Priority_CHK CHECK ([Priority] IN ('High', 'Medium', 'Low'))
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
	ExitTime DATETIME,

	CONSTRAINT Visitor_PK PRIMARY KEY (VisitorId)
);

CREATE TABLE VisitorLog (
	VisitorID INT NOT NULL,
	ResidentID INT NOT NULL,
	Purpose VARCHAR(255),

    CONSTRAINT VisitorLog_PK PRIMARY KEY (VisitorID, ResidentID),
    CONSTRAINT VisitorLog_VisitorID_FK FOREIGN KEY (VisitorID) REFERENCES Visitor(VisitorID),
    CONSTRAINT VisitorLog_ResidentID_FK FOREIGN KEY (ResidentID) REFERENCES Resident(ResidentID)
);

CREATE TABLE Vehicle (
	VehicleID INT IDENTITY(1,1) NOT NULL,
	OwnerID INT NOT NULL,
	LicensePlate VARCHAR(255),
	Make VARCHAR(255),
	Model VARCHAR(255),
	[Type] VARCHAR(255),

	CONSTRAINT Vehicle_PK PRIMARY KEY (VehicleID),
    CONSTRAINT Vehicle_LicensePlate_UQ UNIQUE (LicensePlate)
);

CREATE TABLE ParkingSlot (
	ParkingSlotID INT IDENTITY(1,1) NOT NULL,
	VehicleID INT NOT NULL,
	[Type] VARCHAR(50),
	[Status] VARCHAR(50),

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
    AvailabilityHours TIME NOT NULL,
    ReservationRequired BIT,

    CONSTRAINT Amentity_PK PRIMARY KEY (AmenityID)
);

CREATE TABLE AmenityBooking (
    AmenityBookingID INT IDENTITY(1,1) NOT NULL,
    AmenityID INT NOT NULL,
    ResidentID INT NOT NULL,
    BookingDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    BookingFee DECIMAL(10, 2),
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
    [Description] VARCHAR(2500),
    ActionTaken VARCHAR(2500),
    ReportedBy VARCHAR(255),
    HandledBy VARCHAR(255),
    [Status] VARCHAR(50) NOT NULL,

    CONSTRAINT IncidentLog_PK PRIMARY KEY (IncidentLogID),
	-- CONSTRAINT fk_reportedBy FOREIGN KEY (ReportedBy) REFERENCES staff(staffID), 
    -- CONSTRAINT fk_handledBy FOREIGN KEY (HandledBy)  REFERENCES staff(staffID)
);



--VehicleID Column from ParkingSlot Table is again added
ALTER TABLE ParkingSlot ADD VehicleID INT;

--Set VehicleID as FK but as NULLABLE
ALTER TABLE ParkingSlot
ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID);
