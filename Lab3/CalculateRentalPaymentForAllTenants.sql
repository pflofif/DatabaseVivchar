CREATE PROCEDURE CalculateRentalPaymentForAllTenants
    @Month INT,
    @Year INT
AS
BEGIN
    DECLARE @TenantName NVARCHAR(50);
    
    DECLARE tenant_cursor CURSOR FOR
    SELECT Name FROM Tenant;
    
    OPEN tenant_cursor;
    
    FETCH NEXT FROM tenant_cursor INTO @TenantName;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC CalculateRentalPayment @TenantName, @Month, @Year;
        
        FETCH NEXT FROM tenant_cursor INTO @TenantName;
    END
    
    CLOSE tenant_cursor;
    DEALLOCATE tenant_cursor;
END
