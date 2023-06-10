EXEC CalculateRentalPaymentForAllTenants @Month = 1, @Year = 2023;

select * from Bill
order by Bill.DateOfAccrual desc;