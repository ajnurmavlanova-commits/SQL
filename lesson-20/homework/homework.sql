1.SELECT DISTINCT S1.CustomerName
FROM #Sales AS S1
WHERE EXISTS (
    SELECT 1
    FROM #Sales AS S2
    WHERE S2.CustomerName = S1.CustomerName
      AND S2.SaleDate >= '2024-03-01'
      AND S2.SaleDate < '2024-04-01'
);
2.SELECT Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT SUM(Quantity * Price) AS TotalRevenue
        FROM #Sales
        GROUP BY Product
    ) AS Sub
);
3.SELECT MAX(TotalAmount) AS SecondHighestSale
FROM (
    SELECT (Quantity * Price) AS TotalAmount
    FROM #Sales
    WHERE (Quantity * Price) < (
        SELECT MAX(Quantity * Price)
        FROM #Sales
    )
) AS Sub;
4.SELECT 
    DATEPART(MONTH, SaleDate) AS MonthNumber,
    DATENAME(MONTH, SaleDate) AS MonthName,
    (
        SELECT SUM(S2.Quantity)
        FROM #Sales AS S2
        WHERE DATEPART(MONTH, S2.SaleDate) = DATEPART(MONTH, S1.SaleDate)
    ) AS TotalQuantity
FROM #Sales AS S1
GROUP BY DATEPART(MONTH, SaleDate), DATENAME(MONTH, SaleDate)
ORDER BY MonthNumber;
5.SELECT DISTINCT S1.CustomerName
FROM #Sales AS S1
WHERE EXISTS (
    SELECT 1
    FROM #Sales AS S2
    WHERE S1.Product = S2.Product
      AND S1.CustomerName <> S2.CustomerName
);
6.SELECT 
    Name,
    SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
    SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
    SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;
7.WITH AllRelations AS (
    SELECT ParentID, ChildID
    FROM Family
    UNION ALL
    SELECT A.ParentID, B.ChildID
    FROM Family AS A
    INNER JOIN AllRelations AS B
        ON A.ChildID = B.ParentID
)
SELECT DISTINCT ParentID AS PID, ChildID AS CHID
FROM AllRelations
ORDER BY PID, CHID;
8.SELECT *
FROM #Orders AS O1
WHERE DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders AS O2
      WHERE O2.CustomerID = O1.CustomerID
        AND O2.DeliveryState = 'CA'
  );
9.UPDATE #residents
SET address = address + ' name=' + fullname
WHERE address NOT LIKE '%name=%';
10.WITH RoutePaths AS (
    SELECT 
        DepartureCity,
        ArrivalCity,
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT 
        RP.DepartureCity,
        R.ArrivalCity,
        CAST(RP.Route + ' - ' + R.ArrivalCity AS VARCHAR(MAX)) AS Route,
        RP.Cost + R.Cost AS Cost
    FROM RoutePaths AS RP
    INNER JOIN #Routes AS R
        ON RP.ArrivalCity = R.DepartureCity
    WHERE RP.Route NOT LIKE '% - ' + R.ArrivalCity + '%'
)
SELECT Route, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC;
11.WITH ProductGroups AS (
    SELECT *,
           SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
               OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductGroup
    FROM #RankingPuzzle
)
SELECT ProductGroup,
       Vals,
       ID,
       ROW_NUMBER() OVER (PARTITION BY ProductGroup ORDER BY ID) AS RankWithinProduct
FROM ProductGroups
ORDER BY ID;
12.SELECT EmployeeID,
       EmployeeName,
       Department,
       SalesAmount,
       SalesMonth,
       SalesYear
FROM (
    SELECT *,
           AVG(SalesAmount) OVER (PARTITION BY Department) AS DeptAvg
    FROM #EmployeeSales
) AS T
WHERE SalesAmount > DeptAvg;
13.SELECT E1.EmployeeID,
       E1.EmployeeName,
       E1.Department,
       E1.SalesAmount,
       E1.SalesMonth,
       E1.SalesYear
FROM #EmployeeSales AS E1
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales AS E2
    WHERE E2.SalesMonth = E1.SalesMonth
      AND E2.SalesYear = E1.SalesYear
    GROUP BY E2.SalesMonth, E2.SalesYear
    HAVING E1.SalesAmount = MAX(E2.SalesAmount)
);
14.SELECT E.EmployeeID,
       E.EmployeeName,
       E.Department
FROM #EmployeeSales AS E
WHERE NOT EXISTS (
    -- Find any month/year where this employee has no sales
    SELECT 1
    FROM (SELECT DISTINCT SalesMonth, SalesYear FROM #EmployeeSales) AS M
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales AS S
        WHERE S.EmployeeID = E.EmployeeID
          AND S.SalesMonth = M.SalesMonth
          AND S.SalesYear = M.SalesYear
    )
)
GROUP BY E.EmployeeID, E.EmployeeName, E.Department;
15.SELECT Name
FROM Products
WHERE Price > (
    SELECT AVG(Price) 
    FROM Products
);
16.SELECT Name, Stock
FROM Products
WHERE Stock < (
    SELECT MAX(Stock)
    FROM Products
);
17.SELECT Name
FROM Products
WHERE Category = (
    SELECT Category
    FROM Products
    WHERE Name = 'Laptop'
);
18.SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);
19.SELECT P.Name, P.Category, P.Price
FROM Products AS P
WHERE P.Price > (
    SELECT AVG(P2.Price)
    FROM Products AS P2
    WHERE P2.Category = P.Category
);
20.SELECT P.ProductID, P.Name, P.Category, P.Price
FROM Products AS P
WHERE EXISTS (
    SELECT 1
    FROM Orders AS O
    WHERE O.ProductID = P.ProductID
);
21.SELECT P.Name, SUM(O.Quantity) AS TotalQuantity
FROM Products AS P
JOIN Orders AS O
    ON P.ProductID = O.ProductID
GROUP BY P.Name
HAVING SUM(O.Quantity) > (
    SELECT AVG(Quantity)
    FROM Orders
);
22.SELECT P.ProductID, P.Name, P.Category, P.Price
FROM Products AS P
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders AS O
    WHERE O.ProductID = P.ProductID
);
23.SELECT TOP 1 P.Name, SUM(O.Quantity) AS TotalQuantity
FROM Products AS P
JOIN Orders AS O
    ON P.ProductID = O.ProductID
GROUP BY P.Name
ORDER BY SUM(O.Quantity) DESC;



















