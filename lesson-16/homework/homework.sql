Easy Tasks
1.WITH NumbersCTE AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1
    FROM NumbersCTE
    WHERE Number < 1000
)
SELECT Number
FROM NumbersCTE
OPTION (MAXRECURSION 1000);
2.SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    dt.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) AS dt
ON e.EmployeeID = dt.EmployeeID;
3.WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT *
FROM AvgSalaryCTE;
4.SELECT p.ProductID, p.ProductName, dt.MaxSales
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MaxSales
    FROM Sales
    GROUP BY ProductID
) AS dt
ON p.ProductID = dt.ProductID;
5.WITH RecursiveNumbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2
    FROM RecursiveNumbers
    WHERE num * 2 < 1000000
)
SELECT *
FROM RecursiveNumbers;
6.WITH SalesCount AS (
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        COUNT(s.SalesID) AS TotalSales
    FROM Employees e
    LEFT JOIN Sales s ON e.EmployeeID = s.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
)
SELECT 
    FirstName,
    LastName
FROM SalesCount
WHERE TotalSales > 5;
7.WITH ProductSales AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(s.SalesAmount) AS TotalSales
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    GROUP BY p.ProductID, p.ProductName
)
SELECT 
    ProductID,
    ProductName,
    TotalSales
FROM ProductSales
WHERE TotalSales > 500;
8.WITH AvgSalary AS (
    SELECT AVG(Salary) AS AverageSalary
    FROM Employees
)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary,
    e.DepartmentID
FROM Employees e
CROSS JOIN AvgSalary a
WHERE e.Salary > a.AverageSalary;

Medium Tasks
1.SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    dt.TotalOrders
FROM Employees e
INNER JOIN (
    SELECT 
        EmployeeID,
        COUNT(*) AS TotalOrders
    FROM Sales
    GROUP BY EmployeeID
) dt
ON e.EmployeeID = dt.EmployeeID
ORDER BY dt.TotalOrders DESC
LIMIT 5;  -- Use TOP 5 if using SQL Server: SELECT TOP 5 ...
2.SELECT 
    p.CategoryID,
    SUM(dt.TotalSales) AS TotalSalesPerCategory
FROM Products p
INNER JOIN (
    SELECT 
        ProductID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
) dt
ON p.ProductID = dt.ProductID
GROUP BY p.CategoryID
ORDER BY TotalSalesPerCategory DESC;
3.WITH FactorialCTE AS (
    SELECT 
        Number,
        1 AS Factorial,
        1 AS Counter
    FROM Numbers1
    UNION ALL
    SELECT 
        Number,
        Factorial * (Counter + 1),
        Counter + 1
    FROM FactorialCTE
    WHERE Counter < Number
)
SELECT 
    Number,
    MAX(Factorial) AS Factorial
FROM FactorialCTE
GROUP BY Number
ORDER BY Number;
4.WITH SplitCTE AS (
    SELECT
        Id,
        CAST(SUBSTRING(String, 1, 1) AS VARCHAR(1)) AS CharValue,
        1 AS Position,
        LEN(String) AS StringLength
    FROM Example
    UNION ALL
    SELECT
        Id,
        CAST(SUBSTRING(String, Position + 1, 1) AS VARCHAR(1)) AS CharValue,
        Position + 1,
        StringLength
    FROM SplitCTE
    WHERE Position < StringLength
)
SELECT 
    Id,
    CharValue,
    Position
FROM SplitCTE
ORDER BY Id, Position;
5.WITH MonthlySales AS (
    SELECT
        YEAR(SaleDate) AS SaleYear,
        MONTH(SaleDate) AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
SalesDiff AS (
    SELECT
        SaleYear,
        SaleMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SaleYear, SaleMonth) AS PrevMonthSales
    FROM MonthlySales
)
SELECT
    SaleYear,
    SaleMonth,
    TotalSales,
    PrevMonthSales,
    TotalSales - PrevMonthSales AS SalesDifference
FROM SalesDiff
ORDER BY SaleYear, SaleMonth;
6.SELECT e.EmployeeID, e.FirstName, e.LastName, dt.Quarter, dt.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) dt
ON e.EmployeeID = dt.EmployeeID
WHERE dt.TotalSales > 45000
ORDER BY dt.Quarter, dt.TotalSales DESC;

Difficult Tasks
1.WITH FibonacciCTE AS (
    SELECT 1 AS Position, 0 AS FibonacciNumber
    UNION ALL
    SELECT 2, 1
    UNION ALL
    SELECT 
        Position + 1,
        (SELECT FibonacciNumber FROM FibonacciCTE f1 WHERE f1.Position = FibonacciCTE.Position)
        +
        (SELECT FibonacciNumber FROM FibonacciCTE f2 WHERE f2.Position = FibonacciCTE.Position - 1)
    FROM FibonacciCTE
    WHERE Position < 20  -- Set the number of Fibonacci numbers to generate
)
SELECT * FROM FibonacciCTE
ORDER BY Position;
2.SELECT *
FROM FindSameCharacters
WHERE Vals IS NOT NULL
  AND LEN(Vals) > 1
  AND Vals = REPLICATE(LEFT(Vals, 1), LEN(Vals));
3.DECLARE @n INT = 5;
WITH NumberSequence AS (
    SELECT 1 AS num, CAST(1 AS VARCHAR(MAX)) AS sequence_str
    UNION ALL
    SELECT num + 1,
           CAST(sequence_str + CAST(num + 1 AS VARCHAR) AS VARCHAR(MAX))
    FROM NumberSequence
    WHERE num < @n
)
SELECT sequence_str
FROM NumberSequence
ORDER BY num;
4.SELECT e.EmployeeID, e.FirstName, e.LastName, dt.TotalSales
FROM Employees e
INNER JOIN (
    -- Derived table: total sales per employee in the last 6 months
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) AS dt
ON e.EmployeeID = dt.EmployeeID
WHERE dt.TotalSales = (
    -- Find the maximum total sales
    SELECT MAX(SUM(SalesAmount))
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
);
5.WITH SplitValues AS (
    SELECT
        PawanName,
        value AS NumberPart
    FROM RemoveDuplicateIntsFromNames
    CROSS APPLY STRING_SPLIT(Pawan_slug_name, '-')  -- Split by '-' first
), FilteredValues AS (
    SELECT PawanName, NumberPart
    FROM SplitValues
    WHERE LEN(NumberPart) > 1
), DistinctValues AS (
    SELECT PawanName, STRING_AGG(NumberPart, '-') AS CleanedValue
    FROM FilteredValues
    GROUP BY PawanName
)
SELECT r.PawanName, COALESCE(dv.CleanedValue, '') AS CleanedName
FROM RemoveDuplicateIntsFromNames r
LEFT JOIN DistinctValues dv
    ON r.PawanName = dv.PawanName;







