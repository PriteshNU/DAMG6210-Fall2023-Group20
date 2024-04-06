--------------------------------------------------------------------------------------------------------------------------------
-- Encryption of the SSN Column of Resident Table
--------------------------------------------------------------------------------------------------------------------------------
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DAMG6210_Group20';

CREATE CERTIFICATE SSNEncryptionCert 
WITH SUBJECT = 'SSN Encryption Certificate';

CREATE SYMMETRIC KEY SSNEncryptionKey
WITH ALGORITHM = AES_256

ENCRYPTION BY CERTIFICATE SSNEncryptionCert;
GO
--------------------------------------------------------------------------------------------------------------------------------

-- Decrypt and View the SSN data
OPEN SYMMETRIC KEY SSNEncryptionKey
DECRYPTION BY CERTIFICATE SSNEncryptionCert;

SELECT 
    SSN, 
    CONVERT(VARCHAR, DecryptByKey(SSN)) AS DecryptedSSN
FROM 
    Resident;

CLOSE SYMMETRIC KEY SSNEncryptionKey;