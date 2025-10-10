🟢 Easy-Level Tasks (10)
1.SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
CROSS JOIN Suppliers s;
2.SELECT 
    d. DepartmentName,
    e. Name  
FROM Departments d
CROSS JOIN Employees e;
3.SELECT 
    s.SupplierName,
    p.ProductName
FROM Products p
JOIN Suppliers s 
    ON p.SupplierID = s.SupplierID;
4.SELECT 
    c.FirstName ,
    o.OrderID
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID;
5.SELECT 
    s.StudentName,
    c.CourseName
FROM Students s
CROSS JOIN Courses c;
6.SELECT 
    p.ProductName,
    o.OrderID
FROM Products p
JOIN Orders o 
    ON p.ProductID = o.ProductID;
7.SELECT 
    e.Name,
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID;
8.	SELECT 
    s.Name,
    e.CourseID
FROM Students s
JOIN Enrollments e 
    ON s.StudentID = e.StudentID;
9.	SELECT 
    o.OrderID,
    p.PaymentID,
    p. Amount,
    p.PaymentDate
FROM Orders o
JOIN Payments p 
    ON o.OrderID = p.OrderID;
10.SELECT 
    o.OrderID,
    p.ProductName,
    p.Price
FROM Orders o
JOIN Products p 
    ON o.ProductID = p.ProductID
WHERE p.Price > 100;

🟡 Medium (10 puzzles)
11.SELECT 
    e.Name,

    d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID <> d.DepartmentID;
12.SELECT 
    o.OrderID,
    p.ProductName,
    o.Quantity AS OrderedQuantity,
    p.StockQuantity
FROM Orders o
JOIN Products p 
    ON o.ProductID = p.ProductID
WHERE o.Quantity > p.StockQuantity;
13.
SELECT 
    c.FirstName,
    s.ProductID,
    s. SaleAmount
FROM Customers c
JOIN Sales s 
    ON c.CustomerID = s.CustomerID
WHERE s.SaleAmount >= 500;
14.
SELECT 
    s.Name,
    c.CourseName
FROM Enrollments e
JOIN Students s 
    ON e.StudentID = s.StudentID
JOIN Courses c 
    ON e.CourseID = c.CourseID;
15.
	SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
JOIN Suppliers s 
    ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%Tech%';
16.SELECT 
    o.OrderID,
    o.TotalAmount,
    p.Amount
FROM Orders o
JOIN Payments p 
    ON o.OrderID = p.OrderID
WHERE p.Amount < o.TotalAmount;
17.SELECT 
    e.Name,
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID;
18.
	SELECT 
    p.ProductName,
    c.CategoryName
FROM Products p
JOIN Categories c 
    ON p.ProductID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');
19.
SELECT 
    s.SaleID,
    s.CustomerID,
    s.ProductID,
    s.SaleAmount,
    c.FirstName,
    c.Country
FROM Sales s
JOIN Customers c 
    ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';
20.SELECT 
    o.OrderID,
    o.CustomerID,
    o.TotalAmount,
    c.FirstName,
    c.Country
FROM Orders o
JOIN Customers c 
    ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany'
  AND o.TotalAmount > 100;

🔴 Hard (5 puzzles)(Do some research for the tasks below)
21. SELECT 
    e1.Name AS Employee1,
    e1.DepartmentID AS Dept1,
    e2.Name AS Employee2,
    e2.DepartmentID AS Dept2
FROM Employees e1
CROSS JOIN Employees e2
WHERE e1.DepartmentID <> e2.DepartmentID;
22.SELECT 
    p.PaymentID,
    o.OrderID,
    pr.ProductName,
    o.Quantity,
    pr.Price AS ProductPrice,
    (o.Quantity * pr.Price) AS ExpectedAmount,
    p.Amount AS PaidAmount
FROM Payments p
JOIN Orders o ON p.OrderID = o.OrderID
JOIN Products pr ON o.ProductID = pr.ProductID
WHERE p.Amount <> (o.Quantity * pr.Price);
23.SELECT s.StudentID, s.Name
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IS NULL;
24.SELECT m.EmployeeID AS ManagerID,
       m.Name AS ManagerName,
       m.Salary AS ManagerSalary,
       e.EmployeeID AS EmployeeID,
       e.Name AS EmployeeName,
       e.Salary AS EmployeeSalary
FROM Employees m
JOIN Employees e ON e.ManagerID = m.EmployeeID
WHERE m.Salary <= e.Salary;
25.SELECT DISTINCT c.CustomerID, c.FirstName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;







