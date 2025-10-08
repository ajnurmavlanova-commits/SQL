Puzzle 1: Finding Distinct Values
1.SELECT 
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl
GROUP BY 
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END;
2.SELECT DISTINCT col1, col2
FROM (
    SELECT 
        CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
        CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
    FROM InputTbl
) AS normalized_pairs;

Puzzle 2: Removing Rows with All Zeroes
SELECT *
FROM TestMultipleZero
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0);

Puzzle 3: Find those with odd ids
SELECT *
FROM section1
WHERE id % 2 <> 0;

Puzzle 4: Person with the smallest id (use the table in puzzle 3)
SELECT *
FROM section1
WHERE id = (SELECT MIN(id) FROM section1);

Puzzle 5: Person with the highest id (use the table in puzzle 3)
SELECT *
FROM section1
WHERE id = (SELECT MAX(id) FROM section1);

Puzzle 6: People whose name starts with b (use the table in puzzle 3)
SELECT *
FROM section1
WHERE name LIKE 'B%';

Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';



