--15.1 Create a numbers table using a recursive query.
WITH rec_cte AS (
	SELECT 1 AS num
	UNION ALL
	SELECT num+1
	FROM rec_cte
	WHERE num<100
)
SELECT * FROM rec_cte

--15.2 Beginning at 1, this script uses a recursive statement to double the number for each record
WITH rec_cte AS (
	SELECT 1 AS num
	UNION ALL
	SELECT num*2
	FROM rec_cte
	WHERE num<100
)
SELECT * FROM rec_cte

--15.3 Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT 
	e.EmployeeID,
	e.FirstName AS Name,
	s.total_sales
FROM Employees e
JOIN (SELECT 
	EmployeeID,
	SUM(SalesAmount) AS total_sales
	FROM Sales
	GROUP BY EmployeeID) AS s
ON e.EmployeeID = s.EmployeeID

--15.4 Create a CTE to find the average salary of employees.(Employees)
WITH cte AS (
	SELECT AVG(Salary) AS avg_sal FROM Employees
)
SELECT avg_sal FROM cte

--15.5 Write a query using a derived table to find the highest sales for each product.(Sales, Products)
SELECT 
	p.ProductID,
	p.ProductName,
	s.highest_sal
FROM Products p
JOIN (SELECT ProductID,MAX(SalesAmount) AS highest_sal FROM Sales GROUP BY ProductID) AS s
ON p.ProductID = s.ProductID

--15.6 Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
WITH sale_cte AS (
	SELECT 
		s.EmployeeID,
		COUNT(*) AS sale_count
	FROM Sales s
	GROUP BY s.EmployeeID
)
SELECT
	e.FirstName AS Name
FROM Employees e
JOIN sale_cte AS sc
ON e.EmployeeID = sc.EmployeeID
WHERE sc.sale_count > 5

--15.7 Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
WITH sales_cte AS (
	SELECT
		ProductID,
		SalesAmount
	FROM Sales
)
SELECT p.ProductID, p.ProductName, sc.SalesAmount FROM Products p
JOIN sales_cte sc ON p.ProductID = sc.ProductID
WHERE sc.SalesAmount > 500

--15.8 Create a CTE to find employees with salaries above the average salary.(Employees)
WITH cte AS (
	SELECT AVG(Salary) AS avg_sal FROM Employees
) 
SELECT 
	e.EmployeeID,
	e.FirstName,
	e.Salary
FROM Employees e
JOIN cte AS a
ON e.Salary > a.avg_sal

--15.9 Write a query to find the total number of products sold using a derived table.(Sales, Products)
SELECT 
	s.total_num_prod
FROM 
	(SELECT 
	COUNT(*) AS total_num_prod
	FROM Sales) AS s

--15.10 Use a CTE to find the names of employees who have not made any sales.(Sales, Employees)
WITH sales_cte AS (
	SELECT DISTINCT EmployeeID 
	FROM Sales
)
SELECT 
	e.FirstName
FROM Employees e
LEFT JOIN sales_cte AS sc 
ON e.EmployeeID = sc.EmployeeID
WHERE sc.EmployeeID IS NULL

--15.11 This script uses recursion to calculate factorials
DECLARE @NUM INT = 5;

WITH fac_cte AS (
	SELECT 1 AS n,
	1 AS factorial
	UNION ALL
	SELECT n + 1,
	(n + 1)*factorial
	FROM fac_cte
	WHERE n<@NUM
)
SELECT * FROM fac_cte

--15.12 This script uses recursion to calculate Fibonacci numbers
DECLARE @NUM INT = 10;

WITH fib_cte AS (
	SELECT 1 AS n,
	0 AS fib_num,
	1 AS next_fib_num
	UNION ALL
	SELECT n + 1,
	next_fib_num,
	fib_num + next_fib_num
	FROM fib_cte
	WHERE n<@NUM
)
SELECT 
 n,
 next_fib_num AS fib_number
FROM fib_cte

--15.13 This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
WITH RecursiveSplit AS (
    SELECT
        Id,
        1 AS Position,
        SUBSTRING(String, 1, 1) AS Character,
        String
    FROM Example
    WHERE LEN(String) >= 1

    UNION ALL

    SELECT
        Id,
        Position + 1,
        SUBSTRING(String, Position + 1, 1),
        String
    FROM RecursiveSplit
    WHERE Position + 1 <= LEN(String)
)
SELECT Id, Character
FROM RecursiveSplit
ORDER BY Id

--15.14 Create a CTE to rank employees based on their total sales.(Employees, Sales)
WITH cte AS (
	SELECT 
		EmployeeID,
		SUM(SalesAmount) AS total_sales
	FROM Sales
	GROUP BY EmployeeID
)
SELECT 
	e.EmployeeID,
	e.FirstName,
	c.total_sales,
	RANK() OVER(ORDER BY total_sales DESC) AS rank
FROM Employees e
JOIN cte AS c 
ON e.EmployeeID = c.EmployeeID

--15.15 Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
WITH cte AS (
	SELECT 
		EmployeeID,
		COUNT(*) AS num_ord
	FROM Sales
	GROUP BY EmployeeID
)
SELECT TOP 5
	e.EmployeeID,
	e.FirstName,
	c.num_ord
FROM Employees e
JOIN cte AS c 
ON e.EmployeeID = c.EmployeeID
ORDER BY c.num_ord DESC

