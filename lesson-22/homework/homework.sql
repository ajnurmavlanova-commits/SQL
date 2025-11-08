1.SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS RunningTotalPerCustomer
FROM sales_data
ORDER BY customer_id, order_date;
2.SELECT
    product_category,
    COUNT(*) AS NumberOfOrders
FROM sales_data
GROUP BY product_category
ORDER BY NumberOfOrders DESC;
3.SELECT
    product_category,
    MAX(total_amount) AS MaxTotalAmount
FROM sales_data
GROUP BY product_category
ORDER BY MaxTotalAmount DESC;
4.SELECT
    product_category,
    MIN(unit_price) AS MinUnitPrice
FROM sales_data
GROUP BY product_category
ORDER BY MinUnitPrice ASC;
5.SELECT
    sale_id,
    order_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvg3Days
FROM sales_data
ORDER BY order_date;
6.SELECT
    region,
    SUM(total_amount) AS TotalSales
FROM sales_data
GROUP BY region
ORDER BY TotalSales DESC;
7.SELECT
    customer_id,
    customer_name,
    SUM(total_amount) AS TotalPurchase,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS PurchaseRank
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY PurchaseRank;
8.SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS DifferenceFromPrevious
FROM sales_data
ORDER BY customer_id, order_date;
9.SELECT
    product_category,
    product_name,
    unit_price
FROM (
    SELECT
        product_category,
        product_name,
        unit_price,
        ROW_NUMBER() OVER (
            PARTITION BY product_category
            ORDER BY unit_price DESC
        ) AS rn
    FROM sales_data
) AS ranked_products
WHERE rn <= 3
ORDER BY product_category, unit_price DESC;
10.SELECT
    sale_id,
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY region
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS CumulativeSales
FROM sales_data
ORDER BY region, order_date;
11.
12.SELECT
    ID,
    SUM(ID) OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS SumPreValues
FROM your_table
ORDER BY ID;
13.
14.SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT product_category) AS CategoryCount
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1
ORDER BY customer_id;
15.SELECT
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS TotalSpending
FROM sales_data
GROUP BY customer_id, customer_name, region
HAVING SUM(total_amount) > (
    SELECT AVG(CustomerTotal)
    FROM (
        SELECT SUM(total_amount) AS CustomerTotal
        FROM sales_data
        WHERE region = sales_data.region
        GROUP BY customer_id
    ) AS RegionTotals
)
ORDER BY region, TotalSpending DESC;
16.SELECT
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS TotalSpending,
    DENSE_RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(total_amount) DESC
    ) AS SpendingRank
FROM sales_data
GROUP BY customer_id, customer_name, region
ORDER BY region, SpendingRank;
17.SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;
18.WITH MonthlySales AS (
    SELECT
        YEAR(order_date) AS SalesYear,
        MONTH(order_date) AS SalesMonth,
        SUM(total_amount) AS TotalSales
    FROM sales_data
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    SalesYear,
    SalesMonth,
    TotalSales,
    LAG(TotalSales) OVER (ORDER BY SalesYear, SalesMonth) AS PreviousMonthSales,
    CASE
        WHEN LAG(TotalSales) OVER (ORDER BY SalesYear, SalesMonth) IS NULL THEN NULL
        ELSE (TotalSales - LAG(TotalSales) OVER (ORDER BY SalesYear, SalesMonth)) 
             / LAG(TotalSales) OVER (ORDER BY SalesYear, SalesMonth) * 100
    END AS growth_rate
FROM MonthlySales
ORDER BY SalesYear, SalesMonth;
19.SELECT
    sale_id,
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS PreviousOrderAmount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    )
ORDER BY customer_id, order_date;
20.SELECT
    Name AS ProductName,
    Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)
ORDER BY Price DESC;
21.SELECT
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS SumVal
FROM MyData
ORDER BY Grp, Id;
22.SELECT
    ID,
    SUM(Cost) AS TotalCost,
    SUM(DISTINCT Quantity) AS TotalQuantity
FROM TheSumPuzzle
GROUP BY ID
ORDER BY ID;
23.WITH Numbers AS (
    SELECT 1 AS SeatNumber
    UNION ALL
    SELECT SeatNumber + 1
    FROM Numbers
    WHERE SeatNumber < (SELECT MAX(SeatNumber) FROM Seats)
),
MissingSeats AS (
    SELECT n.SeatNumber
    FROM Numbers n
    LEFT JOIN Seats s ON n.SeatNumber = s.SeatNumber
    WHERE s.SeatNumber IS NULL
),

















