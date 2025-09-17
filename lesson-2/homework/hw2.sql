create database employees1
use employees1
create table Employees (EmpID INT, Name VARCHAR(50),Salary DECIMAL(10,2))
INSERT INTO Employees (EmpID, Name, Salary) 
VALUES (1, 'Baxodir', 5000.00)
INSERT INTO Employees 
VALUES (2, 'Mamur', 6000.00)
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
    (3, 'Laylo', 5500.00),
    (4, 'Robiya', 6200.00)

select * from Employees

UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1

DELETE FROM Employees
WHERE EmpID = 2

--Difference between DELETE, TRUNCATE, and DROP
--DELETE: Removes rows from a table
--TRUNCATE: Removes ALL rows quickly
--DROP: Removes the entire table

ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100)

ALTER TABLE Employees
ADD Department VARCHAR(50)

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT

CREATE TABLE Departments (DepartmentID INT PRIMARY KEY,DepartmentName VARCHAR(50))
select * from Departments

TRUNCATE TABLE Employees

CREATE TABLE TempDepartments (DepartmentID INT,DepartmentName VARCHAR(50))

INSERT INTO TempDepartments VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Sales'),
(5, 'Marketing')

select * from TempDepartments

INSERT INTO Departments (DepartmentID , DepartmentName)
SELECT DepartmentID, DepartmentName FROM TempDepartments 



UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

select * from Employees
TRUNCATE TABLE Employees
ALTER TABLE Employees
DROP COLUMN Department

EXEC sp_rename 'Employees', 'StaffMembers'

DROP TABLE Departments


CREATE TABLE Products (ProductID INT PRIMARY KEY,ProductName VARCHAR(100),Category VARCHAR(50),Price DECIMAL(10,2) CHECK (Price > 0),Description VARCHAR(255))

ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES 
(1, 'Laptop', 'Electronics', 800.00, 'High performance laptop'),
(2, 'Chair', 'Furniture', 120.50, 'Ergonomic office chair'),
(3, 'Pen', 'Stationery', 1.25, 'Blue ink pen'),
(4, 'Headphones', 'Electronics', 150.00, 'Noise cancelling'),
(5, 'Table', 'Furniture', 220.00, 'Wooden dining table');

SELECT * INTO Products_Backup FROM Products;

EXEC sp_rename 'Products', 'Inventory';

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);

select * from Inventory
