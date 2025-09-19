Easy Level tasks(10)
1.BULK INSERT is a Transact-SQL command used to quickly load large amounts of data from an external file into a SQL Server table.It is needed for importing massive datasets compared to inserting row by row.
2.CSV,TXT,XML,JSON files
3.CREATE TABLE Products (ProductID INT PRIMARY KEY,ProductName VARCHAR(50),Price DECIMAL(10,2))
4.INSERT INTO Products (ProductID, ProductName, Price)
VALUES (1, 'Laptop', 1200.00)
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (2, 'Smartphone', 800.50)
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (3, 'Headphones', 150.75)
5.NULL: Represents missing, unknown, or undefined data. A column that allows NULL can have empty values.
NOT NULL: Ensures that the column must always contain a value. No empty entries are allowed
6.ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName)
7.-- This query retrieves all products from the Products table
SELECT * FROM Products
8.ALTER TABLE Products
ADD CategoryID INT
9.CREATE TABLE Categories (CategoryID INT PRIMARY KEY,CategoryName VARCHAR(50) UNIQUE)
10.The IDENTITY property automatically generates sequential numeric values for a column (usually a primary key).

Medium-Level Tasks (10)
11.BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (FIELDTERMINATOR = ',',ROWTERMINATOR = '\n',FIRSTROW = 2)
12.ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID)
13.PRIMARY KEY:Cannot contain NULL,Only one PRIMARY KEY,Identifies each row uniquely,Creates a clustered index (by default, if none exists)
UNIQUE KEY:Can contain one NULL (per column),Multiple UNIQUE constraints allowed,Ensures no duplicate values,Creates a non-clustered index
14.ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive
CHECK (Price > 0)
15.ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0
16.SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price, Stock
FROM Products
17.A FOREIGN KEY establishes a relationship between two tables.

Hard-Level Tasks (10)
18.CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 18))
19.CREATE TABLE InvoiceNumbers (InvoiceID INT IDENTITY(100, 10) PRIMARY KEY,Description VARCHAR(100)
20.CREATE TABLE OrderDetails (OrderID INT NOT NULL,ProductID INT NOT NULL,Quantity INT NOT NULL,PRIMARY KEY (OrderID, ProductID))
21.ISNULL(выражение, замена)
Заменяет NULL указанным значением.
Принимает только два аргумента.
Пример:ISNULL(Price, 0) Вернёт 0, если значение Price равно NULL.
COALESCE(выражение1, выражение2, …, выражениеN)
Возвращает первое ненулевое значение из списка.
Может принимать несколько аргументов.
Это стандартная функция SQL (работает во многих СУБД, а не только в SQL Server).
Пример:COALESCE(MiddleName, NickName, 'N/A')
Вернёт сначала MiddleName, если он не NULL; если NULL, то NickName; если и он NULL, то строку 'N/A'.
22.CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE)
23.CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
