--16.1 Write an SQL Statement to de-group the following data
WITH DeGroup AS (
	SELECT 
		Product,
		1 AS Quantity
	FROM Grouped
	UNION ALL
	SELECT
		d.Product,
		d.Quantity + 1
	FROM Degroup d
	JOIN Grouped g ON d.Product = g.Product
	WHERE d.Quantity + 1 <= g.Quantity 
)
SELECT Product, 1 AS Quantity FROM DeGroup
ORDER BY Product

--16.2 You must provide a report of all distributors and their sales by region. 
--If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. Assume there is at least one sale for each region
;WITH region_cte AS (
	SELECT DISTINCT Region FROM #RegionSales
),
distributor_cte AS (
	SELECT DISTINCT Distributor FROM #RegionSales
),
combined_cte AS (
	SELECT * FROM region_cte AS r
	CROSS JOIN
	distributor_cte AS d
)
SELECT 
	c.Region,
	c.Distributor,
	COALESCE(rs.SALES,0) AS TotalSales
FROM combined_cte c
LEFT JOIN #RegionSales rs 
ON c.Region = rs.Region AND c.Distributor = rs.Distributor

--16.3 Find managers with at least five direct reports
SELECT
	m.name
FROM Employee e
JOIN Employee m ON e.managerId = m.id
GROUP BY m.name
HAVING COUNT(*) >= 5;

--16.4 Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount
SELECT 
	p.product_name,
	SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE CONCAT(YEAR(o.order_date),'-', MONTH(o.order_date)) = '2020-2'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100
ORDER BY SUM(o.unit) DESC

--16.5 Write an SQL statement that returns the vendor from which each customer has placed the most orders
WITH cte AS (
SELECT 
	CustomerID,
	Vendor,
	COUNT(*) AS order_count
FROM Orders
GROUP BY CustomerID, Vendor
),
rank_vendor AS (
	SELECT 
		CustomerID,
		Vendor,
		order_count,
		ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY order_count DESC) AS rank
	FROM cte
)
SELECT 
	CustomerID,
	Vendor
FROM rank_vendor
WHERE rank = 1

--16.6  You will be given a number as a variable called @Check_Prime check, 
--if this number is prime then return 'This number is prime' else return 'This number is not prime'
DECLARE @Check_Prime INT = 17;

DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;

IF @Check_Prime < 2
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

--16.7 Write an SQL query to return the number of locations,in which location most signals sent, 
--and total number of signal for each device from the given table.
WITH most_signal_cte AS(
	SELECT TOP 1 WITH TIES
		Device_id, 
		Locations
	FROM Device
	GROUP BY Device_id, Locations
	ORDER BY ROW_NUMBER() OVER(PARTITION BY Device_id ORDER BY COUNT(*) DESC)
)
SELECT 
	m.Device_id,
	COUNT(DISTINCT d.Locations) AS no_of_location,
	m.Locations AS max_signal_location,
	COUNT(d.Locations) AS no_of_signals
FROM most_signal_cte m
JOIN Device d ON m.Device_id = d.Device_id
GROUP BY m.Device_id,m.Locations

--16.8 Write a SQL to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output
;WITH dept_cte AS (
	SELECT
		DeptID,
		AVG(Salary) AS avg_sal
	FROM Employee
	GROUP BY DeptID
)
SELECT
	e.EmpID,
	e.EmpName,
	e.Salary
FROM dept_cte d
JOIN Employee e ON d.DeptID = e.DeptID
WHERE e.Salary > d.avg_sal
ORDER BY EmpID

--16.9 You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. 
--If a ticket has some but not all the winning numbers,you win $10. 
--If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
;WITH TicketMatch_cte AS (
	SELECT
		TicketID,
		COUNT(DISTINCT CASE WHEN w.Number IS NOT NULL THEN t.Number END) AS MatchCount
	FROM Tickets t
	LEFT JOIN WinningNumbers w
	ON t.Number = w.Number
	GROUP BY TicketID
)
SELECT  
	SUM(
		CASE
			WHEN MatchCount = 3 THEN 100
			WHEN MatchCount > 0 THEN 10
			ELSE 0
		END
	) AS TotalWinning
FROM TicketMatch_cte

--16.10 Write an SQL query to find the total number of users and the total amount spent using mobile only, 
--desktop only and both mobile and desktop together for each date.
;WITH user_cte AS (	
	SELECT 
		User_id,
		Spend_date,
		MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS Mob,
		MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS Desk,
		SUM(Amount) AS TotalAmount
	FROM Spending
	GROUP BY User_id, Spend_date
),
classify_cte AS (
	SELECT 
		User_id,
		Spend_date,
		TotalAmount,
		CASE
			WHEN Mob = 1 AND Desk = 1 THEN 'Both'
			WHEN Mob = 1 AND Desk = 0 THEN 'Mobile'
			WHEN Mob = 0 AND Desk = 1 THEN 'Desktop'
		END AS platform
	FROM user_cte
)
SELECT 
    Spend_date,
    platform,
    COALESCE(SUM(TotalAmount), 0) AS Total_Amount,
    COUNT(User_id) AS Total_users
FROM classify_cte
GROUP BY Spend_date, platform
ORDER BY Spend_date, 
    CASE 
        WHEN Platform = 'Mobile' THEN 1
        WHEN Platform = 'Desktop' THEN 2
        WHEN Platform = 'Both' THEN 3
    END;