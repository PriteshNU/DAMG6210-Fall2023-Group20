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
(143, 'James', 'Rodriguez', '1234567809', 'james.rodriguez132@email.com', '0987654340', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-8909')),
(155, 'Olivia', 'Harris', '1234567806', 'olivia.harris128@email.com', '0987654337', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '789-01-8906')),
(157, 'Ethan', 'Martinez', '1234567807', 'ethan.martinez129@email.com', '0987654338', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '890-12-8907')),
(157, 'James', 'Rodriguez', '1234567809', 'james.rodriguez132@email.com', '0987654340', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-8909')),
(159, 'Sophia', 'Clark', '1234567808', 'sophia.clark130@email.com', '0987654339', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '901-23-8908')),
(159, 'James', 'Rodriguez', '1234567809', 'james.rodriguez132@email.com', '0987654340', 'Owner', EncryptByKey(Key_GUID('SSNEncryptionKey'), '012-34-8909')),

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
(159, '2024-01-01', 2000.00);
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for the Payment table
INSERT INTO CMS.dbo.Payment (ResidentID,Amount,PaymentDate,PaymentType,Status,PaymentMethod,PaymentMethodLastFour,TransactionRefNum) VALUES
	 (1,2000.00,'2024-04-09 17:41:34.4',N'Maintenance',N'Paid',N'CC',N'1979',N'8D057210-E94B-451C-A743-BA454365F0F6'),
	 (1,2000.00,'2024-04-09 17:41:34.42',N'Maintenance',N'Paid',N'CC',N'1979',N'AD1E66DF-54A3-4561-BAD1-2F631E4E48FF'),
	 (31,5000.00,'2024-04-09 17:41:34.423',N'Maintenance',N'Paid',N'CC',N'1979',N'6F3EB851-190D-44B4-AC2F-09D4FF15B82D'),
	 (31,5000.00,'2024-04-09 17:41:34.423',N'Maintenance',N'Paid',N'CC',N'1979',N'B482D57A-5B3C-4FD1-8B06-14F66BD4F3F1'),
	 (32,5000.00,'2024-04-09 17:41:34.427',N'Maintenance',N'Paid',N'CC',N'1979',N'913BFFF9-20BB-43B8-B0EC-6844C1CD9818'),
	 (35,5000.00,'2024-04-09 17:41:34.43',N'Maintenance',N'Paid',N'CC',N'1979',N'724CB0D3-E696-4641-A3E4-24408008AD37'),
	 (3,2000.00,'2024-04-09 17:41:34.43',N'Maintenance',N'Paid',N'CC',N'1979',N'4D5FEC1E-5C17-4AA1-AA56-0DBED893C297'),
	 (3,2000.00,'2024-04-09 17:41:34.433',N'Maintenance',N'Paid',N'CC',N'1979',N'1C75F8BD-AEB0-463C-B12B-5AE728EF9B9C'),
	 (3,2000.00,'2024-04-09 17:41:34.437',N'Maintenance',N'Paid',N'CC',N'1979',N'D0451CB1-8FF5-42FD-9AD9-66C88702E6A2'),
	 (36,3000.00,'2024-04-09 17:41:34.44',N'Maintenance',N'Paid',N'CC',N'1979',N'BB54E400-8564-463E-8500-521C89A7D00E');
INSERT INTO CMS.dbo.Payment (ResidentID,Amount,PaymentDate,PaymentType,Status,PaymentMethod,PaymentMethodLastFour,TransactionRefNum) VALUES
	 (6,3000.00,'2024-04-09 17:41:34.443',N'Maintenance',N'Paid',N'CC',N'1979',N'1387128F-13B7-470A-8511-8E7DE6DA04B4'),
	 (6,3000.00,'2024-04-09 17:41:34.443',N'Maintenance',N'Paid',N'CC',N'1979',N'8FB38985-EEE6-42AF-AC70-AC2FFFE2D369'),
	 (6,3000.00,'2024-04-09 17:41:34.447',N'Maintenance',N'Paid',N'CC',N'1979',N'FBDDCA02-68EA-4127-B5F2-C83727F2EC86'),
	 (7,2000.00,'2024-04-09 17:41:34.447',N'Maintenance',N'Paid',N'CC',N'1979',N'A7DBC2D8-90B2-4BD7-8A10-6BC65A69E0E8'),
	 (38,2000.00,'2024-04-09 17:41:34.45',N'Maintenance',N'Paid',N'CC',N'1979',N'9E18FBE0-6FC9-464E-859A-9EEBD6EF8300'),
	 (38,2000.00,'2024-04-09 17:41:34.45',N'Maintenance',N'Paid',N'CC',N'1979',N'9EFABC7F-2ADE-4269-A4AB-8F452970A644'),
	 (39,3000.00,'2024-04-09 17:41:34.45',N'Maintenance',N'Paid',N'CC',N'1979',N'241E2F92-5B3E-4159-B308-78A876BF6F11'),
	 (8,5000.00,'2024-04-09 17:41:34.45',N'Maintenance',N'Paid',N'CC',N'1979',N'C9BB23AF-6898-41DF-9E88-45C57ED3BBA0'),
	 (9,3000.00,'2024-04-09 17:41:34.453',N'Maintenance',N'Paid',N'CC',N'1979',N'305598B8-B035-4E7D-9EFB-E19CFC3BC368'),
	 (40,3000.00,'2024-04-09 17:41:34.457',N'Maintenance',N'Paid',N'CC',N'1979',N'588C9955-49EF-40AD-AAC9-269009ACA1AC');
