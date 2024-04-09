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
-- owner data
(101, 'John', 'Doe', '1234567890', 'john.doe100@email.com', '0987654321', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '123-45-6789')),
(101, 'Bob', 'Johnson', '1234567893', 'bob.johnson105@email.com', '0987654324', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '456-78-9012')),
(108, 'Jane', 'Smith', '1234567891', 'jane.smith102@email.com', '0987654322', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '234-56-7890')),
(108, 'Carol', 'Williams', '1234567894', 'carol.williams107@email.com', '0987654325', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '567-89-0123')),
(108, 'David', 'Jones', '1234567895', 'david.jones108@email.com', '0987654326', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '678-90-1234')),
(112, 'Alice', 'Brown', '1234567892', 'alice.brown104@email.com', '0987654323', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '345-67-8901')),
(113, 'Bob', 'Johnson', '1234567893', 'bob.johnson105@email.com', '0987654324', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '456-78-9012')),
(118, 'Carol', 'Williams', '1234567894', 'carol.williams107@email.com', '0987654325', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '567-89-0123')),
(119, 'David', 'Jones', '1234567895', 'david.jones108@email.com', '0987654326', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '678-90-1234')),
(123, 'Eve', 'Miller', '1234567896', 'eve.miller111@email.com', '0987654327', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '789-01-2345')),
(124, 'Frank', 'Wilson', '1234567897', 'frank.wilson112@email.com', '0987654328', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '890-12-3456')),
(124, 'Isla', 'Anderson', '1234567800', 'isla.anderson117@email.com', '0987654331', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '123-45-6789')),
(130, 'Grace', 'Moore', '1234567898', 'grace.moore114@email.com', '0987654329', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '901-23-4567')),
(134, 'Henry', 'Taylor', '1234567899', 'henry.taylor115@email.com', '0987654330', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-5678')),
(139, 'Isla', 'Anderson', '1234567800', 'isla.anderson117@email.com', '0987654331', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '123-45-6789')),
(140, 'Jack', 'Thomas', '1234567801', 'jack.thomas118@email.com', '0987654332', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '234-56-7891')),
(141, 'Kim', 'Lee', '1234567802', 'kim.lee120@email.com', '0987654333', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '345-67-8902')),
(141, 'Frank', 'Wilson', '1234567897', 'frank.wilson112@email.com', '0987654328', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '890-12-3456')),
(145, 'Liam', 'Scott', '1234567803', 'liam.scott122@email.com', '0987654334', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '456-78-8903')),
(148, 'Mia', 'Young', '1234567804', 'mia.young123@email.com', '0987654335', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '567-89-8904')),
(149, 'Noah', 'Edwards', '1234567805', 'noah.edwards126@email.com', '0987654336', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '678-90-8905')),
(149, 'Sophia', 'Clark', '1234567808', 'sophia.clark130@email.com', '0987654339', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '901-23-8908')),
(149, 'James', 'Rodriguez', '1234567809', 'james.rodriguez132@email.com', '0987654340', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-8909')),
(149, 'Sophia', 'Clark', '1234567808', 'sophia.clark130@email.com', '0987654339', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '901-23-8908')),
(160, 'James', 'Rodriguez', '1234567809', 'james.rodriguez132@email.com', '0987654340', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-8909')),
(155, 'Olivia', 'Harris', '1234567806', 'olivia.harris128@email.com', '0987654337', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '789-01-8906')),
(157, 'Ethan', 'Martinez', '1234567807', 'ethan.martinez129@email.com', '0987654338', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '890-12-8907')),
(157, 'James', 'Rodriguez', '1234567809', 'james.rodriguez132@email.com', '0987654340', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-8909')),
(159, 'Sophia', 'Clark', '1234567808', 'sophia.clark130@email.com', '0987654339', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '901-23-8908')),
(160, 'James', 'Rodriguez', '1234567809', 'james.rodriguez132@email.com', '0987654340', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-8909')),

-- tenant data
(103, 'John', 'Doe', '1234567890', 'john.doe100@email.com', '0987654321', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '123-45-6789')),
(105, 'Jane', 'Smith', '1234567891', 'jane.smith102@email.com', '0987654322', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '234-56-7890')),
(105, 'Jack', 'Thomas', '1234567801', 'jack.thomas118@email.com', '0987654332', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '234-56-7891')),
(105, 'Kim', 'Lee', '1234567802', 'kim.lee120@email.com', '0987654333', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '345-67-8902')),
(106, 'Alice', 'Brown', '1234567892', 'alice.brown104@email.com', '0987654323', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '345-67-8901')),
(109, 'Bob', 'Johnson', '1234567893', 'bob.johnson105@email.com', '0987654324', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '456-78-9012')),
(109, 'Liam', 'Scott', '1234567803', 'liam.scott122@email.com', '0987654334', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '456-78-8903')),
(115, 'Carol', 'Williams', '1234567894', 'carol.williams107@email.com', '0987654325', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '567-89-0123')),
(116, 'David', 'Jones', '1234567895', 'david.jones108@email.com', '0987654326', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '678-90-1234')),
(121, 'Eve', 'Miller', '1234567896', 'eve.miller111@email.com', '0987654327', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '789-01-2345')),
(127, 'Frank', 'Wilson', '1234567897', 'frank.wilson112@email.com', '0987654328', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '890-12-3456')),
(127, 'Grace', 'Moore', '1234567898', 'grace.moore114@email.com', '0987654329', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '901-23-4567')),
(127, 'Henry', 'Taylor', '1234567899', 'henry.taylor115@email.com', '0987654330', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-5678')),
(129, 'Grace', 'Moore', '1234567898', 'grace.moore114@email.com', '0987654329', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '901-23-4567')),
(131, 'Henry', 'Taylor', '1234567899', 'henry.taylor115@email.com', '0987654330', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-5678')),
(133, 'Isla', 'Anderson', '1234567800', 'isla.anderson117@email.com', '0987654331', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '123-45-6789')),
(133, 'Alice', 'Brown', '1234567892', 'alice.brown104@email.com', '0987654323', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '345-67-8901')),
(137, 'Jack', 'Thomas', '1234567801', 'jack.thomas118@email.com', '0987654332', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '234-56-7891')),
(143, 'Kim', 'Lee', '1234567802', 'kim.lee120@email.com', '0987654333', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '345-67-8902')),
(146, 'Liam', 'Scott', '1234567803', 'liam.scott122@email.com', '0987654334', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '456-78-8903')),
(151, 'Mia', 'Young', '1234567804', 'mia.young123@email.com', '0987654335', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '567-89-8904')),
(151, 'Jane', 'Smith', '1234567891', 'jane.smith102@email.com', '0987654322', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '234-56-7890')),
(153, 'Noah', 'Edwards', '1234567805', 'noah.edwards126@email.com', '0987654336', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '678-90-8905')),
(153, 'Olivia', 'Harris', '1234567806', 'olivia.harris128@email.com', '0987654337', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '789-01-8906')),
(153, 'Ethan', 'Martinez', '1234567807', 'ethan.martinez129@email.com', '0987654338', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '890-12-8907')),
(153, 'James', 'Rodriguez', '1234567809', 'james.rodriguez132@email.com', '0987654340', 'Tenant', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-8909'));

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
INSERT INTO Invoice (ApartmentID, IssueDate, TotalAmount)
VALUES
(101, '2024-01-01', 2000.00),
(101, '2024-02-01', 2000.00),
(103, '2024-01-01', 5000.00),
(103, '2024-02-01', 5000.00),
(105, '2024-02-01', 5000.00),
(106, '2024-03-01', 5000.00),
(108, '2024-01-01', 2000.00),
(108, '2024-02-01', 2000.00),
(108, '2024-03-01', 2000.00), 
(109, '2024-01-01', 3000.00), 
(112, '2024-02-01', 3000.00), 
(112, '2024-03-01', 3000.00), 
(112, '2024-04-01', 3000.00), 
(113, '2024-01-01', 2000.00),
(115, '2024-01-01', 2000.00),
(115, '2024-02-01', 2000.00),
(116, '2024-02-01', 3000.00),
(118, '2024-03-01', 5000.00),
(119, '2024-01-01', 3000.00),
(121, '2024-02-01', 3000.00),
(121, '2024-03-01', 3000.00),
(121, '2024-04-01', 3000.00),
(123, '2024-03-01', 3000.00),
(123, '2024-04-01', 3000.00),
(124, '2024-01-01', 5000.00),
(127, '2024-01-01', 2000.00),
(129, '2024-01-01', 5000.00),
(129, '2024-02-01', 5000.00),
(130, '2024-02-01', 5000.00),
(131, '2024-03-01', 5000.00),
(133, '2024-01-01', 2000.00),
(133, '2024-02-01', 2000.00),
(133, '2024-03-01', 2000.00),
(133, '2024-04-01', 2000.00),
(133, '2024-05-01', 2000.00),
(133, '2024-06-01', 2000.00),
(134, '2024-01-01', 5000.00),
(137, '2024-01-01', 5000.00),
(139, '2024-02-01', 5000.00),
(140, '2024-01-01', 2000.00),
(141, '2024-02-01', 2000.00),
(143, '2024-03-01', 2000.00),
(143, '2024-04-01', 2000.00),
(143, '2024-05-01', 2000.00),
(145, '2024-01-01', 2000.00),
(146, '2024-01-01', 5000.00),
(148, '2024-02-01', 5000.00),
(148, '2024-03-01', 5000.00),
(148, '2024-04-01', 5000.00),
(149, '2024-03-01', 5000.00),
(151, '2024-01-01', 2000.00), 
(153, '2024-01-01', 3000.00), 
(155, '2024-02-01', 3000.00), 
(155, '2024-03-01', 3000.00), 
(157, '2024-01-01', 2000.00),
(157, '2024-02-01', 2000.00),
(159, '2024-01-01', 2000.00),
(160, '2024-02-01', 3000.00);
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for the Payment table
DECLARE @paymentOutputMsg VARCHAR(500);
DECLARE @paymentCounter INT = 1;
DECLARE @MaxRownum INT;

DECLARE @InvoiceDataTemp TABLE (
    Rownum INT IDENTITY(1,1),
    ResidentID INT,
    InvoiceID INT,
    InvoiceTotalAmount DECIMAL(10, 2)
);

INSERT INTO @InvoiceDataTemp (ResidentID, InvoiceID, InvoiceTotalAmount)
SELECT DISTINCT r.ResidentID, i.InvoiceID, i.TotalAmount
FROM Invoice i
JOIN Apartment a ON a.ApartmentID = i.ApartmentID
JOIN Resident r ON r.ApartmentID = a.ApartmentID
WHERE i.[Status] != 'Paid';

SELECT @MaxRownum = MAX(Rownum) FROM @InvoiceDataTemp;
DECLARE @Midpoint INT = (@MaxRownum / 2) + (@MaxRownum % 2);

WHILE @paymentCounter <= @MaxRownum
BEGIN
    DECLARE @CurrentResidentID INT;
    DECLARE @CurrentInvoiceID INT;
    DECLARE @CurrentTotalAmount DECIMAL(10, 2);

    SELECT @CurrentResidentID = ResidentID, @CurrentInvoiceID= InvoiceID, @CurrentTotalAmount = InvoiceTotalAmount
    FROM @InvoiceDataTemp
    WHERE Rownum = @paymentCounter;

    IF @paymentCounter > @Midpoint
    BEGIN
        SET @CurrentTotalAmount = @CurrentTotalAmount - 500;
    END

    EXEC dbo.MakePayment @ResidentID = @CurrentResidentID, @Amount = @CurrentTotalAmount, @PaymentType = 'Maintenance', @PaymentMethod = 'CC', @PaymentMethodLastFour = '1979', @EntityID = @CurrentInvoiceID, @OutputMessage = @paymentOutputMsg OUTPUT;

    PRINT @paymentOutputMsg;

    SET @paymentCounter = @paymentCounter + 1;
END;


DECLARE @srPaymentOutputMsg VARCHAR(500);
DECLARE @srPaymentCounter INT = 1;
DECLARE @srMaxRownum INT;

DECLARE @ServiceRequestDataTemp TABLE (
    Rownum INT IDENTITY(1,1),
    ResidentID INT,
    ServiceRequestID INT,
    RequestFee DECIMAL(10, 2)
);

INSERT INTO @ServiceRequestDataTemp (ResidentID, ServiceRequestID, RequestFee)
SELECT DISTINCT TOP 30 sr.ResidentID, sr.ServiceRequestID, sr.RequestFee
FROM ServiceRequest sr
WHERE sr.Status = 'Open' AND sr.RequestType IN ('Plumbing', 'Electrical');

SELECT @srMaxRownum = MAX(Rownum) FROM @ServiceRequestDataTemp;

WHILE @srPaymentCounter <= @srMaxRownum
BEGIN
    DECLARE @CurrentResidentID INT;
    DECLARE @CurrentServiceRequestID INT;
    DECLARE @CurrentRequestFee DECIMAL(10, 2);

    SELECT @CurrentResidentID = ResidentID, @CurrentServiceRequestID = ServiceRequestID, @CurrentRequestFee = RequestFee
    FROM @ServiceRequestDataTemp
    WHERE Rownum = @srPaymentCounter;

    EXEC dbo.MakePayment @ResidentID = @CurrentResidentID, @Amount = @CurrentRequestFee, @PaymentType = 'ServiceRequest', @PaymentMethod = 'CC', @PaymentMethodLastFour = '1979', @EntityID = @CurrentServiceRequestID, @OutputMessage = @srPaymentOutputMsg OUTPUT;

    PRINT @srPaymentOutputMsg;

    IF @srPaymentOutputMsg = 'Payment successful for Service Request'
    BEGIN
        UPDATE ServiceRequest
        SET [Status] = 'Resolved'
        WHERE ServiceRequestID = @CurrentServiceRequestID;
    END


    SET @srPaymentCounter = @srPaymentCounter + 1;
END;

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for the ServiceRequest table
DECLARE @sr INT = 1;
DECLARE @RequestType VARCHAR(50);
DECLARE @ScheduledDate DATE;
DECLARE @Priority VARCHAR(50);
DECLARE @srOutputMsg VARCHAR(500);

WHILE @sr <= 20
BEGIN
    SET @RequestType = CASE ABS(CHECKSUM(NEWID())) % 5
                            WHEN 0 THEN 'Plumbing'
                            WHEN 1 THEN 'Electrical'
                            WHEN 2 THEN 'Car Parking'
                            WHEN 3 THEN 'Common Area'
                            ELSE 'Other'
                        END;

    SET @ScheduledDate = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, GETDATE() + 1);

    SET @Priority = CASE ABS(CHECKSUM(NEWID())) % 3
                        WHEN 0 THEN 'High'
                        WHEN 1 THEN 'Medium'
                        ELSE 'Low'
                    END;

    EXEC dbo.SubmitServiceRequest 
        @ResidentID = @sr, 
        @Description = 'Test Description', 
        @RequestType = @RequestType, 
        @ScheduledDate = @ScheduledDate, 
        @Priority = @Priority, 
        @RequestFee = NULL, 
        @OutputMessage = @srOutputMsg OUTPUT;

    PRINT @srOutputMsg;

    SET @sr = @sr + 1;
