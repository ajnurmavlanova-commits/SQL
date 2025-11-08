1.SELECT
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates
ORDER BY Id;
2.SELECT
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates
ORDER BY Id;
3.SELECT
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVal) AS TotalOfMaxVals
FROM (
    SELECT
        Id,
        rID,
        MAX(Vals) AS MaxVal
    FROM MyTabel
    GROUP BY Id, rID
) AS MaxPerId
GROUP BY rID
ORDER BY rID;
4.SELECT t.ID, t.Item, t.Vals
FROM TestMaximum t
INNER JOIN (
    SELECT ID, MAX(Vals) AS MaxVal
    FROM TestMaximum
    GROUP BY ID
) AS MaxPerID
ON t.ID = MaxPerID.ID AND t.Vals = MaxPerID.MaxVal
ORDER BY t.Vals DESC;
5.SELECT
    Id,
    SUM(MaxVal) AS SumOfMax
FROM (
    SELECT
        Id,
        DetailedNumber,
        MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS MaxPerDetail
GROUP BY Id
ORDER BY Id;
6.SELECT
    Id,
    a,
    b,
    CASE 
        WHEN a - b = 0 THEN ''
        ELSE CAST(a - b AS VARCHAR(20))
    END AS OUTPUT
FROM TheZeroPuzzle
ORDER BY Id;
7.





















