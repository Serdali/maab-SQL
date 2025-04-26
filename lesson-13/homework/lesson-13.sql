--13.1 You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
SELECT 
	CONCAT(EMPLOYEE_ID,'-',FIRST_NAME, ' ', LAST_NAME) AS emp_info
FROM Employees

--13.2 Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
UPDATE Employees 
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER,'124','999')
SELECT PHONE_NUMBER FROM Employees

--13.3 That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees)
SELECT
	FIRST_NAME AS 'first name',
	LEN(FIRST_NAME) as name_length
FROM Employees
WHERE FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME

--13.4 Write an SQL query to find the total salary for each manager ID.(Employees table)
SELECT 
	MANAGER_ID,
	SUM(SALARY) AS total_salary
FROM Employees
GROUP BY MANAGER_ID

--13.5 Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table
SELECT Year1,
       GREATEST(Max1, Max2, Max3) AS highest_value
FROM TestMax

--13.6 Find me odd numbered movies description is not boring.(cinema)
SELECT * 
FROM cinema
WHERE id % 2 = 1 AND description NOT LIKE '%boring%'

--13.7 You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)
SELECT * 
FROM SingleOrder
ORDER BY IIF(Id=0,1,0), Id

--13.8 Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)
SELECT COALESCE(ssn, passportid,itin) AS first_non_null FROM person

--13.9 Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service 
--(calculated as the number of years between the current date and the hire date, rounded to two decimal places).(Employees)
SELECT 
	EMPLOYEE_ID,
	FIRST_NAME,
	LAST_NAME,
	HIRE_DATE,
	ROUND(DATEDIFF(DAY,HIRE_DATE,GETDATE())/365.0,2) AS years_of_service
FROM Employees
WHERE
	DATEDIFF(YEAR,HIRE_DATE,GETDATE()) > 10
	AND DATEDIFF(YEAR,HIRE_DATE,GETDATE()) < 15

--13.10 Find the employees who have a salary greater than the average salary of their respective department.(Employees)
SELECT 
	e.EMPLOYEE_ID,
	e.FIRST_NAME,
	e.LAST_NAME,
	e.SALARY,
	e.DEPARTMENT_ID
FROM Employees e
JOIN(
	SELECT 
		DEPARTMENT_ID,
		AVG(SALARY) AS avg_salary
	FROM Employees 
	GROUP BY DEPARTMENT_ID
	) AS dept_sal ON e.DEPARTMENT_ID = dept_sal.DEPARTMENT_ID
WHERE e.SALARY > dept_sal.avg_salary

--13.11 Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.
SELECT
    STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch ELSE NULL END, '') AS UppercaseLetters,
    STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch ELSE NULL END, '') AS LowercaseLetters,
    STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch ELSE NULL END, '') AS Digits,
    STRING_AGG(CASE WHEN ch NOT LIKE '[A-Za-z0-9]' THEN ch ELSE NULL END, '') AS OtherCharacters
FROM (
    SELECT 
        SUBSTRING('tf56sd#%OqH', v.number, 1) AS ch
    FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11)) v(number)
) AS chars;

--13.12 split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
SELECT 
	FullName,
	PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS Firstname,
	PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS Middlename,
	PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS Lastname
FROM Students

--13.13 For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)
SELECT * 
FROM Orders
WHERE DeliveryState = 'TX' 
	AND CustomerID IN (
		SELECT DISTINCT CustomerID
		FROM Orders
		WHERE DeliveryState = 'CA'
)

--13.14 Write an SQL query to transform a table where each product has a total quantity into a new table where each row represents a single unit of that product.
--For example, if A and B, it should be A,B and B,A.(Ungroup)

--13.15 Write an SQL statement that can group concatenate the following values.(DMLTable)
SELECT 
	STRING_AGG(String, ' ')
FROM DMLTable

--13.16 Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
SELECT
	EMPLOYEE_ID,
	FIRST_NAME,
	LAST_NAME,
	HIRE_DATE,
	DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsWorked,
	CASE
		WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
		WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 4 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 9 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 19 THEN 'Senior'
		ELSE 'Veteran'
	END AS EmpStage
FROM Employees

--13.17 Find the employees who have a salary greater than the average salary of their respective department(Employees)
SELECT 
	e.EMPLOYEE_ID,
	e.FIRST_NAME,
	e.LAST_NAME,
	e.SALARY,
	e.DEPARTMENT_ID
FROM Employees e
WHERE e.SALARY > (
	SELECT AVG(SALARY)
	FROM Employees
	WHERE e.DEPARTMENT_ID = DEPARTMENT_ID)

--13.18 Find all employees whose names (concatenated first and last) contain the letter "a" and whose salary is divisible by 5(Employees)
SELECT
	EMPLOYEE_ID,
	CONCAT_WS(' ',FIRST_NAME, LAST_NAME) AS concat_name,
	SALARY
FROM Employees
WHERE CONCAT_WS(' ',FIRST_NAME, LAST_NAME) LIKE '%a%'
	  AND CAST(SALARY AS INT) % 5 = 0

--13.19 The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)
SELECT
	DEPARTMENT_ID,
	COUNT(*) AS total_emp,
	ROUND(100 * SUM(CASE
						WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1
						ELSE 0
						END)/COUNT(*),2)AS PercentageOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID

--13.20 Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)
SELECT 
	JobDescription,
	MAX(MissionCount) AS most,
	MIN(MissionCount) AS least
FROM Personal
WHERE JobDescription IN (SELECT DISTINCT JobDescription FROM Personal)
GROUP BY JobDescription

--13.21 Write an SQL query that replaces each row with the sum of its value and the previous row's value. (Students table)
SELECT
	s1.FullName,
	s1.Grade,
	s1.Grade + ISNULL(s2.Grade, 0) AS GradeWithPrevious
FROM Students s1
LEFT JOIN Students s2 
ON s2.StudentID = s1.StudentID-1

--13.22 Given the following hierarchical table, write an SQL statement that determines the level of depth each employee has from the president. (Employee table)
WITH cte_emp AS
(
SELECT  EmployeeID, ManagerID, JobTitle, 0 AS Depth
FROM    Employee a
WHERE   ManagerID IS NULL
UNION ALL
SELECT  b.EmployeeID, b.ManagerID, b.JobTitle, a.Depth + 1 AS Depth
FROM    cte_emp a INNER JOIN 
        Employee b ON a.EmployeeID = b.ManagerID
)
SELECT  EmployeeID,
        ManagerID,
        JobTitle,
        Depth
FROM    cte_emp;

--13.23 You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)
SELECT * FROM Equations

--13.24 Given the following dataset, find the students that share the same birthday.(Student Table)
SELECT Birthday,
	STRING_AGG(StudentName, ', ') AS Students
FROM Student
GROUP BY Birthday
HAVING COUNT(*) > 1

--13.25 You have a table with two players (Player A and Player B) and their scores. 
--If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. 
--Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
SELECT
	PlayerA,
	PlayerB,
	SUM(Score) AS Score
FROM (SELECT
			(CASE WHEN PlayerA <= PlayerB THEN PlayerA ELSE PlayerB END) PlayerA,
			(CASE WHEN PlayerB <= PlayerA THEN PlayerB ELSE PlayerA END) PlayerB,
			Score
	  FROM PlayerScores
) AS A
GROUP BY PlayerA, PlayerB