INSERT INTO CMS.dbo.Payment (ResidentID,Amount,PaymentDate,PaymentType,Status,PaymentMethod,PaymentMethodLastFour,TransactionRefNum) VALUES
	 (40,3000.00,'2024-04-09 17:41:34.457',N'Maintenance',N'Paid',N'CC',N'1979',N'44E7F1BE-28E5-4886-BD10-512528AE3CCD'),
	 (40,3000.00,'2024-04-09 17:41:34.46',N'Maintenance',N'Paid',N'CC',N'1979',N'8D24F51D-52D7-4907-8E4D-B27AAF5D3E9A'),
	 (10,3000.00,'2024-04-09 17:41:34.46',N'Maintenance',N'Paid',N'CC',N'1979',N'A77EEBE3-9258-4016-ADE4-D4B35F1CDA47'),
	 (10,3000.00,'2024-04-09 17:41:34.463',N'Maintenance',N'Paid',N'CC',N'1979',N'3167B339-E33E-4503-99B4-02EC7BDEFE5E'),
	 (11,5000.00,'2024-04-09 17:41:34.463',N'Maintenance',N'Paid',N'CC',N'1979',N'72F62CD7-4ADD-49D8-BC01-DC57F331B517'),
	 (41,2000.00,'2024-04-09 17:41:34.467',N'Maintenance',N'Paid',N'CC',N'1979',N'717E7689-DEA0-4A05-B806-A6A75E8290A0'),
	 (44,5000.00,'2024-04-09 17:41:34.467',N'Maintenance',N'Paid',N'CC',N'1979',N'0628ABE3-2F45-4B83-AE1E-63F82E66CC73'),
	 (44,5000.00,'2024-04-09 17:41:34.47',N'Maintenance',N'Paid',N'CC',N'1979',N'5EE39771-5795-41B3-8AB8-738474C59156'),
	 (13,5000.00,'2024-04-09 17:41:34.47',N'Maintenance',N'Paid',N'CC',N'1979',N'B48A360D-A2A3-4E6E-9225-93A1E9EFA790'),
	 (45,5000.00,'2024-04-09 17:41:34.47',N'Maintenance',N'Paid',N'CC',N'1979',N'9CD1203B-33EC-4920-ABC5-6A60604052A7');
INSERT INTO CMS.dbo.Payment (ResidentID,Amount,PaymentDate,PaymentType,Status,PaymentMethod,PaymentMethodLastFour,TransactionRefNum) VALUES
	 (46,2000.00,'2024-04-09 17:41:34.473',N'Maintenance',N'Paid',N'CC',N'1979',N'CBA31201-9EAB-4452-91F2-E13DB59861E4'),
	 (46,1500.00,'2024-04-09 17:41:34.473',N'Maintenance',N'Partial',N'CC',N'1979',N'E2D7DD9A-D00A-4603-BDE5-A35B558C5EAD'),
	 (46,1500.00,'2024-04-09 17:41:34.473',N'Maintenance',N'Partial',N'CC',N'1979',N'B8D57D51-9BF1-4152-B25A-6FC3C0DB4EF3'),
	 (46,1500.00,'2024-04-09 17:41:34.477',N'Maintenance',N'Partial',N'CC',N'1979',N'80FA8671-A8E4-438D-B3E6-768F23E0AF69'),
	 (46,1500.00,'2024-04-09 17:41:34.477',N'Maintenance',N'Partial',N'CC',N'1979',N'47094264-3F72-41F4-9603-02AC635F31F7'),
	 (46,1500.00,'2024-04-09 17:41:34.48',N'Maintenance',N'Partial',N'CC',N'1979',N'9B9B8EC2-2975-4EE4-BB6B-8D4B87D7A189'),
	 (14,4500.00,'2024-04-09 17:41:34.48',N'Maintenance',N'Partial',N'CC',N'1979',N'5547EC70-E2BC-4A33-8AF1-244591BCD112'),
	 (48,4500.00,'2024-04-09 17:41:34.48',N'Maintenance',N'Partial',N'CC',N'1979',N'0EB1492F-A2CC-469E-9EB1-8D8FEA2EAFD6'),
	 (15,4500.00,'2024-04-09 17:41:34.483',N'Maintenance',N'Partial',N'CC',N'1979',N'D05E9CA0-6718-4B0D-93FB-C54CBFEE7B93'),
	 (16,1500.00,'2024-04-09 17:41:34.483',N'Maintenance',N'Partial',N'CC',N'1979',N'071E43E8-A67E-4695-B2EC-EA6DD57EE378');
