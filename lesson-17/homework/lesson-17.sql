--17.1 Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
CREATE TABLE #MonthSales (ProductID INT, TotalQuantity INT, TotalRevenue DECIMAL(10,2))

INSERT INTO #MonthSales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
	p.ProductID,
	SUM(s.Quantity) AS TotalQuantity,
	SUM(s.Quantity*p.Price) AS TotalRevenue
FROM 
	Sales s
JOIN 
	Products p
ON 
	s.ProductID = p.ProductID
WHERE
	s.SaleDate >= '2025-04-01' AND s.SaleDate <= '2025-04-30'
GROUP BY 
	p.ProductID

SELECT * FROM #MonthSales

--17.2 Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
CREATE VIEW vw_ProductSalesSummary
AS
SELECT
	p.ProductID,
	p.ProductName,
	p.Category,
	SUM(s.Quantity) AS TotalQuantitySold
FROM 
	Sales s
JOIN 
	Products p
ON 
	s.ProductID = p.ProductID
GROUP BY 
	p.ProductID,
	p.ProductName,
	p.Category

SELECT * FROM vw_ProductSalesSummary

--17.3 Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
	RETURN ISNULL(
		(SELECT SUM(s.Quantity*p.Price)
		FROM Sales s
		JOIN Products p ON s.ProductID = p.ProductID
		WHERE p.ProductID = @ProductID),
		0.00)
END

SELECT dbo.fn_GetTotalRevenueForProduct(3) AS TotalRevenue

--17.4 Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.
CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
	SELECT 
		p.ProductName,
		SUM(s.Quantity) AS TotalQuantity,
		SUM(s.Quantity*p.Price) AS TotalRevenue
	FROM 
		Sales s
	JOIN 
		Products p
	ON 
		s.ProductID = p.ProductID
	WHERE
		p.Category = @Category
	GROUP BY 
		p.ProductName
)

SELECT * FROM dbo.fn_GetSalesByCategory('Toys')

--17.5 You have to create a function that get one argument as input from user 
--and the function should return 'Yes' if the input number is a prime number and 'No' otherwise.
Create function dbo.fn_IsPrime (@Number INT)
RETURNS CHAR(3)
AS
BEGIN
	DECLARE @Result CHAR(3) = 'No';

	IF @Number <= 1
		RETURN @Result;

	IF @Number = 2 OR @Number = 3
		RETURN 'YES';

	IF @Number % 2 = 0 OR @Number % 3 = 0
		RETURN @Result;
	
	DECLARE @Divisor INT = 5;
    DECLARE @Step INT = 2;
    DECLARE @SqrtNumber INT = FLOOR(SQRT(@Number));

	WHILE @Divisor <= @SqrtNumber
	BEGIN
		IF @Number % @Divisor = 0
			RETURN @Result;

		SET @Divisor = @Divisor + @Step;
        SET @Step = 6 - @Step;
    END
    
    SET @Result = 'Yes';
    RETURN @Result;  
END

SELECT dbo.fn_IsPrime(99) AS isPrime

--17.6 Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input
CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS TABLE
AS
RETURN
(
	WITH sequence_cte AS (
		SELECT @Start AS Number
		UNION ALL
		SELECT Number + 1
		FROM sequence_cte
		WHERE Number < @End
	)
	SELECT Number FROM sequence_cte
)

SELECT * FROM dbo.fn_GetNumbersBetween(10, 15)

--17.7 Write a SQL query to return the Nth highest distinct salary from the Employee table. If there are fewer than N distinct salaries, return NULL.
CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
	RETURN (
        SELECT MAX(salary) AS HighestNSalary
        FROM (
            SELECT 
                salary,
                DENSE_RANK() OVER (ORDER BY salary DESC) as salary_rank
            FROM Employee
            GROUP BY salary  
        ) ranked_salaries
        WHERE salary_rank = @N
    );
END

--17.8 Write a SQL query to find the person who has the most friends.
;WITH all_friend_cte AS (
	SELECT requester_id AS id FROM FriendRequest
	UNION ALL
	SELECT accepter_id AS id FROM FriendRequest
),
friend_count AS (
	SELECT 
		id,
		COUNT(*) AS num
	FROM all_friend_cte
	GROUP BY id
)
SELECT 
	id,
	num
FROM friend_count
WHERE num = (SELECT MAX(num) FROM friend_count)

--17.9 Create a view called vw_CustomerOrderSummary that returns a summary of customer orders.
CREATE VIEW vw_CustomerOrderSummary 
AS
SELECT
	c.customer_id,
	c.name,
	COUNT(o.order_id) AS total_orders,
	SUM(o.amount) AS total_amount,
	MAX(o.order_date) AS last_order_date
FROM 
	Customers1 c
LEFT JOIN
	Orders1 o
ON
	c.customer_id = o.customer_id
GROUP BY
	c.customer_id,
	c.name

SELECT * FROM vw_CustomerOrderSummary

--17.10 Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table.
SELECT 
    RowNumber,
    MAX(TESTCASE) OVER (
        PARTITION BY grp
    ) AS Testcase
FROM (
    SELECT 
        RowNumber,
        TESTCASE,
        COUNT(TESTCASE) OVER (
            ORDER BY RowNumber
        ) AS grp
    FROM Gaps
) t
ORDER BY RowNumber;