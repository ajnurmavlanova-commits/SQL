Easy Tasks
1.SELECT 
    SUBSTRING_INDEX(Name, ',', 1) AS FirstName,
    SUBSTRING_INDEX(Name, ',', -1) AS Surname
FROM TestMultipleColumns;
2.CREATE TABLE TestPercent (
  TextValue VARCHAR(100)
);
3.CREATE TABLE Splitter (
  InputString VARCHAR(100)
);
4.CREATE TABLE testDots (
  Vals VARCHAR(100)
);
5.CREATE TABLE CountSpaces (
  texts VARCHAR(100)
);
6.SELECT 
    e.EmpID,
    e.Name AS EmployeeName,
    e.Salary AS EmployeeSalary,
    m.Name AS ManagerName,
    m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m 
    ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;
7.SELECT 
    Employee_ID,
    First_Name,
    Last_Name,
    Hire_Date,
    TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) AS Years_of_Service
FROM Employees
WHERE TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) > 10
  AND TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) < 15
ORDER BY Years_of_Service DESC;


Medium Tasks
1.SELECT 
    w1.id,
    w1.recordDate,
    w1.temperature
FROM weather w1
JOIN weather w2 
    ON DATE_ADD(w2.recordDate, INTERVAL 1 DAY) = w1.recordDate
WHERE w1.temperature > w2.temperature;
2.SELECT 
    player_id,
    MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;
3.SELECT 
    SUBSTRING_INDEX(SUBSTRING_INDEX(fruits, ',', 3), ',', -1) AS third_item
FROM fruits;
4.SELECT 
    Employee_ID,
    First_Name,
    Last_Name,
    Hire_Date,
    TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) AS Years_of_Service,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) < 1 THEN 'New Hire'
        WHEN TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
        WHEN TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) BETWEEN 11 AND 20 THEN 'Senior'
        WHEN TIMESTAMPDIFF(YEAR, Hire_Date, CURDATE()) > 20 THEN 'Veteran'
    END AS Employment_Stage
FROM Employees
ORDER BY Years_of_Service DESC;
5.SELECT 
    Vals,
    REGEXP_SUBSTR(Vals, '^[0-9]+') AS LeadingInteger
FROM GetIntegers;


Difficult Tasks
1.SELECT 
    Vals AS OriginalVals,
    CONCAT(
        SUBSTRING_INDEX(SUBSTRING_INDEX(Vals, ',', 2), ',', -1), ',',  -- 2nd value
        SUBSTRING_INDEX(Vals, ',', 1),                                -- 1st value
        SUBSTRING(Vals, LOCATE(',', Vals, LOCATE(',', Vals) + 1))     -- everything after 2nd comma
    ) AS SwappedVals
FROM MultipleVals;
2.WITH Numbers AS (
    SELECT TOP (LEN('sdgfhsdgfhs@121313131'))
           ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
SELECT 
    n AS position,
    SUBSTRING('sdgfhsdgfhs@121313131', n, 1) AS character
FROM Numbers;
3.SELECT 
    player_id,
    device_id
FROM Activity
WHERE (player_id, event_date) IN (
    SELECT 
        player_id,
        MIN(event_date)
    FROM Activity
    GROUP BY player_id
);
4.SELECT 
    'rtcfvty34redt' AS mixed_value,
    REGEXP_REPLACE('rtcfvty34redt', '[0-9]', '') AS characters,
    REGEXP_REPLACE('rtcfvty34redt', '[^0-9]', '') AS numbers;