INSERT INTO CMS.dbo.Payment (ResidentID,Amount,PaymentDate,PaymentType,Status,PaymentMethod,PaymentMethodLastFour,TransactionRefNum) VALUES
	 (17,1500.00,'2024-04-09 17:41:34.487',N'Maintenance',N'Partial',N'CC',N'1979',N'47574734-BE3E-4F18-B31C-88F45F33854D'),
	 (25,1500.00,'2024-04-09 17:41:34.487',N'Maintenance',N'Partial',N'CC',N'1979',N'7ADE67A6-685D-4F28-8253-63173E92FDF2'),
	 (25,1500.00,'2024-04-09 17:41:34.487',N'Maintenance',N'Partial',N'CC',N'1979',N'EF3089F2-8E38-4417-A439-E8B6CE5F0AB2'),
	 (25,1500.00,'2024-04-09 17:41:34.49',N'Maintenance',N'Partial',N'CC',N'1979',N'A722B53B-6CAE-4226-82BE-DAD897B04EF7'),
	 (19,1500.00,'2024-04-09 17:41:34.49',N'Maintenance',N'Partial',N'CC',N'1979',N'94D4A669-3357-4419-9A08-B46A096FBF2D'),
	 (50,4500.00,'2024-04-09 17:41:34.493',N'Maintenance',N'Partial',N'CC',N'1979',N'FA10C5C3-2014-480D-B98A-E8B78094593E'),
	 (20,4500.00,'2024-04-09 17:41:34.493',N'Maintenance',N'Partial',N'CC',N'1979',N'A6ABD966-F4D9-4D24-9457-79CC4D5D530E'),
	 (20,4500.00,'2024-04-09 17:41:34.497',N'Maintenance',N'Partial',N'CC',N'1979',N'257D0EE5-35A7-48C6-864D-4C952EA7A070'),
	 (20,4500.00,'2024-04-09 17:41:34.497',N'Maintenance',N'Partial',N'CC',N'1979',N'0114D1E2-895F-44F9-9F95-F94151C6B4AA'),
	 (21,4500.00,'2024-04-09 17:41:34.5',N'Maintenance',N'Partial',N'CC',N'1979',N'C5CC2C16-7334-45D1-8BEA-24819DA05EC0');
INSERT INTO CMS.dbo.Payment (ResidentID,Amount,PaymentDate,PaymentType,Status,PaymentMethod,PaymentMethodLastFour,TransactionRefNum) VALUES
	 (51,1500.00,'2024-04-09 17:41:34.5',N'Maintenance',N'Partial',N'CC',N'1979',N'5C1AAE82-479D-4703-BF03-212CFAC316BC'),
	 (53,2500.00,'2024-04-09 17:41:34.503',N'Maintenance',N'Partial',N'CC',N'1979',N'0E13999F-2A0A-4F0F-8136-8B2ED745ECC4'),
	 (26,2500.00,'2024-04-09 17:41:34.503',N'Maintenance',N'Partial',N'CC',N'1979',N'EC26A23E-4C4B-4AC8-8BB1-33186CC4DC39'),
	 (26,2500.00,'2024-04-09 17:41:34.507',N'Maintenance',N'Partial',N'CC',N'1979',N'D2E769DC-94C7-4555-95D7-812E5143C958'),
	 (27,1500.00,'2024-04-09 17:41:34.507',N'Maintenance',N'Partial',N'CC',N'1979',N'E98C6048-0FB7-4246-95CA-80C9F9FC6373'),
	 (27,1500.00,'2024-04-09 17:41:34.51',N'Maintenance',N'Partial',N'CC',N'1979',N'027C1598-3A04-40A2-B849-370289EF5850'),
	 (29,1500.00,'2024-04-09 17:41:34.51',N'Maintenance',N'Partial',N'CC',N'1979',N'2EA44FF1-3CCE-4983-80AA-86D8C68CEE59'),
	 (3,10.00,'2024-04-09 17:43:08.357',N'ServiceRequest',N'Paid',N'CC',N'1979',N'649CC55A-AD8E-43A2-8D52-D5F7ACEBD8C7'),
	 (4,10.00,'2024-04-09 17:43:08.38',N'ServiceRequest',N'Paid',N'CC',N'1979',N'66B33CB0-6244-45CF-ADC5-78B472E0CEC7'),
	 (8,25.00,'2024-04-09 17:43:08.383',N'ServiceRequest',N'Paid',N'CC',N'1979',N'CB56E253-CA16-426E-B0E6-3EC87CBC9D1E');
INSERT INTO CMS.dbo.Payment (ResidentID,Amount,PaymentDate,PaymentType,Status,PaymentMethod,PaymentMethodLastFour,TransactionRefNum) VALUES
	 (11,50.00,'2024-04-09 17:43:08.387',N'ServiceRequest',N'Paid',N'CC',N'1979',N'86F366FC-956F-40F8-A560-0EA6CCBE210A'),
	 (13,50.00,'2024-04-09 17:43:08.39',N'ServiceRequest',N'Paid',N'CC',N'1979',N'328D166E-672E-48FC-9EBD-EF8C22388D88'),
	 (16,10.00,'2024-04-09 17:43:08.39',N'ServiceRequest',N'Paid',N'CC',N'1979',N'373C9764-E245-499C-B2B4-B032011B6028'),
	 (19,50.00,'2024-04-09 17:43:08.393',N'ServiceRequest',N'Paid',N'CC',N'1979',N'0E22CF17-F30A-4DA5-BAA6-52BF2C6571DE'),
	 (1,10.00,'2024-04-09 17:43:08.393',N'ServiceRequest',N'Paid',N'CC',N'1979',N'7CD7B24A-5CFD-4591-A71B-E14B2D0D50AF'),
	 (2,10.00,'2024-04-09 17:43:08.393',N'ServiceRequest',N'Paid',N'CC',N'1979',N'D1298B1E-9193-4563-AA7C-B9C59917479F'),
	 (4,10.00,'2024-04-09 17:43:08.397',N'ServiceRequest',N'Paid',N'CC',N'1979',N'4928E8AE-D0FA-4106-906A-71FCCDC12051'),
	 (5,10.00,'2024-04-09 17:43:08.397',N'ServiceRequest',N'Paid',N'CC',N'1979',N'808F042C-E3FE-4C57-BE9B-1E0769747984'),
	 (10,50.00,'2024-04-09 17:43:08.4',N'ServiceRequest',N'Paid',N'CC',N'1979',N'F7B329B8-D009-408B-A005-A476B24E0834'),
	 (12,50.00,'2024-04-09 17:43:08.4',N'ServiceRequest',N'Paid',N'CC',N'1979',N'44DD6CBD-3AE0-4214-9C5D-FECCF9278870');
