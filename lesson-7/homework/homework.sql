🟢 Easy-Level Tasks (10)
1.SELECT MIN(Price) AS MinPrice
FROM Products;
2.SELECT max(salary) AS maxsalary
FROM Employees;
3.SELECT COUNT(*) AS TotalCustomers
FROM Customers;
4.SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;
5.SELECT SUM(SaleAmount) AS TotalSalesAmount
FROM Sales
WHERE ProductID = 7;
6.SELECT AVG(Age) AS AverageAge
FROM Employees;
7.SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;
8.SELECT Category,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;
9.SELECT CustomerID,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;
10.SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

🟠 Medium-Level Tasks (9)
11.SELECT p.Category,
       SUM(s.SaleAmount) AS TotalSales,
       AVG(s.SaleAmount) AS AverageSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;
12.SELECT COUNT(*) AS HREmployeeCount
FROM Employees
WHERE DepartmentName = 'HR';
13.SELECT DepartmentName,
       MIN(Salary) AS LowestSalary,
       MAX(Salary) AS HighestSalary
FROM Employees
GROUP BY DepartmentName;
14.SELECT DepartmentName,
       AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DepartmentName;
15.SELECT DepartmentName,
       AVG(Salary) AS AverageSalary,
       COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;
16.SELECT Category,
       AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;
17.SELECT YEAR(SaleDate) AS SaleYear,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY SaleYear;
18.SELECT CustomerID,
       COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;
19.SELECT DepartmentName,
       AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;

🔴 Hard-Level Tasks (6)
20.SELECT Category,
       AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;
21.SELECT CustomerID,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;
22.SELECT DepartmentName,
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;
23.
24.SELECT 
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    SUM(TotalAmount) AS TotalSales,
    COUNT(DISTINCT ProductID) AS UniqueProductsSold
FROM Orders
GROUP BY 
    YEAR(OrderDate),
    MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2
ORDER BY 
    OrderYear,
    OrderMonth;
25.SELECT 
    YEAR(OrderDate) AS OrderYear,
    MIN(OrderQty) AS MinOrderQuantity,
    MAX(OrderQty) AS MaxOrderQuantity
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
