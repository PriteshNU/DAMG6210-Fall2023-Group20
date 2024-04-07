USE CMS;

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for Building table
INSERT INTO Building ([Name], [Number], [Location], ConstructionYear)
VALUES
('Longwood', 'A', '1575 Tremont St', 2000),
('Longwood', 'B', '1575 Tremont St', 1995),
('Longwood', 'C', '1575 Tremont St', 1980),
('Lakeview', 'A', '1575 Tremont St', 2010),
('Lakeview', 'B', '1575 Tremont St', 2005),
('Jvue', 'Apt', '1575 Tremont St', 1990),
('Oakridge', 'Apt', '1575 Tremont St', 2015),
('Riverside', 'A', '1575 Tremont St', 2008),
('Riverside', 'B', '1575 Tremont St', 2003),
('MissionHill', 'A', '1575 Tremont St', 1998);
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for Apartment table
INSERT INTO Apartment (BuildingID, NumOfBedrooms, NumOfBathrooms, [Status], LeaseStartDate, LeaseEndDate)
VALUES
(1, 1, 1, 'Occupied', NULL, NULL),
(1, 2, 2, 'Available', NULL, NULL),
(1, 3, 2, 'Occupied', '2023-03-01', '2024-03-01'),
(1, 2, 1, 'Available', NULL, NULL),
(1, 1, 1, 'Occupied', '2023-05-01', '2024-05-01'),
(1, 3, 1, 'Occupied', '2023-07-01', '2024-07-01'),
(1, 2, 2, 'Available', NULL, NULL),
(1, 3, 2, 'Occupied', NULL, NULL),
(1, 1, 1, 'Occupied', '2023-11-01', '2024-11-01'),
(1, 2, 1, 'Available', NULL, NULL),
(2, 2, 1, 'Available', NULL, NULL),
(2, 1, 1, 'Occupied', NULL, NULL),
(2, 3, 2, 'Occupied', NULL, NULL),
(2, 2, 2, 'Available', NULL, NULL),
(2, 1, 1, 'Occupied', '2023-06-01', '2024-06-01'),
(2, 2, 1, 'Occupied', '2023-08-01', '2024-08-01'),
(2, 3, 1, 'Available', NULL, NULL),
(2, 1, 1, 'Occupied', NULL, NULL),
(2, 3, 2, 'Occupied', NULL, NULL),
(2, 2, 2, 'Available', NULL, NULL),
(3, 1, 1, 'Occupied', '2023-01-15', '2024-01-15'),
(3, 2, 1, 'Available', NULL, NULL),
(3, 3, 2, 'Occupied', NULL, NULL),
(3, 2, 2, 'Occupied', NULL, NULL),
(3, 1, 1, 'Available', NULL, NULL),
(4, 2, 1, 'Available', NULL, NULL),
(4, 1, 1, 'Occupied', '2023-04-10', '2024-04-10'),
(4, 3, 1, 'Available', NULL, NULL),
(4, 2, 2, 'Occupied', '2023-05-15', '2024-05-15'),
(4, 1, 1, 'Occupied', NULL, NULL),
(8, 2, 2, 'Occupied', '2023-01-05', '2024-01-05'),
(8, 1, 1, 'Available', NULL, NULL),
(8, 3, 1, 'Occupied', '2023-02-10', '2024-02-10'),
(8, 2, 1, 'Occupied', NULL, NULL),
(8, 1, 1, 'Available', NULL, NULL),
(9, 3, 2, 'Available', NULL, NULL),
(9, 2, 2, 'Occupied', '2023-04-20', '2024-04-20'),
(9, 1, 1, 'Available', NULL, NULL),
(9, 3, 1, 'Occupied', NULL, NULL),
(9, 2, 1, 'Occupied', NULL, NULL),
(10, 1, 1, 'Occupied', NULL, NULL),
(10, 2, 2, 'Available', NULL, NULL),
(10, 3, 2, 'Occupied', '2023-08-10', '2024-08-10'),
(10, 1, 1, 'Available', NULL, NULL),
(10, 2, 1, 'Occupied', NULL, NULL),
(5, 3, 2, 'Occupied', '2023-07-05', '2024-07-05'),
(5, 2, 2, 'Available', NULL, NULL),
(5, 1, 1, 'Occupied', NULL, NULL),
(5, 3, 1, 'Occupied', NULL, NULL),
(5, 2, 1, 'Available', NULL, NULL),
(6, 2, 1, 'Occupied', '2023-10-01', '2024-10-01'),
(6, 1, 1, 'Available', NULL, NULL),
(6, 3, 2, 'Occupied', '2023-11-05', '2024-11-05'),
(6, 2, 2, 'Available', NULL, NULL),
(6, 1, 1, 'Occupied', NULL, NULL),
(7, 3, 1, 'Available', NULL, NULL),
(7, 2, 1, 'Occupied', NULL, NULL),
(7, 1, 1, 'Available', NULL, NULL),
(7, 3, 2, 'Occupied', NULL, NULL),
(7, 2, 2, 'Occupied', NULL, NULL);
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for Resident table
OPEN SYMMETRIC KEY SSNEncryptionKey
DECRYPTION BY CERTIFICATE SSNEncryptionCert;