INSERT INTO CMS.dbo.Payment (ResidentID,Amount,PaymentDate,PaymentType,Status,PaymentMethod,PaymentMethodLastFour,TransactionRefNum) VALUES
	 (3,50.00,'2024-04-09 17:43:08.4',N'ServiceRequest',N'Paid',N'CC',N'1979',N'329CCBA0-214B-43DE-A0DC-59B99E5183D4'),
	 (4,10.00,'2024-04-09 17:43:08.403',N'ServiceRequest',N'Paid',N'CC',N'1979',N'7F3B8962-C7F8-4CA7-A720-1649B3D37864'),
	 (7,10.00,'2024-04-09 17:43:08.403',N'ServiceRequest',N'Paid',N'CC',N'1979',N'CC7E0F95-1CF3-404E-9CA9-C461978CB73C'),
	 (10,10.00,'2024-04-09 17:43:08.407',N'ServiceRequest',N'Paid',N'CC',N'1979',N'5CF489E5-B32E-49B6-B3D9-7B0EF7E901B9'),
	 (15,50.00,'2024-04-09 17:43:08.407',N'ServiceRequest',N'Paid',N'CC',N'1979',N'1CFF53FF-C9BA-429B-9362-F3F7A801A7BD'),
	 (19,10.00,'2024-04-09 17:43:08.41',N'ServiceRequest',N'Paid',N'CC',N'1979',N'231EF343-2C36-4E60-AEDD-C71B754E3DD6'),
	 (2,10.00,'2024-04-09 17:43:08.41',N'ServiceRequest',N'Paid',N'CC',N'1979',N'7CB015BE-420E-43E1-A94A-6F63FFE61AC5'),
	 (7,25.00,'2024-04-09 17:43:08.41',N'ServiceRequest',N'Paid',N'CC',N'1979',N'1AEFBD1B-0A20-4362-B69E-2692E5BF2BF1'),
	 (13,10.00,'2024-04-09 17:43:08.41',N'ServiceRequest',N'Paid',N'CC',N'1979',N'D90512FA-F8A0-4D5D-9C56-941226A56E0A'),
	 (15,50.00,'2024-04-09 17:43:08.413',N'ServiceRequest',N'Paid',N'CC',N'1979',N'3609D5EA-B02F-4FF7-9414-0794F95EABA9');

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for maintenance fees
INSERT INTO CMS.dbo.MaintenanceFee (PaymentID,InvoiceID,BalanceAmount) VALUES
	 (1,1,0.00),
	 (2,2,0.00),
	 (3,3,0.00),
	 (4,4,0.00),
	 (5,5,0.00),
	 (6,6,0.00),
	 (7,7,0.00),
	 (8,8,0.00),
	 (9,9,0.00),
	 (10,10,0.00);
INSERT INTO CMS.dbo.MaintenanceFee (PaymentID,InvoiceID,BalanceAmount) VALUES
	 (11,11,0.00),
	 (12,12,0.00),
	 (13,13,0.00),
	 (14,14,0.00),
	 (15,15,0.00),
	 (16,16,0.00),
	 (17,17,0.00),
	 (18,18,0.00),
	 (19,19,0.00),
	 (20,20,0.00);
INSERT INTO CMS.dbo.MaintenanceFee (PaymentID,InvoiceID,BalanceAmount) VALUES
	 (21,21,0.00),
	 (22,22,0.00),
	 (23,23,0.00),
	 (24,24,0.00),
	 (25,25,0.00),
	 (26,26,0.00),
	 (27,27,0.00),
	 (28,28,0.00),
	 (29,29,0.00),
	 (30,30,0.00);
INSERT INTO CMS.dbo.MaintenanceFee (PaymentID,InvoiceID,BalanceAmount) VALUES
	 (31,31,0.00),
	 (32,32,500.00),
	 (33,33,500.00),
	 (34,34,500.00),
	 (35,35,500.00),
	 (36,36,500.00),
	 (37,37,500.00),
	 (38,38,500.00),
	 (39,39,500.00),
	 (40,40,500.00);
INSERT INTO CMS.dbo.MaintenanceFee (PaymentID,InvoiceID,BalanceAmount) VALUES
	 (41,41,500.00),
	 (42,42,500.00),
	 (43,43,500.00),
	 (44,44,500.00),
	 (45,45,500.00),
	 (46,46,500.00),
	 (47,47,500.00),
	 (48,48,500.00),
	 (49,49,500.00),
	 (50,50,500.00);
