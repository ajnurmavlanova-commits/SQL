1.CREATE TEMPORARY TABLE MonthlySales AS
SELECT
    p.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = YEAR(CURRENT_DATE)
  AND MONTH(s.SaleDate) = MONTH(CURRENT_DATE)
GROUP BY p.ProductID;
SELECT *
FROM MonthlySales;
2.CREATE OR REPLACE VIEW vw_ProductSalesSummary AS
SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    COALESCE(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;
3.CREATE OR ALTER FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);

    SELECT @TotalRevenue = COALESCE(SUM(s.Quantity * p.Price), 0)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE p.ProductID = @ProductID;

    RETURN @TotalRevenue;
END;
4.CREATE OR ALTER FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT
        p.ProductName,
        COALESCE(SUM(s.Quantity), 0) AS TotalQuantity,
        COALESCE(SUM(s.Quantity * p.Price), 0) AS TotalRevenue
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);
5.CREATE OR ALTER FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime VARCHAR(3) = 'Yes';
    IF @Number < 2
        RETURN 'No';
    WHILE @i * @i <= @Number
    BEGIN
        IF @Number % @i = 0
        BEGIN
            SET @IsPrime = 'No';
            BREAK;
        END
        SET @i = @i + 1;
    END

    RETURN @IsPrime;
END;
6.CREATE OR ALTER FUNCTION dbo.fn_GetNumbersBetween
(
    @Start INT,
    @End INT
)
RETURNS TABLE
AS
RETURN
(
    WITH NumbersCTE AS
    (
        SELECT @Start AS Number
        UNION ALL
        SELECT Number + 1
        FROM NumbersCTE
        WHERE Number + 1 <= @End
    )
    SELECT Number
    FROM NumbersCTE
);
7.CREATE OR ALTER FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    ;WITH DistinctSalaries AS
    (
        SELECT DISTINCT salary
        FROM Employee
    ),
    RankedSalaries AS
    (
        SELECT salary,
               ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
        FROM DistinctSalaries
    )
    SELECT @Result = salary
    FROM RankedSalaries
    WHERE rn = @N;

    RETURN @Result;
END;
8.SELECT TOP 1
    id,
    COUNT(*) AS num
FROM
(
    SELECT requester_id AS id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id, requester_id AS friend_id
    FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY num DESC;
9.CREATE OR ALTER VIEW vw_CustomerOrderSummary AS
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
10.SELECT 
    RowNumber,
    MAX(TestCase) OVER (
        ORDER BY RowNumber 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Workflow
FROM Gaps
ORDER BY RowNumber;







