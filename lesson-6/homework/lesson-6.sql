--6.1 Finding Distinct Values
---1-WAY
SELECT col1, col2 
FROM InputTbl
WHERE col1 < col2
UNION
SELECT col1, col2 
FROM InputTbl
WHERE col2 > col1

---2-WAY
SELECT DISTINCT	
	LEAST(col1, col2) AS col1,
	GREATEST(col1, col2) AS col2
FROM InputTbl

--6.2 If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.
SELECT * FROM TestMultipleZero
WHERE NOT (A=0 AND B=0 AND C=0 AND D=0)

--6.3 Find those with odd ids
SELECT * 
FROM section1
WHERE id % 2 = 1

--6.4 Person with the smallest id (use the table in puzzle 3)
SELECT *
FROM section1
WHERE id = (SELECT MIN(id) FROM section1)

--6.5 Person with the highest id (use the table in puzzle 3)
SELECT *
FROM section1
WHERE id = (SELECT MAX(id) FROM section1)

--6.6 People whose name starts with b (use the table in puzzle 3)
SELECT *
FROM section1
WHERE name LIKE 'B%'

--6.7 Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
SELECT 
	Code 
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\'