INSERT INTO CMS.dbo.MaintenanceFee (PaymentID,InvoiceID,BalanceAmount) VALUES
	 (51,51,500.00),
	 (52,52,500.00),
	 (53,53,500.00),
	 (54,54,500.00),
	 (55,55,500.00),
	 (56,56,500.00),
	 (57,57,500.00);

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for the ServiceRequest table
INSERT INTO CMS.dbo.ServiceRequest (ResidentID,Number,Description,RequestType,RequestDate,ScheduledDate,Status,Priority,RequestFee,StaffAssignedID) VALUES
	 (1,N'SR-20240409-0001',N'Test Description',N'Other','2024-04-09','2024-08-28',N'Open',N'Low',NULL,10),
	 (2,N'SR-20240409-0002',N'Test Description',N'Car Parking','2024-04-09','2024-05-22',N'Open',N'High',NULL,16),
	 (3,N'SR-20240409-0003',N'Test Description',N'Plumbing','2024-04-09','2024-08-06',N'Resolved',N'Low',10.00,14),
	 (4,N'SR-20240409-0004',N'Test Description',N'Plumbing','2024-04-09','2024-06-24',N'Resolved',N'Low',10.00,9),
	 (5,N'SR-20240409-0005',N'Test Description',N'Car Parking','2024-04-09','2025-03-15',N'Open',N'Low',NULL,6),
	 (6,N'SR-20240409-0006',N'Test Description',N'Car Parking','2024-04-09','2024-05-21',N'Open',N'High',NULL,1),
	 (7,N'SR-20240409-0007',N'Test Description',N'Other','2024-04-09','2024-06-12',N'Open',N'Medium',NULL,5),
	 (8,N'SR-20240409-0008',N'Test Description',N'Electrical','2024-04-09','2024-07-01',N'Resolved',N'Medium',25.00,13),
	 (9,N'SR-20240409-0009',N'Test Description',N'Common Area','2024-04-09','2025-02-23',N'Open',N'High',NULL,7),
	 (10,N'SR-20240409-0010',N'Test Description',N'Car Parking','2024-04-09','2025-04-08',N'Open',N'Low',NULL,6);
INSERT INTO CMS.dbo.ServiceRequest (ResidentID,Number,Description,RequestType,RequestDate,ScheduledDate,Status,Priority,RequestFee,StaffAssignedID) VALUES
	 (11,N'SR-20240409-0011',N'Test Description',N'Plumbing','2024-04-09','2024-04-16',N'Resolved',N'High',50.00,9),
	 (12,N'SR-20240409-0012',N'Test Description',N'Car Parking','2024-04-09','2025-03-07',N'Open',N'High',NULL,11),
	 (13,N'SR-20240409-0013',N'Test Description',N'Plumbing','2024-04-09','2024-11-24',N'Resolved',N'High',50.00,14),
	 (14,N'SR-20240409-0014',N'Test Description',N'Other','2024-04-09','2024-09-05',N'Open',N'High',NULL,10),
	 (15,N'SR-20240409-0015',N'Test Description',N'Car Parking','2024-04-09','2025-03-22',N'Open',N'High',NULL,6),
	 (16,N'SR-20240409-0016',N'Test Description',N'Plumbing','2024-04-09','2024-08-06',N'Resolved',N'Low',10.00,4),
	 (17,N'SR-20240409-0017',N'Test Description',N'Common Area','2024-04-09','2024-11-17',N'Open',N'Low',NULL,12),
	 (18,N'SR-20240409-0018',N'Test Description',N'Other','2024-04-09','2024-06-26',N'Open',N'High',NULL,5),
	 (19,N'SR-20240409-0019',N'Test Description',N'Electrical','2024-04-09','2024-10-29',N'Resolved',N'High',50.00,13),
	 (20,N'SR-20240409-0020',N'Test Description',N'Car Parking','2024-04-09','2024-05-14',N'Open',N'High',NULL,16);
INSERT INTO CMS.dbo.ServiceRequest (ResidentID,Number,Description,RequestType,RequestDate,ScheduledDate,Status,Priority,RequestFee,StaffAssignedID) VALUES
	 (1,N'SR-20240409-0021',N'Test Description',N'Plumbing','2024-04-09','2024-07-20',N'Resolved',N'Low',10.00,9),
	 (2,N'SR-20240409-0022',N'Test Description',N'Plumbing','2024-04-09','2024-05-08',N'Resolved',N'Low',10.00,9),
	 (3,N'SR-20240409-0023',N'Test Description',N'Other','2024-04-09','2025-02-11',N'Open',N'Medium',NULL,15),
	 (4,N'SR-20240409-0024',N'Test Description',N'Plumbing','2024-04-09','2025-01-04',N'Resolved',N'Low',10.00,4),
	 (5,N'SR-20240409-0025',N'Test Description',N'Plumbing','2024-04-09','2025-03-15',N'Resolved',N'Low',10.00,14),
	 (6,N'SR-20240409-0026',N'Test Description',N'Car Parking','2024-04-09','2024-05-17',N'Open',N'High',NULL,16),
	 (7,N'SR-20240409-0027',N'Test Description',N'Car Parking','2024-04-09','2024-04-10',N'Open',N'High',NULL,16),
	 (8,N'SR-20240409-0028',N'Test Description',N'Other','2024-04-09','2024-08-15',N'Open',N'Low',NULL,5),
	 (9,N'SR-20240409-0029',N'Test Description',N'Car Parking','2024-04-09','2024-05-06',N'Open',N'High',NULL,11),
	 (10,N'SR-20240409-0030',N'Test Description',N'Electrical','2024-04-09','2024-12-17',N'Resolved',N'High',50.00,8);