INSERT INTO Resident (ApartmentID, FirstName, LastName, ContactNumber, Email, EmergencyContact, OccupancyType, SSN)
VALUES
(100, 'John', 'Doe', '1234567890', 'john.doe100@email.com', '0987654321', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '123-45-6789')),
(102, 'Jane', 'Smith', '1234567891', 'jane.smith102@email.com', '0987654322', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '234-56-7890')),
(104, 'Alice', 'Brown', '1234567892', 'alice.brown104@email.com', '0987654323', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '345-67-8901')),
(105, 'Bob', 'Johnson', '1234567893', 'bob.johnson105@email.com', '0987654324', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '456-78-9012')),
(107, 'Carol', 'Williams', '1234567894', 'carol.williams107@email.com', '0987654325', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '567-89-0123')),
(108, 'David', 'Jones', '1234567895', 'david.jones108@email.com', '0987654326', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '678-90-1234')),
(111, 'Eve', 'Miller', '1234567896', 'eve.miller111@email.com', '0987654327', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '789-01-2345')),
(112, 'Frank', 'Wilson', '1234567897', 'frank.wilson112@email.com', '0987654328', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '890-12-3456')),
(114, 'Grace', 'Moore', '1234567898', 'grace.moore114@email.com', '0987654329', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '901-23-4567')),
(115, 'Henry', 'Taylor', '1234567899', 'henry.taylor115@email.com', '0987654330', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-5678')),
(117, 'Isla', 'Anderson', '1234567800', 'isla.anderson117@email.com', '0987654331', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '123-45-6789')),
(118, 'Jack', 'Thomas', '1234567801', 'jack.thomas118@email.com', '0987654332', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '234-56-7891')),
(120, 'Kim', 'Lee', '1234567802', 'kim.lee120@email.com', '0987654333', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '345-67-8902')),
(122, 'Liam', 'Scott', '1234567803', 'liam.scott122@email.com', '0987654334', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '456-78-8903')),
(123, 'Mia', 'Young', '1234567804', 'mia.young123@email.com', '0987654335', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '567-89-8904')),
(126, 'Noah', 'Edwards', '1234567805', 'noah.edwards126@email.com', '0987654336', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '678-90-8905')),
(128, 'Olivia', 'Harris', '1234567806', 'olivia.harris128@email.com', '0987654337', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '789-01-8906')),
(129, 'Ethan', 'Martinez', '1234567807', 'ethan.martinez129@email.com', '0987654338', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '890-12-8907')),
(130, 'Sophia', 'Clark', '1234567808', 'sophia.clark130@email.com', '0987654339', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '901-23-8908')),
(132, 'James', 'Rodriguez', '1234567809', 'james.rodriguez132@email.com', '0987654340', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-8909')),
(133, 'Isabella', 'Lewis', '1234567810', 'isabella.lewis133@email.com', '0987654341', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '123-45-8910')),
(136, 'Alexander', 'Nguyen', '1234567811', 'alexander.nguyen136@email.com', '0987654342', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '234-56-8911')),
(138, 'Charlotte', 'Hill', '1234567812', 'charlotte.hill138@email.com', '0987654343', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '345-67-8912')),
(139, 'Daniel', 'Evans', '1234567813', 'daniel.evans139@email.com', '0987654344', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '456-78-8913')),
(140, 'Emma', 'Wilson', '1234567814', 'emma.wilson140@email.com', '0987654345', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '567-89-8914')),
(142, 'Fiona', 'Garcia', '1234567815', 'fiona.garcia142@email.com', '0987654346', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '678-90-8915')),
(144, 'George', 'Martinez', '1234567816', 'george.martinez144@email.com', '0987654347', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '789-01-8916'));

