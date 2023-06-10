CREATE PROCEDURE CalculateRentalPayment
    @TenantName NVARCHAR(50),
    @Month INT,
    @Year INT
AS
BEGIN
    DECLARE @StartDate DATETIME, @EndDate DATETIME, @TotalPayment INT;
        
    SET @StartDate = DATEFROMPARTS(@Year, @Month, 1); --�������� ���� � ������
    SET @EndDate = DATEADD(DAY, -1, DATEADD(MONTH, 1, @StartDate));
    
    SELECT @TotalPayment = SUM((P.Area * PT.SumPerMeter) * 1.2) 
    FROM Lease L
    INNER JOIN Place P ON L.PlaceNumber = P.Number
    INNER JOIN PlaceType PT ON P.Type = PT.Name
    WHERE L.TenantName = @TenantName -
        AND L.StartOfLease <= @EndDate
        AND L.EndOfLease >= @StartDate;
    
   
    INSERT INTO Bill (BillId, Sum, LeaseNumber, DateOfAccrual, [DateSent])
    SELECT NEWID(), @TotalPayment, L.LeaseNumber, GETDATE(), NEWID()
    FROM Lease L
    WHERE L.TenantName = @TenantName
        AND L.StartOfLease <= @EndDate
        AND L.EndOfLease >= @StartDate;
END

