TASK 1 
Define the following terms: data, database, relational database, and table.
1.Data-Данные -это разные информацииб к ним могут относится факты,цифры или символы к частности отдельно не могут иметь смысла 
2.Database-База данных- скопление этих данных к которой можно легко обращаться, управлять и обновлять
3.Relational database-Реляционная база данных-Тип базы данных, который организует данные в таблицы (строки и столбцы) и устанавливает связи между этими таблицами
4.Table-Структурированная коллекция связанных данных, организованных в строки (записи) и столбцы (поля)

TASK 2
List five key features of SQL Server
1. Relational Database Engine
2. Security and Access Control
3. High Availability and Disaster Recovery
4. Business Intelligence and Analytics
5. Scalability and Performance

TASK 3
What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
1. Windows Authentication
2. SQL Server Authentication

TASK 4&5 
create database SchoolDB 
use SchoolDB 
create table Students (Studentid int , name varchar(50), age int) 
select * from Students

TASK 6 
Describe the differences between SQL Server, SSMS, and SQL.
SQL = the language.
SQL Server = the database system that understands SQL.
SSMS = the tool you use to talk to SQL Server (usually using SQL).

TASK 7
Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
1. DDL (Data Definition Language — структура базы)
-- Создать базу данных
CREATE DATABASE School;

-- Создать таблицу
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Age INT
);

-- Изменить таблицу (добавить колонку)
ALTER TABLE Students ADD Email NVARCHAR(100);

-- Удалить таблицу
DROP TABLE Students;

-- Очистить таблицу, сохранив структуру
TRUNCATE TABLE Students;
2. DML (Data Manipulation Language — работа с данными)
-- Добавить запись
INSERT INTO Students (StudentID, Name, Age, Email)
VALUES (1, 'Алиса', 20, 'alisa@mail.com');

-- Обновить данные
UPDATE Students
SET Age = 21
WHERE StudentID = 1;

-- Удалить запись
DELETE FROM Students
WHERE StudentID = 1;

-- Слияние данных (если запись есть – обновить, если нет – вставить)
MERGE Students AS T
USING (SELECT 2 AS StudentID, 'Боб' AS Name, 22 AS Age) AS S
ON T.StudentID = S.StudentID
WHEN MATCHED THEN UPDATE SET T.Age = S.Age
WHEN NOT MATCHED THEN INSERT (StudentID, Name, Age)
VALUES (S.StudentID, S.Name, S.Age);
3. DQL (Data Query Language — выборка данных)
-- Выбрать все записи
SELECT * FROM Students;

-- Выбрать только имя и возраст
SELECT Name, Age FROM Students;

-- Условие
SELECT * FROM Students WHERE Age > 18;

-- Сортировка
SELECT * FROM Students ORDER BY Age DESC;

-- Группировка и агрегаты
SELECT Age, COUNT(*) AS CountStudents
FROM Students
GROUP BY Age
HAVING COUNT(*) > 1;

-- Объединение таблиц
SELECT s.Name, c.CourseName
FROM Students s
INNER JOIN Courses c ON s.StudentID = c.StudentID;
4. DCL (Data Control Language — управление доступом)
-- Выдать права на чтение и вставку
GRANT SELECT, INSERT ON Students TO user1;

-- Отозвать права
REVOKE INSERT ON Students FROM user1;

-- Запретить доступ (в T-SQL)
DENY DELETE ON Students TO user1;
5. TCL (Transaction Control Language — транзакции)
-- Начало транзакции
BEGIN TRANSACTION;

-- Изменяем данные
UPDATE Students SET Age = 25 WHERE StudentID = 2;

-- Если всё ок – сохранить
COMMIT;

-- Если ошибка – откатить
ROLLBACK;

-- Точка сохранения
SAVE TRANSACTION SavePoint1;
6. Расширения SQL (T-SQL, PL/SQL)
-- Переменные и условия
DECLARE @Age INT = 18;

IF @Age >= 18
    PRINT 'Совершеннолетний';
ELSE
    PRINT 'Несовершеннолетний';

-- Цикл
DECLARE @i INT = 1;
WHILE @i <= 5
BEGIN
    PRINT 'Студент №' + CAST(@i AS NVARCHAR);
    SET @i = @i + 1;
END;
7. Объекты базы данных
-- Хранимая процедура
CREATE PROCEDURE GetAllStudents
AS
BEGIN
    SELECT * FROM Students;
END;

-- Функция
CREATE FUNCTION GetStudentCount()
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(*) FROM Students);
END;

-- Триггер (выполняется после вставки)
CREATE TRIGGER trg_InsertStudent
ON Students
AFTER INSERT
AS
BEGIN
    PRINT 'Добавлен новый студент!';
END;
 8. Функции SQL
-- Агрегаты
SELECT COUNT(*) FROM Students;
SELECT AVG(Age) FROM Students;

-- Строковые
SELECT UPPER(Name) AS UpperName FROM Students;
SELECT SUBSTRING(Name, 1, 3) AS ShortName FROM Students;

-- Дата/время
SELECT GETDATE() AS Now;
SELECT DATEADD(YEAR, 1, GETDATE()) AS NextYear;

-- Математические
SELECT ROUND(3.14159, 2) AS PiRounded;
SELECT ABS(-42) AS PositiveNumber;

TASK 8 
Write a query to insert three records into the Students table.

create database SchoolDB 
use SchoolDB 
create table Students (Studentid int , name varchar(50), age int) 
insert into Students (1,'Baxodir',27),(2,'Mamur',27),(3,'Davronbek',28)
select * from Students






















