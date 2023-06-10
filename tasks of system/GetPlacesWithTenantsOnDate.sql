CREATE PROCEDURE GetPlacesWithTenantsOnDate
    @Date DATE
AS
BEGIN
    SELECT
        PL.Number AS PlaceNumber,
        PL.Type AS PlaceType,
        T.Name AS TenantName,
		@Date as RentDay
    FROM
        Place AS PL
    LEFT JOIN
        Lease AS L ON PL.Number = L.PlaceNumber
    LEFT JOIN
        Tenant AS T ON L.TenantName = T.Name
    WHERE
        L.StartOfLease <= @Date
        AND L.EndOfLease >= @Date
    ORDER BY
        PL.Number;
END;