END;
--------------------------------------------------------------------------------------------------------------------------------


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
(1, 'ABC123', 'Toyota', 'Corolla', 'Sedan'),
(2, 'XYZ456', 'Honda', 'Civic', 'Sedan'),
(3, 'DEF789', 'Ford', 'F-150', 'Truck'),
(4, 'GHI012', 'Chevrolet', 'Malibu', 'Sedan'),
(5, 'JKL345', 'Nissan', 'Altima', 'Sedan'),
(6, 'MNO678', 'BMW', 'X5', 'SUV'),
(7, 'PQR901', 'Mercedes', 'E-Class', 'Sedan'),
(8, 'STU234', 'Audi', 'A4', 'Sedan'),
(9, 'VWX567', 'Toyota', 'Camry', 'Sedan'),
(10, 'YZA890', 'Ford', 'Mustang', 'Coupe');

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

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for the Amenity table
INSERT INTO Amenity ([Name], [Location], Capacity, AvailabilityHours, ReservationRequired)
VALUES
('Gym', 'Longwood A, Floor 1', 20, '06:00 - 22:00', 0),
('Pool', 'Clubhouse, GroundFloor', 50, '08:00 - 20:00', 1),
('BBQ Area', 'Longwood B, Courtyard', 10, '10:00 - 18:00', 1),
('Business Center', 'Oakridge Apt, Floor 2', 15, '08:00 - 18:00', 1),
('Dog Park', 'MissionHill A, Park', 10, '07:00 - 19:00', 0),
('Playground', 'Lakeview A, Courtyard', 20, '09:00 - 17:00', 0),
('Tennis Court', 'Clubhouse, Rooftop', 2, '08:00 - 22:00', 1),
('Golf Court', 'Riverside, Front', 2, '08:00 - 22:00', 1),
('Movie Theater', 'Clubhouse, Floor 3', 25, '12:00 - 22:00', 0),
('Spa', 'Clubhouse, Basement', 5, '10:00 - 20:00', 1);
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for the randomly generating data for AmenityBooking table
DECLARE @ab INT = 1;
DECLARE @AmenityID INT;
DECLARE @BookingDate DATE;
DECLARE @StartTime TIME;
DECLARE @EndTime TIME;
DECLARE @BookingFee DECIMAL(10, 2);
DECLARE @NumOfAttendees INT;
DECLARE @abOutputMsg VARCHAR(500);

