CREATE TRIGGER UpdateBillAuditFields
ON Bill
AFTER INSERT, UPDATE
AS
BEGIN
    -- Оновлення полів UCR, DCR, ULC, DLC для нових записів
    UPDATE B
    SET UCR = SYSTEM_USER,
        DCR = GETDATE(),
        ULC = SYSTEM_USER,
        DLC = GETDATE()
    FROM Bill B
    INNER JOIN inserted I ON B.BillId = I.BillId;
END;
Go
CREATE TRIGGER UpdateLeaseAuditFields
ON Lease
AFTER INSERT, UPDATE
AS
BEGIN
    -- Оновлення полів UCR, DCR, ULC, DLC для нових записів
    UPDATE L
    SET UCR = SYSTEM_USER,
        DCR = GETDATE(),
        ULC = SYSTEM_USER,
        DLC = GETDATE()
    FROM Lease L
    INNER JOIN inserted I ON L.LeaseNumber = I.LeaseNumber;
END;

Go
CREATE TRIGGER UpdatePaymentAuditFields
ON Payment
AFTER INSERT, UPDATE
AS
BEGIN
    -- Оновлення полів UCR, DCR, ULC, DLC для нових записів
    UPDATE P
    SET UCR = SYSTEM_USER,
        DCR = GETDATE(),
        ULC = SYSTEM_USER,
        DLC = GETDATE()
    FROM Payment P
    INNER JOIN inserted I ON P.DateOfEnrollment = I.DateOfEnrollment;
END;

Go
CREATE TRIGGER UpdatePlaceAuditFields
ON Place
AFTER INSERT, UPDATE
AS
BEGIN
    -- Оновлення полів UCR, DCR, ULC, DLC для нових записів
    UPDATE P
    SET UCR = SYSTEM_USER,
        DCR = GETDATE(),
        ULC = SYSTEM_USER,
        DLC = GETDATE()
    FROM Place P
    INNER JOIN inserted I ON P.Number = I.Number;
END;
Go
CREATE TRIGGER UpdatePlaceTypeAuditFields
ON PlaceType
AFTER INSERT, UPDATE
AS
BEGIN
    -- Оновлення полів UCR, DCR, ULC, DLC для нових записів
    UPDATE Pt
    SET UCR = SYSTEM_USER,
        DCR = GETDATE(),
        ULC = SYSTEM_USER,
        DLC = GETDATE()
    FROM PlaceType Pt
    INNER JOIN inserted I ON Pt.Name = I.Name;
END;
Go
CREATE TRIGGER UpdateTenantAuditFields
ON Tenant
AFTER INSERT, UPDATE
AS
BEGIN
    -- Оновлення полів UCR, DCR, ULC, DLC для нових записів
    UPDATE T
    SET UCR = SYSTEM_USER,
        DCR = GETDATE(),
        ULC = SYSTEM_USER,
        DLC = GETDATE()
    FROM Tenant T
    INNER JOIN inserted I ON T.Name = I.Name;
END;