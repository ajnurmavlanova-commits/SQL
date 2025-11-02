Easy Tasks
1.SELECT 
    CAST(EMPLOYEE_ID AS VARCHAR(10)) + '-' + FIRST_NAME + ' ' + LAST_NAME AS EmployeeInfo
FROM Employees;
2.UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999')
WHERE PHONE_NUMBER LIKE '%124%';
3.SELECT 
    FIRST_NAME AS [First Name],
    LEN(FIRST_NAME) AS [Name Length]
FROM Employees
WHERE FIRST_NAME LIKE 'A%' 
   OR FIRST_NAME LIKE 'J%' 
   OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;
4.SELECT 
    MANAGER_ID,
    SUM(SALARY) AS TOTAL_SALARY
FROM Employees
GROUP BY MANAGER_ID
ORDER BY MANAGER_ID;
5.SELECT 
    Year1 AS Year,
    GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;
6.SELECT *
FROM Cinema
WHERE id % 2 = 1
  AND description <> 'boring'
ORDER BY rating DESC;
7.SELECT *
FROM SingleOrder
ORDER BY (Id = 0), Id;
8.SELECT 
    COALESCE(ssn, passportid, itin) AS First_Non_Null_Value
FROM Person;

Medium Tasks
1.SELECT 
    FullName,
    SPLIT_PART(FullName, ' ', 1) AS FirstName,
    SPLIT_PART(FullName, ' ', 2) AS MiddleName,
    SPLIT_PART(FullName, ' ', 3) AS LastName
FROM Students;
2.SELECT *
FROM Orders
WHERE DeliveryState = 'Texas'
  AND CustomerID IN (
      SELECT DISTINCT CustomerID
      FROM Orders
      WHERE DeliveryState = 'California'
  );
3.SELECT STRING_AGG(DML, ' ') AS SQL_Statement
FROM DMLTable;
4.SELECT *
FROM Employees
WHERE (
    LEN(LOWER(FIRST_NAME + LAST_NAME)) 
    - LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a', ''))
) >= 3;
5.SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS Total_Employees,
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN (CURRENT_DATE - HIRE_DATE) > (365 * 3) THEN 1 
                ELSE 0 
            END
        ) / COUNT(*), 
    2) AS Pct_More_Than_3_Years
FROM Employees
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;


Difficult Tasks
1.SELECT 
    StudentID,
    FullName,
    Grade,
    SUM(Grade) OVER (ORDER BY StudentID) AS RunningTotal
FROM Students
ORDER BY StudentID;
2.Student(
  ID INT,
  Name VARCHAR(100),
  Birthday DATE
);
3.CREATE TABLE PlayerScores
(
  PlayerA  INTEGER,
  PlayerB  INTEGER,
  Score    INTEGER NOT NULL,
  PRIMARY KEY (PlayerA, PlayerB)
);
4.SELECT
  REGEXP_REPLACE('tf56sd#%OqH', '[^A-Z]', '') AS Uppercase,
  REGEXP_REPLACE('tf56sd#%OqH', '[^a-z]', '') AS Lowercase,
  REGEXP_REPLACE('tf56sd#%OqH', '[^0-9]', '') AS Numbers,
  REGEXP_REPLACE('tf56sd#%OqH', '[A-Za-z0-9]', '') AS Others;