WHILE @ab <= 20
BEGIN
    SELECT TOP 1 @AmenityID = AmenityID
    FROM Amenity
    ORDER BY NEWID();

    SET @BookingDate = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, GETDATE());
    -- SET @BookingDate = GETDATE();

    SELECT @StartTime = DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 120, '08:00'),
           @EndTime = DATEADD(MINUTE, ABS(CHECKSUM(NEWID())) % 120 + 60, '08:00');

    IF @ab <= 10
        SET @BookingFee = ROUND(RAND() * 100, 2);
    ELSE
        SET @BookingFee = NULL;

    SET @NumOfAttendees = ABS(CHECKSUM(NEWID())) % 5 + 1;

    -- Execute the procedure
    EXEC dbo.BookAmenity 
        @AmenityID = @AmenityID,
        @ResidentID = @ab, 
        @BookingDate = @BookingDate, 
        @StartTime = @StartTime, 
        @EndTime = @EndTime, 
        @BookingFee = @BookingFee, 
        @NumOfAttendees = @NumOfAttendees, 
        @OutputMessage = @abOutputMsg OUTPUT;

    PRINT @abOutputMsg;

    SET @ab = @ab + 1;
END;
--------------------------------------------------------------------------------------------------------------------------------
--Parkinf Slot Insertion
SET IDENTITY_INSERT [dbo].[ParkingSlot] ON 

INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (1, 1, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (2, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (3, 2, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (4, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (5, 3, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (6, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (7, 4, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (8, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (9, 5, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (10, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (11, 6, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (12, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (13, 7, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (14, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (15, 8, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (16, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (17, 9, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (18, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (19, 10, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (20, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (21, 11, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (22, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (23, 12, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (24, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (25, 13, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (26, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (27, 14, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (28, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (29, 15, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (30, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (31, 16, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (32, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (33, 17, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (34, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (35, 18, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (36, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (37, 19, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (38, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (39, 20, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (40, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (41, 21, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (42, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (43, 22, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (44, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (45, 23, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (46, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (47, 24, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (48, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (49, 25, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (50, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (51, 26, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (52, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (53, 27, N'Reserved', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (54, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (55, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (56, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (57, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (58, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (59, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (60, NULL, N'Reserved', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (61, 28, N'Guest', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (62, 29, N'Guest', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (63, 30, N'Guest', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (64, 31, N'Guest', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (65, 32, N'Guest', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (66, 33, N'Guest', N'Occupied')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (67, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (68, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (69, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (70, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (71, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (72, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (73, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (74, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (75, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (76, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (77, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (78, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (79, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (80, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (81, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (82, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (83, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (84, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (85, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (86, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (87, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (88, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (89, NULL, N'Guest', N'Available')
INSERT [dbo].[ParkingSlot] ([ParkingSlotID], [VehicleID], [Type], [Status]) VALUES (90, NULL, N'Guest', N'Available')
SET IDENTITY_INSERT [dbo].[ParkingSlot] OFF
----------------------------------------------------------------------
-- Reserved Parking
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (1, 100)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (2, 101)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (3, 102)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (4, 103)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (5, 104)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (6, 105)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (7, 106)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (8, 107)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (9, 108)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (10, 109)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (11, 110)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (12, 111)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (13, 112)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (14, 113)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (15, 114)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (16, 115)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (17, 116)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (18, 117)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (19, 118)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (20, 119)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (21, 120)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (22, 121)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (23, 122)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (24, 123)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (25, 124)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (26, 125)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (27, 126)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (28, 127)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (29, 128)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (30, 129)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (31, 130)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (32, 131)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (33, 132)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (34, 133)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (35, 134)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (36, 135)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (37, 136)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (38, 137)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (39, 138)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (40, 139)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (41, 140)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (42, 141)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (43, 142)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (44, 143)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (45, 144)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (46, 145)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (47, 146)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (48, 147)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (49, 148)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (50, 149)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (51, 150)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (52, 151)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (53, 152)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (54, 153)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (55, 154)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (56, 155)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (57, 156)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (58, 157)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (59, 158)
INSERT [dbo].[ReservedParking] ([ParkingSlotID], [ApartmentID]) VALUES (60, 159)
----------------------------------------------------------------------------------

SET IDENTITY_INSERT [dbo].[Vehicle] ON 

INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (1, 1, N'ABC123', N'Toyota', N'Camry', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (2, 2, N'XYZ456', N'Honda', N'Accord', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (3, 3, N'DEF789', N'Ford', N'Fusion', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (4, 4, N'GHI012', N'Chevrolet', N'Malibu', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (5, 5, N'JKL345', N'Tesla', N'Model S', N'Electric')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (6, 6, N'MNO678', N'BMW', N'X5', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (7, 7, N'PQR901', N'Toyota', N'Corolla', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (8, 8, N'STU234', N'Nissan', N'Altima', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (9, 9, N'VWX567', N'Honda', N'Civic', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (10, 10, N'YZA890', N'Ford', N'Explorer', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (11, 11, N'ABC987', N'Chevrolet', N'Impala', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (12, 12, N'XYZ654', N'Toyota', N'RAV4', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (13, 13, N'DEF321', N'Honda', N'Pilot', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (14, 14, N'GHI688', N'Ford', N'Mustang', N'Coupe')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (15, 15, N'JKL445', N'Tesla', N'Model 3', N'Electric')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (16, 16, N'MNO002', N'BMW', N'3 Series', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (17, 17, N'PQR889', N'Nissan', N'Sentra', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (18, 18, N'STU656', N'Toyota', N'Highlander', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (19, 19, N'VWX923', N'Honda', N'CR-V', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (20, 20, N'YZA790', N'Ford', N'F-150', N'Truck')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (21, 21, N'ABC567', N'Chevrolet', N'Silverado', N'Truck')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (22, 22, N'XYZ234', N'Toyota', N'Tacoma', N'Truck')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (23, 23, N'DEF901', N'Honda', N'Ridgeline', N'Truck')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (24, 24, N'GHI678', N'Ford', N'Expedition', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (25, 25, N'JKL346', N'Tesla', N'Model X', N'Electric')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (26, 26, N'MNO012', N'BMW', N'X3', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (27, 27, N'PQR789', N'Nissan', N'Rogue', N'SUV')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (28, 4, N'MA1245785', N'Toyota', N'Etios', N'Sedan')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (29, 7, N'MA587456', N'Audi', N'R8', N'Sports')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (30, 8, N'MD587456', N'Audi', N'R8', N'Coupe')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (31, 9, N'CA895478', N'Audi', N'R8', N'Coupe')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (32, 10, N'TX456785', N'Ford', N'F5', N'Truck')
INSERT [dbo].[Vehicle] ([VehicleID], [OwnerID], [LicensePlate], [Make], [Model], [Type]) VALUES (33, 13, N'WA89454212', N'Chevy', N'Camaro', N'Sport')
SET IDENTITY_INSERT [dbo].[Vehicle] OFF
GO
SET IDENTITY_INSERT [dbo].[Visitor] ON 

INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (1, N'Yash', N'L', N'977644321', CAST(N'2024-04-07' AS Date), CAST(N'2024-04-08T12:18:05.460' AS DateTime), CAST(N'2024-04-08T12:55:07.460' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (2, N'Mike', N'Ross', N'877644321', CAST(N'2024-04-08' AS Date), CAST(N'2024-04-08T12:20:10.120' AS DateTime), CAST(N'2024-04-08T13:23:16.120' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (3, N'Mike', N'Ross', N'877644321', CAST(N'2024-03-08' AS Date), CAST(N'2024-04-08T12:26:18.100' AS DateTime), CAST(N'2024-04-08T14:16:18.100' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (4, N'John', N'Snow', N'877644321', CAST(N'2024-02-08' AS Date), CAST(N'2024-04-08T12:27:57.270' AS DateTime), CAST(N'2024-04-08T13:07:17.270' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (5, N'Eoin', N'Morgan', N'8747644321', CAST(N'2024-04-08' AS Date), CAST(N'2024-04-08T12:28:47.377' AS DateTime), CAST(N'2024-04-08T15:30:47.377' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (6, N'Eoin', N'Morgan', N'8747644321', CAST(N'2024-01-08' AS Date), CAST(N'2024-04-08T12:29:16.163' AS DateTime), CAST(N'2024-04-08T13:09:16.163' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (7, N'Ajay', N'Singh', N'8747644321', CAST(N'2024-02-08' AS Date), CAST(N'2024-04-08T12:52:38.713' AS DateTime), CAST(N'2024-04-08T13:59:38.713' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (8, N'Nathan', N'Maclaren', N'8947644321', CAST(N'2024-02-08' AS Date), CAST(N'2024-04-08T15:32:04.953' AS DateTime), CAST(N'2024-04-08T16:32:04.953' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (9, N'Pritesh', N'N', N'8949644321', CAST(N'2024-05-08' AS Date), CAST(N'2024-04-08T15:50:47.273' AS DateTime), CAST(N'2024-04-08T16:10:47.273' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (10, N'Neha', N'M', N'8949644321', CAST(N'2024-03-08' AS Date), CAST(N'2024-04-08T15:58:23.470' AS DateTime), CAST(N'2024-04-08T16:50:23.470' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (11, N'Kamal', N'K', N'8947644321', CAST(N'2023-12-08' AS Date), CAST(N'2024-04-09T00:59:52.297' AS DateTime), CAST(N'2024-04-09T01:30:52.297' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (12, N'Shawn', N'Stuart', N'8947644321', CAST(N'2023-12-11' AS Date), CAST(N'2024-04-09T01:02:35.667' AS DateTime), CAST(N'2024-04-09T01:45:35.667' AS DateTime))
INSERT [dbo].[Visitor] ([VisitorID], [FirstName], [LastName], [ContactNumber], [VisitDate], [EntryTime], [ExitTime]) VALUES (13, N'Vikash', N'Singh', N'8947644321', CAST(N'2024-05-14' AS Date), CAST(N'2024-04-09T01:03:40.337' AS DateTime), CAST(N'2024-04-09T01:45:40.337' AS DateTime))
SET IDENTITY_INSERT [dbo].[Visitor] OFF
GO
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (1, 2, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (2, 2, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (3, 2, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (4, 4, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (5, 4, N'Meetup')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (6, 4, N'Birthday Celebration')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (7, 5, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (8, 3, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (9, 2, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (10, 15, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (11, 11, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (12, 5, N'Visiting')
INSERT [dbo].[VisitorLog] ([VisitorID], [ResidentID], [Purpose]) VALUES (13, 9, N'Visiting')
GO