--15.16 Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
WITH month_cte AS (
	SELECT 
		FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
		SUM(SalesAmount) AS TotalSales
	FROM Sales
	GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
prev_month_cte AS (
	SELECT 
		*,
		LAG(TotalSales) OVER(ORDER BY SaleMonth) AS PrevMonthSales
	FROM month_cte
)
SELECT *, 
	TotalSales - ISNULL(PrevMonthSales,0) AS SalesDiff
FROM prev_month_cte

--15.17 Write a query using a derived table to find the sales per product category.(Sales, Products)
SELECT 
	p.CategoryID,
	SUM(s.SalesAmount) AS total_sales
FROM (
	SELECT 
		ProductID,
		SalesAmount
	FROM Sales
) AS s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.CategoryID

--15.18 Use a CTE to rank products based on total sales in the last year.(Sales, Products)
;WITH prod_sales_cte AS (
	SELECT
		p.ProductID,
		p.ProductName,
		SUM(SalesAmount) AS total_sales
	FROM Sales s
	JOIN Products p ON s.ProductID = p.ProductID
	WHERE YEAR(s.SaleDate) = YEAR(GETDATE()) - 1 
	GROUP BY p.ProductID, p.ProductName
	),
	rank_cte AS (
	SELECT *,
		RANK() OVER(ORDER BY total_sales DESC) AS SalesRank
	FROM prod_sales_cte
	)
SELECT * FROM rank_cte

--15.19 Create a derived table to find employees with sales over $5000 in each quarter.(Sales, Employees)
SELECT 
	e.EmployeeID,
	e.FirstName,
	s.Quarter,
	s.total_sales
FROM (
	SELECT
		EmployeeID,
		CONCAT('Q', DATEPART(QUARTER, SaleDate)) AS Quarter,
		SUM(SalesAmount) AS total_sales
	FROM Sales
	GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) AS s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
WHERE s.total_sales > 5000

--15.20 Use a derived table to find the top 3 employees by total sales amount in the last month.(Sales, Employees)
SELECT TOP 3
	e.EmployeeID,
	e.FirstName,
	s.total_sales
FROM (
	SELECT
		EmployeeID,
		SUM(SalesAmount) AS total_sales
	FROM Sales
	WHERE MONTH(SaleDate) = MONTH(GETDATE()) - 1
		AND YEAR(SaleDate) = YEAR(GETDATE())
	GROUP BY EmployeeID
) AS s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
ORDER BY s.total_sales DESC

--15.21 Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
DECLARE @NUM INT = 5;
WITH num_cte AS (    
	SELECT 
        1 AS CurrentNum,
        CAST('1' AS VARCHAR(MAX)) AS SequenceStr
	UNION ALL
	SELECT 
		CurrentNum + 1,
		SequenceStr + CAST(CurrentNum + 1 AS VARCHAR(MAX))
	FROM num_cte
	WHERE CurrentNum + 1 <= @NUM
)
SELECT SequenceStr AS Number
FROM num_cte

--15.22 Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT
	e.EmployeeID,
	e.FirstName,
	s.TotalSales
FROM (
	SELECT
		EmployeeID,
		SUM(SalesAmount) AS TotalSales
	FROM Sales 
	WHERE SaleDate >= DATEADD(MONTH,-6,GETDATE())
	GROUP BY EmployeeID
) AS s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
ORDER BY s.TotalSales DESC

--15.23 This script uses recursion to display a running total where the sum cannot go higher than 10 or lower than 0.(Numbers)
WITH cte AS(
	SELECT *, SUM(Count) OVER (PARTITION BY ID ORDER BY STEPNUMBER) AS cum_sales FROM Numbers
	)
SELECT 
	Id,
	StepNumber,
	CASE WHEN cum_sales < 0 THEN 0
		WHEN cum_sales > 10 THEN 10
		ELSE cum_sales
	END run_total
FROM cte

--15.24 Given a table of employee shifts, and another table of their activities, merge the two tables and write an SQL statement that produces the desired output. If an employee is scheduled and does not have an activity planned, label the time frame as “Work”. (Schedule,Activity)
;WITH event_cte AS (
	SELECT
		ScheduleID,
		StartTime,
		EndTime,
		'Work' AS ActivityName
	FROM Schedule

	UNION ALL

	SELECT 
		ScheduleID,
		StartTime,
		EndTime,
		ActivityName
	FROM Activity
)
SELECT * FROM event_cte
ORDER BY ScheduleID, StartTime

--15.25 Create a complex query that uses both a CTE and a derived table to calculate sales totals for each department and product.(Employees, Sales, Products, Departments)
;WITH cte AS (
	SELECT
		s.EmployeeID,
		s.ProductID,
		SUM(s.SalesAmount) AS TotalSales
	FROM Sales s
	GROUP BY s.EmployeeID, s.ProductID
)
SELECT 
	d.DepartmentName,
	p.ProductName,
	SUM(emps.TotalSales) AS total_sales
FROM (
	SELECT 
		c.EmployeeID,
		c.ProductID,
		c.TotalSales,
		e.DepartmentID
	FROM cte AS c
	JOIN Employees e ON c.EmployeeID = e.EmployeeID
	) AS emps
JOIN Departments d ON emps.DepartmentID = d.DepartmentID
JOIN Products p ON emps.ProductID = p.ProductID
GROUP BY d.DepartmentName, p.ProductName