INSERT INTO CMS.dbo.ServiceRequest (ResidentID,Number,Description,RequestType,RequestDate,ScheduledDate,Status,Priority,RequestFee,StaffAssignedID) VALUES
	 (11,N'SR-20240409-0031',N'Test Description',N'Common Area','2024-04-09','2024-08-24',N'Open',N'Low',NULL,12),
	 (12,N'SR-20240409-0032',N'Test Description',N'Plumbing','2024-04-09','2024-09-28',N'Resolved',N'High',50.00,9),
	 (13,N'SR-20240409-0033',N'Test Description',N'Car Parking','2024-04-09','2024-05-27',N'Open',N'High',NULL,6),
	 (14,N'SR-20240409-0034',N'Test Description',N'Common Area','2024-04-09','2024-10-02',N'Open',N'Low',NULL,12),
	 (15,N'SR-20240409-0035',N'Test Description',N'Other','2024-04-09','2024-08-07',N'Open',N'High',NULL,10),
	 (16,N'SR-20240409-0036',N'Test Description',N'Other','2024-04-09','2024-09-21',N'Open',N'Low',NULL,5),
	 (17,N'SR-20240409-0037',N'Test Description',N'Other','2024-04-09','2024-12-26',N'Open',N'Low',NULL,10),
	 (18,N'SR-20240409-0038',N'Test Description',N'Car Parking','2024-04-09','2024-12-11',N'Open',N'High',NULL,6),
	 (19,N'SR-20240409-0039',N'Test Description',N'Other','2024-04-09','2024-07-07',N'Open',N'High',NULL,5),
	 (20,N'SR-20240409-0040',N'Test Description',N'Other','2024-04-09','2025-03-21',N'Open',N'Medium',NULL,15);
INSERT INTO CMS.dbo.ServiceRequest (ResidentID,Number,Description,RequestType,RequestDate,ScheduledDate,Status,Priority,RequestFee,StaffAssignedID) VALUES
	 (1,N'SR-20240409-0041',N'Test Description',N'Other','2024-04-09','2025-02-15',N'Open',N'High',NULL,10),
	 (2,N'SR-20240409-0042',N'Test Description',N'Common Area','2024-04-09','2025-02-04',N'Open',N'Low',NULL,12),
	 (3,N'SR-20240409-0043',N'Test Description',N'Plumbing','2024-04-09','2024-05-14',N'Resolved',N'High',50.00,9),
	 (4,N'SR-20240409-0044',N'Test Description',N'Plumbing','2024-04-09','2024-07-20',N'Resolved',N'Low',10.00,4),
	 (5,N'SR-20240409-0045',N'Test Description',N'Other','2024-04-09','2024-04-15',N'Open',N'Medium',NULL,5),
	 (6,N'SR-20240409-0046',N'Test Description',N'Car Parking','2024-04-09','2024-06-27',N'Open',N'High',NULL,1),
	 (7,N'SR-20240409-0047',N'Test Description',N'Electrical','2024-04-09','2024-08-27',N'Resolved',N'Low',10.00,3),
	 (8,N'SR-20240409-0048',N'Test Description',N'Other','2024-04-09','2024-09-18',N'Open',N'High',NULL,10),
	 (9,N'SR-20240409-0049',N'Test Description',N'Other','2024-04-09','2024-10-17',N'Open',N'Medium',NULL,10),
	 (10,N'SR-20240409-0050',N'Test Description',N'Electrical','2024-04-09','2024-11-13',N'Resolved',N'Low',10.00,3);
INSERT INTO CMS.dbo.ServiceRequest (ResidentID,Number,Description,RequestType,RequestDate,ScheduledDate,Status,Priority,RequestFee,StaffAssignedID) VALUES
	 (11,N'SR-20240409-0051',N'Test Description',N'Other','2024-04-09','2024-04-13',N'Open',N'Low',NULL,15),
	 (12,N'SR-20240409-0052',N'Test Description',N'Other','2024-04-09','2024-12-21',N'Open',N'Medium',NULL,10),
	 (13,N'SR-20240409-0053',N'Test Description',N'Car Parking','2024-04-09','2024-09-21',N'Open',N'Low',NULL,1),
	 (14,N'SR-20240409-0054',N'Test Description',N'Other','2024-04-09','2024-05-04',N'Open',N'Low',NULL,15),
	 (15,N'SR-20240409-0055',N'Test Description',N'Plumbing','2024-04-09','2024-12-28',N'Resolved',N'High',50.00,9),
	 (16,N'SR-20240409-0056',N'Test Description',N'Other','2024-04-09','2024-08-05',N'Open',N'Medium',NULL,5),
	 (17,N'SR-20240409-0057',N'Test Description',N'Other','2024-04-09','2024-06-12',N'Open',N'Low',NULL,5),
	 (18,N'SR-20240409-0058',N'Test Description',N'Other','2024-04-09','2024-07-05',N'Open',N'High',NULL,10),
	 (19,N'SR-20240409-0059',N'Test Description',N'Electrical','2024-04-09','2025-01-12',N'Resolved',N'Low',10.00,8),
	 (20,N'SR-20240409-0060',N'Test Description',N'Car Parking','2024-04-09','2024-06-11',N'Open',N'Low',NULL,16);
