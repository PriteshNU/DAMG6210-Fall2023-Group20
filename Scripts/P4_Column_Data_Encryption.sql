--------------------------------------------------------------------------------------------------------------------------------
-- Encryption of the SSN Column of Resident Table
--------------------------------------------------------------------------------------------------------------------------------
-- Creating the master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DAMG6210_Group20';

-- To protect the symmetric key
CREATE CERTIFICATE ResidentSSNCert 
WITH SUBJECT = 'Resident SSN Encryption Certificate';

-- Creating the symmetric key with AES encr
CREATE SYMMETRIC KEY ResidentSSNKey
WITH ALGORITHM = AES_256

ENCRYPTION BY CERTIFICATE ResidentSSNCert;

-- Encrypt the data in SSN column
OPEN SYMMETRIC KEY ResidentSSNKey
DECRYPTION BY CERTIFICATE ResidentSSNCert;

UPDATE Resident
SET EncryptedSSN = EncryptByKey(Key_GUID('ResidentSSNKey'), SSN);

CLOSE SYMMETRIC KEY ResidentSSNKey;

-- Decrypt and View the SSN data
OPEN SYMMETRIC KEY ResidentSSNKey
DECRYPTION BY CERTIFICATE ResidentSSNCert;

SELECT 
    SSN, 
    EncryptedSSN, 
    CONVERT(VARCHAR, DecryptByKey(EncryptedSSN)) AS DecryptedSSN
FROM 
    Resident;

CLOSE SYMMETRIC KEY ResidentSSNKey;

GO
--------------------------------------------------------------------------------------------------------------------------------