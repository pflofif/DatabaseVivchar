CREATE TRIGGER CheckTenantDebt
ON Lease
FOR INSERT
AS
BEGIN  
	IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Lease l ON l.TenantName = i.TenantName
        WHERE DATEDIFF(MONTH, (SELECT MAX(DateOfEnrollment) FROM Payment WHERE TenantName = l.TenantName), GETDATE()) > 3
    )
    BEGIN
        RAISERROR('The difference between the last payment date and current date exceeds three months', 16, 1);
        ROLLBACK;
    END
END;
