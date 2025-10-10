🟢 Easy-Level Tasks (10)
1.SELECT s.StudentID, s.Name
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;
2.SELECT 
    c.FirstName,
    c.LastName,
    o.OrderDate
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;
3.SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;
4.SELECT 
    s.SupplierName,
    p.ProductName
FROM Suppliers s
LEFT JOIN Products p
    ON s.SupplierID = p.SupplierID;
5.SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentDate,
    p.Amount
FROM Orders o
FULL OUTER JOIN Payments p
    ON o.OrderID = p.OrderID;
6.SELECT 
    e.Name AS EmployeeName,
    m.Name AS ManagerName
FROM Employees e
LEFT JOIN Employees m
    ON e.ManagerID = m.EmployeeID;
7.SELECT 
    s.Name AS StudentName,
    c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';
8.SELECT 
    c.FirstName,
    c.LastName,
    o.Quantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;
9.SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';

🟠 Medium-Level Tasks (9)
10.SELECT 
    d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) > 5;
11.SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;
12.SELECT 
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;
13.SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;
14.SELECT 
    e1.Name AS Employee1,
    e2.Name AS Employee2,
    e1.ManagerID
FROM Employees e1
JOIN Employees e2
    ON e1.ManagerID = e2.ManagerID
    AND e1.EmployeeID < e2.EmployeeID
WHERE e1.ManagerID IS NOT NULL;
15.SELECT 
    O.OrderID,
    O.OrderDate,
    C.FirstName,
    C.LastName
FROM Orders O
JOIN Customers C
    ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 2022;
16.SELECT 
    E.Name AS EmployeeName,
    E.Salary,
    D.DepartmentName
FROM Employees E
JOIN Departments D
    ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales'
  AND E.Salary > 60000;
17.SELECT 
    O.OrderID,
    O.OrderDate,
    P.PaymentDate,
    P.Amount
FROM Orders O
INNER JOIN Payments P
    ON O.OrderID = P.OrderID;
18.SELECT 
    P.ProductID,
    P.ProductName
FROM Products P
LEFT JOIN Orders O
    ON P.ProductID = O.ProductID
WHERE O.OrderID IS NULL;

🔴 Hard-Level Tasks (9)
19.SELECT 
    E.Name AS EmployeeName,
    E.Salary
FROM Employees E
WHERE E.Salary > (
    SELECT AVG(E2.Salary)
    FROM Employees E2
    WHERE E2.DepartmentID = E.DepartmentID
);
20.SELECT 
    O.OrderID,
    O.OrderDate
FROM Orders O
LEFT JOIN Payments P
    ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL
  AND O.OrderDate < '2020-01-01';
21.SELECT 
    P.ProductID,
    P.ProductName
FROM Products P
LEFT JOIN Categories C
    ON P.Category = C.CategoryID
WHERE C.CategoryID IS NULL;
22.SELECT 
    E1.Name AS Employee1,
    E2.Name AS Employee2,
    E1.ManagerID,
    E1.Salary
FROM Employees E1
JOIN Employees E2
    ON E1.ManagerID = E2.ManagerID
    AND E1.EmployeeID < E2.EmployeeID
WHERE E1.Salary > 60000 
  AND E2.Salary > 60000;
23.SELECT 
    E.Name AS EmployeeName,
    D.DepartmentName
FROM Employees E
JOIN Departments D
    ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%';
24.SELECT 
    S.SaleID,
    P.ProductName,
    S.SaleAmount
FROM Sales S
JOIN Products P
    ON S.ProductID = P.ProductID
WHERE S.SaleAmount > 500;
25.SELECT 
    S.StudentID,
    S.Name AS StudentName
FROM Students S
WHERE NOT EXISTS (
    SELECT 1
    FROM Enrollments E
    JOIN Courses C ON E.CourseID = C.CourseID
    WHERE E.StudentID = S.StudentID
      AND C.CourseName = 'Math 101'
);
26.SELECT 
    O.OrderID,
    O.OrderDate,
    P.PaymentID
FROM Orders O
LEFT JOIN Payments P
    ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;
27.SELECT 
    P.ProductID,
    P.ProductName,
    C.CategoryName
FROM Products P
JOIN Categories C
    ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');
