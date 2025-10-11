1.SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a
    ON p.personId = a.personId;
2.SELECT 
    e.name AS Employee
FROM Employee e
JOIN Employee m
    ON e.managerId = m.id
WHERE e.salary > m.salary;
3.SELECT email AS Email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;
4.DELETE p
FROM Person p
JOIN Person p2
  ON p.email = p2.email
 AND p.id > p2.id;
5.SELECT DISTINCT g.ParentName
FROM girls g
LEFT JOIN boys b
    ON g.ParentName = b.ParentName
WHERE b.ParentName IS NULL;
6.SELECT 
    customer_id,
    SUM(amount) AS TotalAmount,
    MIN(weight) AS LeastWeight
FROM Sales.Orders
WHERE weight > 50
GROUP BY customer_id;
7.SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
    ON c1.Item = c2.Item
ORDER BY [Item Cart 1], [Item Cart 2];
8.SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
    ON c.id = o.customerId
WHERE o.customerId IS NULL;
9.SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id
   AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
