--14.1 Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
SELECT 
	LTRIM(RTRIM(SUBSTRING(Name,CHARINDEX(',',Name)+1,LEN(Name)))) AS Name,
	LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',',Name)-1))) AS Surname
FROM TestMultipleColumns

--14.2 Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
SELECT * 
FROM TestPercent
WHERE CHARINDEX('%', Strs) > 0

--14.3 In this puzzle you will have to split a string based on dot(.).(Splitter)
SELECT *,
	LEFT(Vals, CHARINDEX('.', Vals)-1) AS first_letter,
	SUBSTRING(Vals, CHARINDEX('.', Vals)+1,1) AS second_letter,
	SUBSTRING(Vals, CHARINDEX('.', Vals)+3,1) AS third_letter
FROM Splitter

--14.4 Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS)
DECLARE @input VARCHAR(70) = '1234ABC123456XYZ1234567890ADS'
SELECT TRANSLATE(@input, '0123456789','XXXXXXXXXX') AS new_string

--14.5 Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
SELECT Vals
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals,'.', '')) > 2

--14.6 Write a SQL query to count the occurrences of a substring within a string in a given column.(Not table)
--table is not provided for the question

--14.7 Write a SQL query to count the spaces present in the string.(CountSpaces)
SELECT *,
	LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces 

--14.8 Write a SQL query that finds out employees who earn more than their managers.(Employee)
SELECT 
	e.name AS Employee
FROM Employee e
JOIN Employee m
ON e.managerId = m.id
WHERE e.salary > m.salary

--14.9 Write a SQL query to separate the integer values and the character values into two different columns.(SeperateNumbersAndCharcters)
SELECT *,
REPLACE(TRANSLATE(Value, '0123456789',SPACE(10)),' ','') AS OnlyLetters,
REPLACE(TRANSLATE(Value, 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',SPACE(52)),' ','') AS OnlyNumbers
FROM SeperateNumbersAndCharcters

--14.10 write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
SELECT cur.Id, cur.RecordDate, cur.Temperature FROM weather cur
JOIN weather prev
ON cur.RecordDate = DATEADD(DAY,1,prev.RecordDate)
WHERE cur.Temperature > prev.Temperature

--14.11 Write a SQL query that reports the device that is first logged in for each player.(Activity)
SELECT 
	player_id,
	device_id,
	event_date
FROM (
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) AS rank
	FROM Activity
) AS rn
WHERE rank = 1

--14.12 Write an SQL query that reports the first login date for each player.(Activity)
SELECT player_id, MIN(event_date) AS first_log_date
FROM Activity
GROUP BY player_id

--14.13 Your task is to split the string into a list using a specific separator (such as a space, comma, etc.), and then return the third item from that list.(fruits)
SELECT *, 
PARSENAME(REPLACE(fruit_list, ',', '.'), 2) AS third_item 
FROM fruits

--14.14 Write a SQL query to create a table where each character from the string will be converted into a row, with each row having a single column.(sdgfhsdgfhs@121313131)
CREATE TABLE characters (char CHAR(1));
WITH cte AS (
  SELECT 1 AS pos, SUBSTRING('sdgfhsdgfhs@121313131', 1, 1) AS char
  UNION ALL
  SELECT pos + 1, SUBSTRING('sdgfhsdgfhs@121313131', pos + 1, 1)
  FROM cte
  WHERE pos < LEN('sdgfhsdgfhs@121313131')
)
INSERT INTO characters
SELECT char FROM cte
OPTION (MAXRECURSION 100)
SELECT * FROM characters
--14.15 You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
SELECT 
	p1.id,
	CASE
		WHEN p1.code = 0 THEN p2.code
		ELSE p1.code END AS code
FROM p1
JOIN p2 ON p1.id = p2.id

--14.16 You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week. For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
WITH WeeklySales AS (
    SELECT 
        FinancialWeek,
        Area,
        SUM(COALESCE(SalesLocal, 0)) + SUM(COALESCE(SalesRemote, 0)) AS TotalWeeklySales
    FROM WeekPercentagePuzzle
    GROUP BY FinancialWeek, Area
),

DailySales AS (
    SELECT 
        s.Area,
        s.Date,
        s.DayName,
        s.DayOfWeek,
        s.FinancialWeek,
        COALESCE(s.SalesLocal, 0) + COALESCE(s.SalesRemote, 0) AS DailySales,
        ws.TotalWeeklySales
    FROM WeekPercentagePuzzle s
    JOIN WeeklySales ws ON s.FinancialWeek = ws.FinancialWeek AND s.Area = ws.Area
)

SELECT 
    ds.Area,
    ds.Date,
    ds.DayName,
    ds.DayOfWeek,
    ds.FinancialWeek,
    ds.DailySales,
    ds.TotalWeeklySales,
    CASE 
        WHEN ds.TotalWeeklySales = 0 THEN 0
        ELSE ROUND((ds.DailySales * 100.0 / ds.TotalWeeklySales), 2)
    END AS SalesPercentage
FROM DailySales ds
ORDER BY ds.FinancialWeek, ds.Area, ds.Date

--14.17 In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
SELECT * FROM MultipleVals
--14.18 Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT *
FROM FindSameCharacters
WHERE Vals IS NOT NULL
  AND LEN(Vals) > 1
  AND Vals NOT LIKE '%[^' + LEFT(Vals, 1) + ']%'

--14.19 Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)
SELECT
    PawanName,
    CASE 
        WHEN LEN(SUBSTRING(PAWAN_SLUG_NAME, CHARINDEX('-', PAWAN_SLUG_NAME) + 1, LEN(PAWAN_SLUG_NAME))) = 1 
            THEN LEFT(PAWAN_SLUG_NAME, CHARINDEX('-', PAWAN_SLUG_NAME) - 1)
        ELSE 
            LEFT(PAWAN_SLUG_NAME, CHARINDEX('-', PAWAN_SLUG_NAME)) + 
            REPLACE(
                SUBSTRING(PAWAN_SLUG_NAME, CHARINDEX('-', PAWAN_SLUG_NAME) + 1, LEN(PAWAN_SLUG_NAME)),
                SUBSTRING(PAWAN_SLUG_NAME, CHARINDEX('-', PAWAN_SLUG_NAME) + 1, 1) + SUBSTRING(PAWAN_SLUG_NAME, CHARINDEX('-', PAWAN_SLUG_NAME) + 1, 1),
                SUBSTRING(PAWAN_SLUG_NAME, CHARINDEX('-', PAWAN_SLUG_NAME) + 1, 1)
            )
    END AS CleanedName
FROM RemoveDuplicateIntsFromNames

--14.20 Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT *
FROM FindSameCharacters
WHERE Vals IS NOT NULL
  AND LEN(Vals) > 1
  AND Vals NOT LIKE '%[^' + LEFT(Vals, 1) + ']%'

--14.21 Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
SELECT 
    Id,
    VALS,
    CASE 
        WHEN PATINDEX('%[0-9]%', VALS) = 1 
        THEN 
            LEFT(VALS, 
                PATINDEX('%[^0-9]%', VALS + 'A') - 1
            )
        ELSE NULL
    END AS StartingInteger
FROM GetIntegers