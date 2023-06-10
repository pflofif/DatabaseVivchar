CREATE PROCEDURE GetRenterInfo
    @TenantName VARCHAR(100)
AS
BEGIN
    SELECT
        T.Name AS TenantName,
        PL.Number AS PlaceNumber,
        P.AmountOwed AS PaymentAmount,
        P.DateOfEnrollment AS DateOfPayment
    FROM
        Tenant AS T
    JOIN
        Lease AS L ON T.Name = L.TenantName
    JOIN
        Place AS PL ON L.PlaceNumber = PL.Number
    JOIN
        Payment AS P ON L.TenantName = P.TenantName
    WHERE
        T.Name = @TenantName
    ORDER BY
        PL.Number, P.DateOfEnrollment;
END;
