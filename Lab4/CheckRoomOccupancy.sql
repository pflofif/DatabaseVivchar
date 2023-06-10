CREATE TRIGGER CheckRoomOccupancy
ON Lease
AFTER INSERT, UPDATE
AS
BEGIN
	declare @tenantName nvarchar(max), @placeNumber uniqueidentifier
	
	select @tenantName=TenantName, @placeNumber=PlaceNumber from inserted

    IF EXISTS (
        SELECT *
        FROM Lease l
		where l.PlaceNumber=@placeNumber 
            AND l.TenantName != @tenantName 
            AND l.EndOfLease >= i.StartOfLease
            AND l.StartOfLease <= i.EndOfLease
    )
    BEGIN
        RAISERROR('The room cannot be 
        rented to multiple tenants simultaneously.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;
drop trigger CheckRoomOccupancy;

