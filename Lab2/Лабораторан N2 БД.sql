/*Task 1*/
select *
from dbo.PlaceType
where PlaceType.Name = 'Hall' Or PlaceType.Name = 'Kovorking'
order by PlaceType.SumPerMeter
go
/*Task 2*/
select *
from dbo.Place
go
/*Task 3*/
select *
FROM dbo.Place
         inner join PlaceType PT on PT.Name = Place.Type
where Place.Type = 'Kovorking'
   OR Place.Type = 'Hall'
order by Place.Area
go
/*Task 4*/
select * from dbo.Place
left outer join PlaceType PT on Place.Type = PT.Name

/*Task 5*/
select * from dbo.Place
where Place.Area between 45 and 60

select * from dbo.Place
where dbo.Place.Type in ('Hall', 'Traktor', 'Kovorking')

select * from dbo.Place
where dbo.Place.Area like '4%' /*починаться з 4*/

select * from dbo.Place /*Task 7*/
where exists (select * from dbo.PlaceType where dbo.PlaceType.Name = 'Hall' AND dbo.PlaceType.SumPerMeter > 9)

select * from dbo.Place
where dbo.Place.Type = Any(select dbo.PlaceType.Name from dbo.PlaceType where dbo.PlaceType.Name = 'Hall')

select * from dbo.Place
where dbo.Place.Type = All(select dbo.PlaceType.Name from dbo.PlaceType where dbo.PlaceType.Name = 'Hall')

/*Task 6*/
select TenantName, Sum(DATEDIFF(day, StartOfLease, EndOfLease)) as orend
from dbo.Lease
group by dbo.Lease.TenantName

/*Task 8*/
SELECT t.Name, SUM(p.Area * pt.SumPerMeter * DATEDIFF(day, l.StartOfLease, l.EndOfLease) / 30) AS RentPerMonth
FROM Tenant t
INNER JOIN Lease l ON t.Name = l.TenantName
INNER JOIN Place p ON l.PlaceNumber = p.Number
INNER JOIN PlaceType pt ON p.Type = pt.Name
GROUP BY t.Name

/*Task 10*/
SELECT Director, [1] AS Place1, [2] AS Place2, [3] AS Place3
FROM (
  SELECT t.Director, p.Number, ROW_NUMBER() OVER (PARTITION BY t.Director ORDER BY t.Director) AS RowNum
  FROM Tenant t
  JOIN Lease l ON t.Name = l.TenantName
  JOIN Place p ON l.PlaceNumber = p.Number
) AS src
PIVOT (
  MAX(Number)
  FOR RowNum IN ([1], [2], [3])
) AS pvt

/*Task 11*/
UPDATE Tenant
SET BankAccount = '123456789'
WHERE Name = 'James Smith'
/*Task 12*/
Update Tenant set BankAccount ='1234567898' from Tenant
inner join Lease as l ON l.TenantName = dbo.Tenant.Name
where EndOfLease = '2023-03-24 18:58:37.6033333' /*міняє рахунок у якої це кінцева дата*/
/*Task 13*/
INSERT INTO [dbo].[Tenant] ([Name], [Address], [BankAccount], [Director], [Characteristic])
VALUES ('John Doe', '123 Main Street, Anytown, USA', '1234567890', 'Jane Smith', 'Quiet, responsible tenant.'),
	   ('Acme Corporation', '456 Business Road, Anytown, USA', '0987654321', 'Joe Johnson', 'Large company, good credit.'),
	   ('Mary Johnson', '789 Elm Street, Anytown, USA', '1112223333', 'Jane Smith', 'Single mother, excellent rental history.'),
	   ('ABC, LLC', '987 Pine Avenue, Anytown, USA', '5556667777', 'Mark Davis', 'Small business, just starting out.'),
	   ('Susan Lee', '555 Oak Lane, Anytown, USA', '7778889999', 'David Kim', 'Young professional, good income.'),
	   ('XYZ, Inc.', '777 Maple Street, Anytown, USA', '4445556666', 'Lisa Chen', 'Large corporation, multiple locations.'),
	   ('James Smith', '111 Cedar Lane, Anytown, USA', '2223334444', 'Samantha Rodriguez', 'Retired, fixed income.'),
	   ('Greenway Enterprises', '222 Walnut Street, Anytown, USA', '8889990000', 'Michael Johnson', 'Property management company.'),
	   ('Jennifer Brown', '333 Birch Road, Anytown, USA', '4445556666', 'Andrew Wilson', 'Small business owner, good credit.'),
	   ('Allison Davis', '444 Spruce Street, Anytown, USA', '1112223333', 'Jane Smith', 'Recent college graduate, first time renter.');
/*Task 14*/
delete from Tenant
/*Task 15*/
delete from Tenant
where Director = 'Jane Smith'

