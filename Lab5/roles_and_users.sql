
CREATE USER PaymentOperator WITHOUT LOGIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Payment TO PaymentOperator;

CREATE USER RentOperator WITHOUT LOGIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Bill TO RentOperator;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Lease TO RentOperator;
GRANT SELECT ON dbo.Place TO RentOperator;
GRANT SELECT ON dbo.Payment TO RentOperator;


CREATE USER FinancialAnalyst WITHOUT LOGIN;
GRANT SELECT ON dbo.Bill TO FinancialAnalyst;
GRANT SELECT ON dbo.Lease TO FinancialAnalyst;
GRANT SELECT ON dbo.Place TO FinancialAnalyst;
GRANT SELECT ON dbo.Payment TO FinancialAnalyst;

CREATE USER "ADMIN" WITHOUT LOGIN;
GO

---- ROLES ----

CREATE ROLE ClientManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Bill TO ClientManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Lease TO ClientManager;
GRANT SELECT ON dbo.Place TO ClientManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Payment TO ClientManager;

CREATE ROLE RoomManager;
GRANT SELECT ON dbo.Lease TO RoomManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Place TO RoomManager;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.PlaceType TO RoomManager;

/*Адміністратор системи:
відповідає за керування та адміністрування бази даних, 
включаючи створення, зміну та видалення таблиць, користувачів, ролей,
налаштування доступу та інших адміністративних завдань.*/
CREATE ROLE SystemAdministrator;
GRANT ALL PRIVILEGES ON dbo.Bill TO SystemAdministrator;
GRANT ALL PRIVILEGES ON dbo.Lease TO SystemAdministrator;
GRANT ALL PRIVILEGES ON dbo.Place TO SystemAdministrator;
GRANT ALL PRIVILEGES ON dbo.Payment TO SystemAdministrator;
GRANT ALL PRIVILEGES ON dbo.Tenant TO SystemAdministrator;
GRANT ALL PRIVILEGES ON dbo.PlaceType TO SystemAdministrator;
GO

---- ASIGN ROLES TO USERS ----
ALTER ROLE ClientManager ADD MEMBER Operator;

ALTER ROLE RoomManager ADD MEMBER Operator;

ALTER ROLE SystemAdministrator ADD MEMBER "ADMIN";


GO
---- REVOKE PRIVILEGES FROM USER ----
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.Bill FROM Operator;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.Lease FROM Operator;
REVOKE SELECT ON dbo.Place FROM Operator;
REVOKE SELECT, INSERT, UPDATE, DELETE ON dbo.Payment FROM Operator;
GO

---- REVOKE ROLE FROM USER ----
ALTER ROLE SystemAdministrator DROP MEMBER [ADMIN];
ALTER ROLE RoomManager DROP MEMBER Operator;
ALTER ROLE ClientManager DROP MEMBER Operator;
GO

---- DROP USER AND ROLES ----
DROP ROLE ClientManager;
DROP ROLE RoomManager;
DROP ROLE SystemAdministrator;

DROP USER Operator;
DROP USER FinancialAnalyst;
DROP USER TenantCompany;
DROP USER "ADMIN";