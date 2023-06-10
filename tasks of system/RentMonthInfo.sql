CREATE PROCEDURE CalculateMonthlyRentInfo
    @MonthNumber INT
AS
BEGIN
    SELECT
        T.Name AS TenantName,
        PL.Type,
        PL.Area * PT.SumPerMeter * 1.2 AS MonthlyPayment,
        CASE
            WHEN DATEDIFF(MONTH, MAX(Payment.DateOfEnrollment),
			DATEFROMPARTS(YEAR(GETDATE()), @MonthNumber, 1)) > 1
			THEN (PL.Area * PT.SumPerMeter * 1.2) + ((PL.Area * PT.SumPerMeter * 1.2) 
			* 0.2/100 * DATEDIFF(DAY, DATEADD(DAY, 15, MAX(Payment.DateOfEnrollment)), GETDATE()))
            ELSE 0
        END AS DebtAmount
    FROM
        Tenant AS T
    JOIN
        Lease AS L ON T.Name = L.TenantName
    JOIN
        Place AS PL ON L.PlaceNumber = PL.Number
    JOIN
        PlaceType AS PT ON PL.Type = PT.Name
    LEFT JOIN
        Payment ON L.TenantName = Payment.TenantName
    WHERE
        (@MonthNumber = MONTH(DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
            AND YEAR(GETDATE()) = YEAR(L.StartOfLease)
            AND MONTH(GETDATE()) >= MONTH(L.StartOfLease))
        OR (@MonthNumber <> MONTH(DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))
            AND L.EndOfLease >= DATEFROMPARTS(YEAR(GETDATE()), @MonthNumber, 1))
    GROUP BY
        T.Name, PL.Type, PL.Area, PT.SumPerMeter;
END;


