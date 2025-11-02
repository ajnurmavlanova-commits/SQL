Level 1: Basic Subqueries
1.SELECT 
    id, 
    name, 
    salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);
2.SELECT 
    id,
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

Level 2: Nested Subqueries with Conditions
3.SELECT 
    e.id,
    e.name,
    d.department_name
FROM employees e
JOIN departments d 
    ON e.department_id = d.id
WHERE d.department_name = 'Sales';
4.SELECT 
    c.customer_id,
    c.name
FROM customers c
LEFT JOIN orders o 
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

Level 3: Aggregation and Grouping in Subqueries
5.SELECT 
    p.id,
    p.product_name,
    p.price,
    p.category_id
FROM products p
WHERE p.price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);
6.SELECT 
    e.id,
    e.name,
    e.salary,
    d.department_name
FROM employees e
JOIN departments d 
    ON e.department_id = d.id
WHERE e.department_id = (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

Level 4: Correlated Subqueries
7.SELECT 
    e.id,
    e.name,
    e.salary,
    e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
8.SELECT 
    s.student_id,
    s.name,
    g.course_id,
    g.grade
FROM grades g
JOIN students s 
    ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(g2.grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id
);

Level 5: Subqueries with Ranking and Complex Conditions
9.SELECT 
    id,
    product_name,
    price,
    category_id
FROM (
    SELECT 
        p.*,
        DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rnk
    FROM products p
) ranked
WHERE rnk = 3;
10.SELECT 
    e.id,
    e.name,
    e.salary,
    e.department_id
FROM employees e
WHERE 
    e.salary > (SELECT AVG(salary) FROM employees)
    AND e.salary < (
        SELECT MAX(salary)
        FROM employees
        WHERE department_id = e.department_id
    );