CLOSE SYMMETRIC KEY SSNEncryptionKey;
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for the Staff table
OPEN SYMMETRIC KEY SSNEncryptionKey
DECRYPTION BY CERTIFICATE SSNEncryptionCert;
INSERT INTO Staff (FirstName, LastName, [Role], [Address], ContactNumber, Email, SSN, EmployeeStartDate, EmploymentEndDate)
VALUES
('John', 'Doe', 'ParkingCoordinator', '123 Maple Dr', '1234567890', 'john.doe@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '133-45-6789'), '2021-01-01', NULL),
('Jane', 'Smith', 'Facilitator', '456 Oak St', '2345678901', 'jane.smith@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '134-45-6789'), '2021-02-01', NULL),
('Alice', 'Brown', 'Electrician', '789 Pine Ln', '3456789012', 'alice.brown@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '135-45-6789'), '2021-03-01', NULL),
('Bob', 'Johnson', 'Plumber', '101 Walnut St', '4567890123', 'bob.johnson@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '136-45-6789'), '2021-04-01', NULL),
('Carol', 'Williams', 'GeneralMaintenance', '202 Cherry Ln', '5678901234', 'carol.williams@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '137-45-6789'), '2021-05-01', NULL),
('David', 'Jones', 'ParkingCoordinator', '303 Birch Dr', '6789012345', 'david.jones@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '138-45-6789'), '2021-06-01', NULL),
('Eve', 'Miller', 'Facilitator', '404 Cedar St', '7890123456', 'eve.miller@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '139-45-6789'), '2021-07-01', NULL),
('Frank', 'Wilson', 'Electrician', '505 Spruce Ave', '8901234567', 'frank.wilson@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '140-45-6789'), '2021-08-01', NULL),
('Grace', 'Moore', 'Plumber', '606 Redwood Rd', '9012345678', 'grace.moore@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '141-45-6789'), '2021-09-01', NULL),
('Henry', 'Taylor', 'GeneralMaintenance', '707 Aspen St', '0123456789', 'henry.taylor@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '142-45-6789'), '2021-10-01', NULL),
('Isabella', 'Anderson', 'ParkingCoordinator', '808 Willow Dr', '1234567890', 'isabella.anderson@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '143-45-6789'), '2022-01-01', NULL),
('Jack', 'Thomas', 'Facilitator', '909 Maple Ave', '2345678901', 'jack.thomas@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '144-45-6789'), '2022-02-01', NULL),
('Kim', 'Lee', 'Electrician', '111 Elm St', '3456789012', 'kim.lee@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '145-45-6789'), '2022-03-01', NULL),
('Liam', 'Scott', 'Plumber', '222 Magnolia Ln', '4567890123', 'liam.scott@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '146-45-6789'), '2022-04-01', NULL),
('Mia', 'Young', 'GeneralMaintenance', '333 Palm Dr', '5678901234', 'mia.young@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '147-45-6789'), '2022-05-01', NULL),
('Noah', 'Edwards', 'ParkingCoordinator', '444 Pineapple St', '6789012345', 'noah.edwards@email.com', EncryptByKey(Key_GUID('SSNEncryptionKey'), '148-45-6789'), '2022-06-01', NULL);

CLOSE SYMMETRIC KEY SSNEncryptionKey;
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for the Invoice table
INSERT INTO Invoice (ApartmentID, IssueDate,TotalAmount)
VALUES
(100, '2023-06-01', 2000.00), 
(102, '2023-05-01', 1600.00),
(102, '2023-06-01', 1750.00),
(102, '2023-07-01', 1900.00),
(104, '2023-06-01', 1650.00), 
(105, '2023-08-01', 1550.00), 
(105, '2023-09-01', 1650.00), 
(107, '2023-06-01', 1750.00),
(108, '2024-02-01', 1900.00),
(111, '2023-07-01', 1500.00),
(112, '2023-07-01', 1600.00),
(114, '2023-07-01', 1650.00),
(114, '2023-08-01', 1700.00),
(114, '2023-09-01', 1800.00),
(115, '2023-09-01', 1550.00),
(120, '2023-02-01', 1600.00),
(126, '2023-05-01', 1600.00),
(126, '2023-06-01', 1750.00),
(128, '2023-06-01', 1650.00),
(130, '2023-02-01', 1600.00),
(132, '2023-03-01', 1650.00),
(136, '2023-05-01', 1600.00),
(136, '2023-06-01', 1750.00),
(142, '2023-09-01', 1650.00),
(142, '2023-10-01', 1700.00),
(142, '2023-11-01', 1800.00);
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for the Payment table
INSERT INTO Payment (ResidentID, Amount, PaymentDate, PaymentType, [Status], PaymentMethod, PaymentMethodLastFour)
VALUES
(1, 100.00, '2023-01-15', 'Maintenance', 'Paid', 'CC', '1234'),
(2, 50.00, '2023-01-20', 'AmenityBooking', 'Paid', 'ACH', '5678'),
(3, 75.00, '2023-01-25', 'ServiceRequest', 'Partial', 'Cash', '9012'),
(4, 125.00, '2023-02-05', 'Maintenance', 'Paid', 'CC', '3456'),
(5, 60.00, '2023-02-10', 'AmenityBooking', 'Partial', 'ACH', '7890'),
(6, 80.00, '2023-02-15', 'ServiceRequest', 'Cancelled', 'Cash', '2345'),
(7, 150.00, '2023-03-05', 'Maintenance', 'Paid', 'CC', '6789'),
(8, 70.00, '2023-03-10', 'AmenityBooking', 'Paid', 'ACH', '0123'),
(9, 90.00, '2023-03-15', 'ServiceRequest', 'Partial', 'Cash', '4567'),
(10, 200.00, '2023-04-05', 'Maintenance', 'Paid', 'CC', '8901');
--------------------------------------------------------------------------------------------------------------------------------

-- Insert statements for the MaintenanceFee table
INSERT INTO MaintenanceFee (PaymentID, InvoiceID, BalanceAmount)
VALUES
(1, 1, 0.00),
(4, 2, 0.00),
(7, 3, 0.00),
(10, 4, 0.00);

-- Insert statements for the ServiceRequest table
INSERT INTO ServiceRequest (ResidentID, [Description], RequestType, RequestDate, ScheduledDate, [Status], [Priority], RequestFee, StaffAssignedID)
VALUES
(1, 'Leaky faucet', 'Plumbing', '2023-01-05', '2023-01-10', 'Completed', 'Medium', 50.00, 2),
(2, 'Broken window', 'Maintenance', '2023-01-10', '2023-01-15', 'In Progress', 'High', 75.00, 3),
(3, 'Clogged drain', 'Plumbing', '2023-01-15', NULL, 'Open', 'Low', 100.00, NULL),
(4, 'Faulty electrical outlet', 'Electrical', '2023-02-05', '2023-02-10', 'Completed', 'Medium', 125.00, 5),
(5, 'AC not working', 'HVAC', '2023-02-10', NULL, 'Open', 'High', 60.00, NULL),
(6, 'Broken lock', 'Security', '2023-02-15', '2023-02-20', 'Cancelled', 'Low', 80.00, 7),
(7, 'Leaking roof', 'Roofing', '2023-03-05', '2023-03-10', 'Completed', 'Medium', 150.00, 8),
(8, 'Paint chipping', 'Maintenance', '2023-03-10', '2023-03-15', 'In Progress', 'High', 70.00, 9),
(9, 'Furniture assembly', 'Furniture', '2023-03-15', NULL, 'Open', 'Low', 90.00, NULL),
(10, 'Pest control', 'Pest Control', '2023-04-05', '2023-04-10', 'Completed', 'Medium', 200.00, 10);

-- Insert statements for the ServiceRequestFee table
INSERT INTO ServiceRequestFee (PaymentID, ServiceRequestID)
VALUES
(3, 1),
(6, 2),
(9, 3),
(10, 4);

-- Insert statements for the Visitor table
INSERT INTO Visitor (FirstName, LastName, ContactNumber, VisitDate, EntryTime, ExitTime)
VALUES
('Emma', 'Miller', '1234567890', '2023-01-01', '08:00:00', '09:00:00'),
('Oliver', 'Brown', '2345678901', '2023-01-02', '09:00:00', '10:00:00'),
('Ava', 'Wilson', '3456789012', '2023-01-03', '10:00:00', '11:00:00'),
('James', 'Taylor', '4567890123', '2023-01-04', '11:00:00', '12:00:00'),
('Charlotte', 'Anderson', '5678901234', '2023-01-05', '12:00:00', '13:00:00'),
('Mia', 'Thomas', '6789012345', '2023-01-06', '13:00:00', '14:00:00'),
('Elijah', 'Jackson', '7890123456', '2023-01-07', '14:00:00', '15:00:00'),
('Harper', 'White', '8901234567', '2023-01-08', '15:00:00', '16:00:00'),
('Benjamin', 'Harris', '9012345678', '2023-01-09', '16:00:00', '17:00:00'),
('Amelia', 'Martin', '0123456789', '2023-01-10', '17:00:00', '18:00:00');

-- Insert statements for the VisitorLog table
INSERT INTO VisitorLog (VisitorID, ResidentID, Purpose)
VALUES
(1, 1, 'Meeting'),
(2, 2, 'Delivery'),
(3, 3, 'Social visit'),
(4, 4, 'Repair service'),
(5, 5, 'Guest'),
(6, 6, 'Family visit'),
(7, 7, 'Vendor visit'),
(8, 8, 'Maintenance'),
(9, 9, 'Appointment'),
(10, 10, 'Friend visit');

-- Insert statements for the Vehicle table
INSERT INTO Vehicle (OwnerID, LicensePlate, Make, Model, [Type])
VALUES
(1, 'ABC123', 'Toyota', 'Camry', 'Sedan'),
(2, 'XYZ456', 'Honda', 'Accord', 'Sedan'),
(3, '123ABC', 'Ford', 'F-150', 'Truck'),
(4, '456XYZ', 'Chevrolet', 'Malibu', 'Sedan'),
(5, 'DEF789', 'Toyota', 'RAV4', 'SUV'),
(6, 'GHI012', 'Nissan', 'Altima', 'Sedan'),
(7, '789DEF', 'BMW', 'X5', 'SUV'),
(8, 'JKL345', 'Tesla', 'Model S', 'Sedan'),
(9, 'MNO678', 'Jeep', 'Wrangler', 'SUV'),
(10, 'PQR901', 'Hyundai', 'Tucson', 'SUV');

-- Insert statements for the ParkingSlot table
INSERT INTO ParkingSlot (VehicleID, [Type], [Status])
VALUES
(1, 'Reserved', 'Occupied'),
(2, 'Guest', 'Available'),
(3, 'Reserved', 'Occupied'),
(4, 'Guest', 'Available'),
(5, 'Reserved', 'Occupied'),
(6, 'Guest', 'Available'),
(7, 'Reserved', 'Occupied'),
(8, 'Guest', 'Available'),
(9, 'Reserved', 'Occupied'),
(10, 'Guest', 'Available');

-- Insert statements for the ReservedParking table
INSERT INTO ReservedParking (ParkingSlotID, ApartmentID)
VALUES
(1, 1),
(3, 2),
(5, 3),
(7, 4),
(9, 5);

-- Insert statements for the Amenity table
INSERT INTO Amenity ([Name], [Location], Capacity, AvailabilityHours, ReservationRequired)
VALUES
('Gym', 'Building A, Floor 1', 20, '06:00 - 22:00', 0),
('Pool', 'Building B, Rooftop', 50, '08:00 - 20:00', 1),
('Clubhouse', 'Building C, Basement', 30, '09:00 - 23:00', 0),
('BBQ Area', 'Building D, Courtyard', 10, '10:00 - 18:00', 1),
('Business Center', 'Building E, Floor 2', 15, '08:00 - 18:00', 1),
('Dog Park', 'Building F, Park', 10, '07:00 - 19:00', 0),
('Playground', 'Building G, Courtyard', 20, '09:00 - 17:00', 0),
('Tennis Court', 'Building H, Rooftop', 2, '08:00 - 22:00', 1),
('Movie Theater', 'Building I, Floor 3', 25, '12:00 - 22:00', 1),
('Spa', 'Building J, Basement', 5, '10:00 - 20:00', 1);

ALTER TABLE Amenity
ALTER COLUMN AvailabilityHours VARCHAR(50)

-- Insert statements for the AmenityBooking table
INSERT INTO AmenityBooking (AmenityID, ResidentID, BookingDate, StartTime, EndTime, BookingFee, NumOfAttendees)
VALUES
(1, 1, '2023-01-01', '08:00:00', '09:00:00', 25.00, 1),
(2, 2, '2023-01-02', '09:00:00', '10:00:00', 30.00, 2),
(3, 3, '2023-01-03', '10:00:00', '11:00:00', 20.00, 3),
(4, 4, '2023-01-04', '11:00:00', '12:00:00', 15.00, 4),
(5, 5, '2023-01-05', '12:00:00', '13:00:00', 40.00, 5),
(6, 6, '2023-01-06', '13:00:00', '14:00:00', 35.00, 6),
(7, 7, '2023-01-07', '14:00:00', '15:00:00', 45.00, 7),
(8, 8, '2023-01-08', '15:00:00', '16:00:00', 50.00, 8),
(9, 9, '2023-01-09', '16:00:00', '17:00:00', 55.00, 9),
(10, 10, '2023-01-10', '17:00:00', '18:00:00', 60.00, 10);

-- Insert statements for the AmenityBookingFee table
INSERT INTO AmenityBookingFee (PaymentID, AmenityBookingID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert statements for the IncidentLog table
INSERT INTO IncidentLog (IncidentDateTime, IncidentLocation, [Description], ActionTaken, ReportedBy, HandledBy, [Status])
VALUES
('2023-01-01 08:00:00', 'Building A', 'Water leak in hallway', 'Fixed pipe and cleaned area', 'David Brown', 'Emma Johnson', 'Resolved'),
('2023-01-02 09:00:00', 'Building B', 'Elevator outage', 'Called technician for repairs', 'Emma Johnson', 'Ethan Williams', 'In Progress'),
('2023-01-03 10:00:00', 'Building C', 'Fire alarm triggered', 'False alarm, no fire detected', 'Ethan Williams', 'Olivia Jones', 'Closed'),
('2023-01-04 11:00:00', 'Building D', 'Suspicious activity in parking lot', 'Increased security patrols', 'Olivia Jones', 'Noah Garcia', 'Under Investigation'),
('2023-01-05 12:00:00', 'Building E', 'Power outage on floor 3', 'Contacted utility company for restoration', 'Noah Garcia', 'Ava Martinez', 'Resolved'),
('2023-01-06 13:00:00', 'Building F', 'Vandalism in common area', 'Reported incident to authorities', 'Ava Martinez', 'Liam Brown', 'Under Investigation'),
('2023-01-07 14:00:00', 'Building G', 'Broken entry gate', 'Called maintenance for repairs', 'Liam Brown', 'Sophia Taylor', 'In Progress'),
('2023-01-08 15:00:00', 'Building H', 'Theft in parking garage', 'Reviewed security footage', 'Sophia Taylor', 'Mason Thomas', 'Under Investigation'),
('2023-01-09 16:00:00', 'Building I', 'Flooding in basement', 'Sump pump failure', 'Mason Thomas', 'Amelia Roberts', 'In Progress'),
('2023-01-10 17:00:00', 'Building J', 'HVAC malfunction', 'Scheduled HVAC technician for repair', 'Amelia Roberts', 'Noah Garcia', 'In Progress');