INSERT INTO CMS.dbo.ServiceRequest (ResidentID,Number,Description,RequestType,RequestDate,ScheduledDate,Status,Priority,RequestFee,StaffAssignedID) VALUES
	 (1,N'SR-20240409-0061',N'Test Description',N'Other','2024-04-09','2024-09-19',N'Open',N'Low',NULL,5),
	 (2,N'SR-20240409-0062',N'Test Description',N'Plumbing','2024-04-09','2024-11-27',N'Resolved',N'Low',10.00,4),
	 (3,N'SR-20240409-0063',N'Test Description',N'Other','2024-04-09','2024-10-31',N'Open',N'High',NULL,15),
	 (4,N'SR-20240409-0064',N'Test Description',N'Other','2024-04-09','2024-08-17',N'Open',N'Low',NULL,5),
	 (5,N'SR-20240409-0065',N'Test Description',N'Other','2024-04-09','2025-03-21',N'Open',N'Low',NULL,5),
	 (6,N'SR-20240409-0066',N'Test Description',N'Other','2024-04-09','2024-10-03',N'Open',N'Low',NULL,15),
	 (7,N'SR-20240409-0067',N'Test Description',N'Electrical','2024-04-09','2025-04-04',N'Resolved',N'Medium',25.00,3),
	 (8,N'SR-20240409-0068',N'Test Description',N'Other','2024-04-09','2024-05-01',N'Open',N'High',NULL,15),
	 (9,N'SR-20240409-0069',N'Test Description',N'Other','2024-04-09','2025-02-12',N'Open',N'High',NULL,5),
	 (10,N'SR-20240409-0070',N'Test Description',N'Other','2024-04-09','2024-12-23',N'Open',N'High',NULL,5);
INSERT INTO CMS.dbo.ServiceRequest (ResidentID,Number,Description,RequestType,RequestDate,ScheduledDate,Status,Priority,RequestFee,StaffAssignedID) VALUES
	 (11,N'SR-20240409-0071',N'Test Description',N'Car Parking','2024-04-09','2024-11-28',N'Open',N'Low',NULL,16),
	 (12,N'SR-20240409-0072',N'Test Description',N'Car Parking','2024-04-09','2025-02-26',N'Open',N'Low',NULL,6),
	 (13,N'SR-20240409-0073',N'Test Description',N'Electrical','2024-04-09','2024-11-12',N'Resolved',N'Low',10.00,3),
	 (14,N'SR-20240409-0074',N'Test Description',N'Other','2024-04-09','2024-10-29',N'Open',N'High',NULL,10),
	 (15,N'SR-20240409-0075',N'Test Description',N'Plumbing','2024-04-09','2024-08-08',N'Resolved',N'High',50.00,9),
	 (16,N'SR-20240409-0076',N'Test Description',N'Car Parking','2024-04-09','2024-09-18',N'Open',N'Low',NULL,6),
	 (17,N'SR-20240409-0077',N'Test Description',N'Other','2024-04-09','2024-05-12',N'Open',N'Low',NULL,10),
	 (18,N'SR-20240409-0078',N'Test Description',N'Other','2024-04-09','2024-06-26',N'Open',N'Medium',NULL,10),
	 (19,N'SR-20240409-0079',N'Test Description',N'Other','2024-04-09','2024-07-22',N'Open',N'High',NULL,15),
	 (20,N'SR-20240409-0080',N'Test Description',N'Common Area','2024-04-09','2024-11-09',N'Open',N'High',NULL,12);

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for service request fee
INSERT INTO CMS.dbo.ServiceRequestFee (PaymentID,ServiceRequestID) VALUES
	 (58,3),
	 (59,4),
	 (60,8),
	 (61,11),
	 (62,13),
	 (63,16),
	 (64,19),
	 (65,21),
	 (66,22),
	 (67,24);
INSERT INTO CMS.dbo.ServiceRequestFee (PaymentID,ServiceRequestID) VALUES
	 (68,25),
	 (69,30),
	 (70,32),
	 (71,43),
	 (72,44),
	 (73,47),
	 (74,50),
	 (75,55),
	 (76,59),
	 (77,62);
INSERT INTO CMS.dbo.ServiceRequestFee (PaymentID,ServiceRequestID) VALUES
	 (78,67),
	 (79,73),
	 (80,75);
--------------------------------------------------------------------------------------------------------------------------------

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
-- Insert statements for amenity bookings
INSERT INTO CMS.dbo.AmenityBooking (AmenityID,ResidentID,BookingDate,StartTime,EndTime,BookingFee,NumOfAttendees) 
VALUES
	 (4,1,'2025-01-13','08:45:00.0000000','09:54:00.0000000',59.30,3),
	 (2,2,'2024-10-04','09:51:00.0000000','10:16:00.0000000',87.44,4),
	 (8,3,'2025-01-12','09:59:00.0000000','10:49:00.0000000',57.16,1),
	 (2,8,'2024-06-28','08:36:00.0000000','10:12:00.0000000',82.10,4),
	 (7,9,'2024-07-30','09:12:00.0000000','09:21:00.0000000',25.35,1),
	 (7,10,'2025-03-30','09:01:00.0000000','09:39:00.0000000',55.69,5),
	 (8,13,'2024-06-07','08:58:00.0000000','10:17:00.0000000',NULL,4),
	 (5,14,'2024-08-24','09:44:00.0000000','10:17:00.0000000',NULL,3),
	 (8,15,'2024-12-14','08:34:00.0000000','10:17:00.0000000',NULL,5),
	 (6,17,'2024-05-04','09:49:00.0000000','10:16:00.0000000',NULL,1);
