1.WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
AllCombos AS (
    SELECT r.Region, d.Distributor
    FROM Regions r
    CROSS JOIN Distributors d
)
SELECT 
    ac.Region,
    ac.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllCombos ac
LEFT JOIN #RegionSales rs
    ON ac.Region = rs.Region AND ac.Distributor = rs.Distributor
ORDER BY ac.Region, ac.Distributor;
2.SELECT 
    e.managerId,
    m.name AS ManagerName,
    COUNT(*) AS DirectReports
FROM Employee e
JOIN Employee m
    ON e.managerId = m.id
WHERE e.managerId IS NOT NULL
GROUP BY e.managerId, m.name
HAVING COUNT(*) >= 5;
3.SELECT 
    p.product_name,
    SUM(o.unit) AS total_units
FROM Products p
JOIN Orders o
    ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01'
  AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;
4.WITH VendorOrders AS (
    SELECT
        CustomerID,
        Vendor,
        COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY CustomerID, Vendor
),
MaxOrders AS (
    SELECT
        CustomerID,
        MAX(OrderCount) AS MaxOrderCount
    FROM VendorOrders
    GROUP BY CustomerID
)
SELECT v.CustomerID, v.Vendor
FROM VendorOrders v
JOIN MaxOrders m
    ON v.CustomerID = m.CustomerID
   AND v.OrderCount = m.MaxOrderCount;
5.DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1; -- Assume prime initially

IF @Check_Prime < 2
    SET @IsPrime = 0;
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK; -- Not prime, exit loop
        END
        SET @i = @i + 1;
    END
END

SELECT CASE WHEN @IsPrime = 1 
            THEN 'This number is prime' 
            ELSE 'This number is not prime' 
       END AS Result;
6.WITH DeviceStats AS (
    SELECT
        Device_id,
        Locations,
        COUNT(*) AS signals_count
    FROM Device
    GROUP BY Device_id, Locations
),
MaxLocation AS (
    SELECT
        Device_id,
        Locations AS most_signals_location
    FROM (
        SELECT
            Device_id,
            Locations,
            signals_count,
            ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY signals_count DESC) AS rn
        FROM DeviceStats
    ) t
    WHERE rn = 1
)
SELECT
    d.Device_id,
    COUNT(DISTINCT d.Locations) AS num_locations,
    m.most_signals_location,
    COUNT(*) AS total_signals
FROM Device d
JOIN MaxLocation m ON d.Device_id = m.Device_id
GROUP BY d.Device_id, m.most_signals_location;
7.SELECT 
    EmpID,
    EmpName,
    Salary
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);
8.WITH TicketMatches AS (
    SELECT
        t.TicketID,
        COUNT(DISTINCT t.Number) AS matched_count
    FROM Tickets t
    JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
),
TicketStats AS (
    SELECT
        t.TicketID,
        tm.matched_count,
        COUNT(DISTINCT t.Number) AS total_ticket_numbers,
        (SELECT COUNT(*) FROM Numbers) AS total_winning_numbers
    FROM Tickets t
    LEFT JOIN TicketMatches tm ON t.TicketID = tm.TicketID
    GROUP BY t.TicketID, tm.matched_count
)
SELECT
    SUM(
        CASE 
            WHEN matched_count = total_winning_numbers THEN 100
            WHEN matched_count > 0 THEN 10
            ELSE 0
        END
    ) AS total_winnings
FROM TicketStats;
9.WITH UserPlatforms AS (
    SELECT
        Spend_date,
        User_id,
        SUM(CASE WHEN Platform = 'Mobile' THEN Amount ELSE 0 END) AS Mobile_amount,
        SUM(CASE WHEN Platform = 'Desktop' THEN Amount ELSE 0 END) AS Desktop_amount,
        COUNT(DISTINCT Platform) AS Platform_count
    FROM Spending
    GROUP BY Spend_date, User_id
)
SELECT
    Spend_date,
    'Mobile' AS Platform,
    SUM(Mobile_amount) AS Total_Amount,
    COUNT(CASE WHEN Mobile_amount > 0 THEN 1 END) AS Total_users
FROM UserPlatforms
GROUP BY Spend_date

UNION ALL

SELECT
    Spend_date,
    'Desktop' AS Platform,
    SUM(Desktop_amount) AS Total_Amount,
    COUNT(CASE WHEN Desktop_amount > 0 THEN 1 END) AS Total_users
FROM UserPlatforms
GROUP BY Spend_date

UNION ALL

SELECT
    Spend_date,
    'Both' AS Platform,
    SUM(Mobile_amount + Desktop_amount) AS Total_Amount,
    COUNT(*) AS Total_users
FROM UserPlatforms
GROUP BY Spend_date
ORDER BY Spend_date, Platform;








