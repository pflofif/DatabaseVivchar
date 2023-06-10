select * from dbo.Lease;

--CheckRoomOccupancy
INSERT INTO Lease (LeaseNumber, PlaceNumber, TenantName, StartOfLease, EndOfLease)
VALUES (NEWID(), N'FB57DD90-34B6-4712-80AE-6D0826F930E3', 'Tenant3', '2023-01-01', '2023-12-31')

-- CheckTenantDebt
INSERT INTO Lease (LeaseNumber, PlaceNumber, TenantName, StartOfLease, EndOfLease)
VALUES (NEWID(), 'FB57DD90-34B6-4712-80AE-6D0826F930E3', 'Tenant1', '2023-04-01', '2023-12-31');
