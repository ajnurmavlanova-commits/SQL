Easy-Level Tasks
1.SELECT 
    Category,
    COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category
ORDER BY TotalProducts DESC;
2.SELECT AVG(Price) AS AverageElectronicsPrice
FROM Products
WHERE Category = 'Electronics';
3.SELECT *
FROM Customers
WHERE City LIKE 'L%';
4.SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';
5.SELECT *
FROM Customers
WHERE Country LIKE '%A';
6.SELECT MAX(Price) AS HighestPrice
FROM Products;
7.SELECT 
    ProductName,
    StockQuantity,
    CASE 
        WHEN StockQuantity < 30 THEN 'Low Stock'
        ELSE 'Sufficient'
    END AS StockStatus
FROM Products;
8.SELECT 
    Country,
    COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;
9.SELECT 
    MIN(Quantity) AS MinQuantity,
    MAX(Quantity) AS MaxQuantity
FROM Orders;

Medium-Level Tasks
10.SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-01-31'
  AND o.CustomerID NOT IN (
      SELECT i.CustomerID
      FROM Invoices i
      WHERE i.InvoiceDate BETWEEN '2023-01-01' AND '2023-01-31'
  );
11.SELECT ProductName
FROM Products

UNION ALL

SELECT ProductName
FROM Products_Discounted;
12.SELECT ProductName
FROM Products

UNION

SELECT ProductName
FROM Products_Discounted;
13.SELECT 
    YEAR(OrderDate) AS OrderYear,
    AVG(TotalAmount) AS AverageOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
14.SELECT 
    ProductName,
    CASE 
        WHEN Price < 100 THEN 'Low'
        WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
        WHEN Price > 500 THEN 'High'
    END AS PriceGroup
FROM Products;
15.SELECT *
INTO Population_Each_Year
FROM
(
    SELECT 
        district_name,
        Year,
        Population
    FROM City_Population
) AS SourceTable
PIVOT
(
    SUM(Population)
    FOR Year IN ([2012], [2013])
) AS PivotTable;
16.SELECT 
    ProductID,
    SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID
ORDER BY ProductID;
17.SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';
18.SELECT *
INTO Population_Each_City
FROM
(
    SELECT 
        Year,
        district_name,
        Population
    FROM City_Population
) AS SourceTable
PIVOT
(
    SUM(Population)
    FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;

Hard-Level Tasks
19.SELECT TOP 3 
    CustomerID,
    SUM( TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;
20.SELECT 
    district_name,
    Year,
    Population
INTO City_Population_Restored
FROM Population_Each_Year
UNPIVOT
(
    Population FOR Year IN ([2012], [2013])
) AS UnpivotTable
21.SELECT 
    p.ProductName,
    COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s 
    ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY TimesSold DESC;
22.SELECT 
    Year,
    district_name,
    Population
INTO City_Population_Restored
FROM Population_Each_City
UNPIVOT
(
    Population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS UnpivotTable;
