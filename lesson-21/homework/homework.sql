1.SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales
ORDER BY SaleDate;
2.SELECT 
    ProductName,
    SUM(Quantity) AS TotalQuantity,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS ProductRank
FROM ProductSales
GROUP BY ProductName
ORDER BY ProductRank;
3.SELECT SaleID, 
       ProductName, 
       SaleDate, 
       SaleAmount, 
       Quantity, 
       CustomerID
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) AS ranked
WHERE rn = 1
ORDER BY CustomerID;
4.SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales
ORDER BY SaleDate;
5.SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales
ORDER BY SaleDate;
6.SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER (ORDER BY SaleDate)
ORDER BY SaleDate;
7.SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
    SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DifferenceFromPrevious
FROM ProductSales
ORDER BY ProductName, SaleDate;
8.SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount,
    CASE 
        WHEN LEAD(SaleAmount) OVER (ORDER BY SaleDate) IS NULL THEN NULL
        ELSE ((LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) / SaleAmount) * 100
    END AS PercentageChange
FROM ProductSales
ORDER BY SaleDate;
9.SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
    CASE 
        WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NULL THEN NULL
        ELSE CAST(SaleAmount AS DECIMAL(10,2)) / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
    END AS RatioToPrevious
FROM ProductSales
ORDER BY ProductName, SaleDate;
10.SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
    FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS FirstSaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DifferenceFromFirst
FROM ProductSales
ORDER BY ProductName, SaleDate;
11.SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount AS CurrentSaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
ORDER BY ProductName, SaleDate;
12.SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (ORDER BY SaleDate 
                          ROWS UNBOUNDED PRECEDING) AS ClosingBalance
FROM ProductSales
ORDER BY SaleDate;
13.SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (
        ORDER BY SaleDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAverage3
FROM ProductSales
ORDER BY SaleDate;
14.SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER () AS AvgSaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DifferenceFromAverage
FROM ProductSales
ORDER BY SaleDate;
15.WITH SalaryRanks AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT *
FROM SalaryRanks
ORDER BY SalaryRank, Salary DESC;
16.WITH DepartmentSalaryRank AS (
    SELECT
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT *
FROM DepartmentSalaryRank
WHERE SalaryRank <= 2
ORDER BY Department, SalaryRank;
17.WITH DepartmentSalaryRank AS (
    SELECT
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
    FROM Employees1
)
SELECT *
FROM DepartmentSalaryRank
WHERE SalaryRank = 1
ORDER BY Department;
18.SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (
        PARTITION BY Department
        ORDER BY HireDate
        ROWS UNBOUNDED PRECEDING
    ) AS RunningTotalSalary
FROM Employees1
ORDER BY Department, HireDate;
19.SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalDepartmentSalary
FROM Employees1
ORDER BY Department, EmployeeID;
20.SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgDepartmentSalary
FROM Employees1
ORDER BY Department, EmployeeID;
21.SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS DeptAverageSalary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS DifferenceFromDeptAvg
FROM Employees1
ORDER BY Department, EmployeeID;
22.SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY HireDate
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAverageSalary3
FROM Employees1
ORDER BY HireDate;
23.SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (
        ORDER BY HireDate DESC
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS SumLast3Hired
FROM Employees1
ORDER BY HireDate DESC;



