INSERT INTO CMS.dbo.AmenityBooking (AmenityID,ResidentID,BookingDate,StartTime,EndTime,BookingFee,NumOfAttendees)
VALUES
	 (8,18,'2024-09-13','09:01:00.0000000','09:14:00.0000000',NULL,4),
	 (8,19,'2024-07-25','08:38:00.0000000','10:43:00.0000000',NULL,4),
	 (7,20,'2024-09-10','08:54:00.0000000','10:10:00.0000000',NULL,1),
	 (2,1,'2024-09-11','08:52:00.0000000','10:26:00.0000000',59.61,2),
	 (2,2,'2024-06-08','08:31:00.0000000','10:16:00.0000000',70.97,2),
	 (7,4,'2024-07-05','08:45:00.0000000','09:11:00.0000000',1.76,4),
	 (9,5,'2024-05-02','08:35:00.0000000','09:56:00.0000000',53.95,2),
	 (4,7,'2024-09-30','09:56:00.0000000','09:09:00.0000000',21.65,3),
	 (1,8,'2025-02-01','09:06:00.0000000','10:20:00.0000000',90.09,5),
	 (6,9,'2025-04-07','08:39:00.0000000','09:21:00.0000000',21.18,4);
INSERT INTO CMS.dbo.AmenityBooking (AmenityID,ResidentID,BookingDate,StartTime,EndTime,BookingFee,NumOfAttendees) 
VALUES
	 (7,10,'2024-09-14','08:34:00.0000000','09:56:00.0000000',32.03,3),
	 (9,11,'2025-02-18','09:48:00.0000000','09:45:00.0000000',NULL,1),
	 (7,12,'2024-05-06','08:16:00.0000000','09:14:00.0000000',NULL,2),
	 (6,13,'2025-04-01','09:32:00.0000000','10:00:00.0000000',NULL,3),
	 (5,14,'2024-12-20','09:24:00.0000000','09:44:00.0000000',NULL,3),
	 (2,15,'2024-10-15','08:19:00.0000000','10:33:00.0000000',NULL,5),
	 (6,16,'2024-09-24','09:35:00.0000000','10:29:00.0000000',NULL,3),
	 (8,19,'2024-06-16','09:57:00.0000000','09:50:00.0000000',NULL,5),
	 (5,20,'2025-01-21','09:59:00.0000000','10:45:00.0000000',NULL,2),
	 (1,1,'2024-04-09','09:15:00.0000000','09:06:00.0000000',0.77,1);
INSERT INTO CMS.dbo.AmenityBooking (AmenityID,ResidentID,BookingDate,StartTime,EndTime,BookingFee,NumOfAttendees) 
VALUES
	 (5,2,'2024-04-09','09:17:00.0000000','10:53:00.0000000',4.41,2),
	 (8,3,'2024-04-09','09:57:00.0000000','09:51:00.0000000',46.41,1),
	 (4,4,'2024-04-09','08:52:00.0000000','10:43:00.0000000',9.05,1),
	 (5,6,'2024-04-09','09:28:00.0000000','10:08:00.0000000',50.03,3),
	 (7,7,'2024-04-09','08:16:00.0000000','10:42:00.0000000',95.42,1),
	 (6,8,'2024-04-09','09:29:00.0000000','09:59:00.0000000',51.51,5),
	 (9,9,'2024-04-09','08:18:00.0000000','10:31:00.0000000',43.50,2),
	 (2,11,'2024-04-09','08:08:00.0000000','09:02:00.0000000',NULL,5),
	 (9,16,'2024-04-09','08:13:00.0000000','09:11:00.0000000',NULL,4),
	 (1,17,'2024-04-09','08:55:00.0000000','09:15:00.0000000',NULL,1);
INSERT INTO CMS.dbo.AmenityBooking (AmenityID,ResidentID,BookingDate,StartTime,EndTime,BookingFee,NumOfAttendees) 
VALUES
	 (6,20,'2024-04-09','09:22:00.0000000','10:58:00.0000000',NULL,1),
	 (9,1,'2024-04-09','09:08:00.0000000','10:29:00.0000000',89.17,5),
	 (1,3,'2024-04-09','08:07:00.0000000','09:33:00.0000000',89.29,4),
	 (9,7,'2024-04-09','08:35:00.0000000','09:42:00.0000000',75.88,4),
	 (6,9,'2024-04-09','09:55:00.0000000','10:38:00.0000000',80.19,2),
	 (9,10,'2024-04-09','08:47:00.0000000','10:44:00.0000000',62.67,2),
	 (6,15,'2024-04-09','09:32:00.0000000','09:40:00.0000000',NULL,1),
	 (5,16,'2024-04-09','09:33:00.0000000','10:53:00.0000000',NULL,2),
	 (9,17,'2024-04-09','08:46:00.0000000','09:47:00.0000000',NULL,5),
	 (2,18,'2024-04-09','09:13:00.0000000','10:40:00.0000000',NULL,3);

--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert Statements for vehicles
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
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for parking slots
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

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for Reserved Parking
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
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for Visitors
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
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Insert statements for Visitor Log
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
--------------------------------------------------------------------------------------------------------------------------------