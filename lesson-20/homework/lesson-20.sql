--20.1 Find customers who purchased at least one item in March 2024 using EXISTS
SELECT
	CustomerName
FROM #Sales s1
WHERE 
	EXISTS (SELECT * FROM #Sales s2 
			WHERE s1.CustomerName = s2.CustomerName 
			AND YEAR(s2.SaleDate)=2024 AND MONTH(s2.SaleDate)=3)

--20.2 Find the product with the highest total sales revenue using a subquery.
SELECT TOP 1
	Product,
	TotalSales AS HighestTotalSales
FROM (SELECT Product, SUM(Price*Quantity) AS TotalSales FROM #Sales GROUP BY Product) AS a
ORDER BY TotalSales DESC

--20.3 Find the second highest sale amount using a subquery
SELECT PRODUCT, TotalRevenue AS SecondHighestSale
FROM (
	SELECT 
		Product,
		SUM(Quantity * Price) AS TotalRevenue,
		DENSE_RANK() OVER(ORDER BY SUM(Quantity * Price) DESC) AS RevRank
	FROM #Sales
	GROUP BY Product
) AS rp
WHERE RevRank = 2

--20.4 Find the total quantity of products sold per month using a subquery
SELECT
	MONTH(SaleDate) AS month,
	(SELECT
		SUM(Quantity)
	FROM #Sales s2
	WHERE MONTH(s2.SaleDate) = MONTH(s1.SaleDate)
	) AS TotalQuantity
FROM #SALES s1
GROUP BY MONTH(SaleDate)

--20.5 Find customers who bought same products as another customer using EXISTS
SELECT
	DISTINCT CustomerName,
	Product
FROM #Sales s1
WHERE EXISTS (SELECT 1 
			  FROM #Sales s2
			  WHERE s1.CustomerName<>s2.CustomerName
			  AND s1.Product = s2.Product)
ORDER BY Product

--20.6 Return how many fruits does each person have in individual fruit level
SELECT
	Name,
	SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS 'Apple',
	SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS 'Orange',
	SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS 'Banana'
FROM 
	Fruits
GROUP BY
	Name

--20.7 Return older people in the family with younger ones
;WITH cte AS (
SELECT ParentId AS PID, ChildID AS CHID FROM Family
UNION ALL
SELECT c.PID, f.ChildID 
FROM cte c
JOIN Family f ON c.CHID = f.ParentId
)
SELECT 
	DISTINCT PID, CHID
FROM CTE

--20.8 For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas
SELECT
	CustomerID,
	DeliveryState,
	Amount
FROM #ORDERS
WHERE DeliveryState = 'TX'
	and CustomerID in (SELECT DISTINCT CustomerID FROM #ORDERS WHERE DeliveryState = 'CA')

--20.9 Insert the names of residents if they are missing


--20.10 Write a query to return the route to reach from Tashkent to Khorezm. The result should include the cheapest and the most expensive routes
-- Build all valid paths from Tashkent to Khorezm
;WITH PossibleRoutes AS (
    SELECT 
        r1.DepartureCity + ' - ' + r1.ArrivalCity + ' - ' + r2.ArrivalCity AS Route,
        r1.Cost + r2.Cost AS Cost
    FROM #Routes r1
    JOIN #Routes r2 ON r1.ArrivalCity = r2.DepartureCity
    WHERE r1.DepartureCity = 'Tashkent' AND r2.ArrivalCity = 'Khorezm'

    UNION ALL

    SELECT 
        r1.DepartureCity + ' - ' + r2.ArrivalCity + ' - ' + r3.ArrivalCity + ' - ' + r4.ArrivalCity AS Route,
        r1.Cost + r2.Cost + r3.Cost + r4.Cost AS Cost
    FROM #Routes r1
    JOIN #Routes r2 ON r1.ArrivalCity = r2.DepartureCity
    JOIN #Routes r3 ON r2.ArrivalCity = r3.DepartureCity
    JOIN #Routes r4 ON r3.ArrivalCity = r4.DepartureCity
    WHERE r1.DepartureCity = 'Tashkent' AND r4.ArrivalCity = 'Khorezm'
)

SELECT *
FROM PossibleRoutes
WHERE Cost = (SELECT MIN(Cost) FROM PossibleRoutes)
   OR Cost = (SELECT MAX(Cost) FROM PossibleRoutes)

--20.11 Rank products based on their order of insertion.
WITH cte AS (
SELECT ID, VALS,
	SUM(CASE WHEN Vals='Product' THEN 1 ELSE 0 END) OVER (ORDER BY ID) AS ProductGroup
FROM #RankingPuzzle
)
SELECT ID, VALS,
	DENSE_RANK() OVER(ORDER BY ProductGroup) AS ProductRank
FROM cte

--20.12 You have to return Ids, what number of the letter would be next if inserted, the maximum length of the consecutive occurence of the same digit
WITH NumberedRows AS (
    SELECT 
        Id,
        Vals,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY (SELECT NULL)) AS RowNum
    FROM #Consecutives
),
ConsecutiveGroups AS (
    SELECT 
        Id,
        Vals,
        RowNum,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY RowNum) - 
        ROW_NUMBER() OVER (PARTITION BY Id, Vals ORDER BY RowNum) AS Grp
    FROM NumberedRows
),
ConsecutiveCounts AS (
    SELECT 
        Id,
        Vals,
        COUNT(*) AS ConsecutiveLength
    FROM ConsecutiveGroups
    GROUP BY Id, Vals, Grp
)
SELECT 
    c.Id,
    CASE 
        WHEN MAX(n.RowNum) % 2 = 0 THEN 1 - MAX(c.Vals)
        ELSE MAX(c.Vals)
    END AS NextNumber,
    MAX(cc.ConsecutiveLength) AS MaxConsecutiveLength
FROM #Consecutives c
JOIN NumberedRows n ON c.Id = n.Id AND c.Vals = n.Vals
JOIN ConsecutiveCounts cc ON c.Id = cc.Id AND c.Vals = cc.Vals
GROUP BY c.Id;

--20.13 Find employees whose sales were higher than the average sales in their department
;WITH cte AS(
SELECT
	EmployeeName,
	Department,
	SalesAmount,
	AVG(SalesAmount) OVER(PARTITION BY Department) AS avg_sales
FROM #EMPLOYEESALES
)
SELECT * FROM cte
WHERE SalesAmount > avg_sales
ORDER BY Department

--20.14 Find employees who had the highest sales in any given month using EXISTS
SELECT 
	EmployeeName,
	SalesAmount,
	SalesMonth
FROM #EmployeeSales e1
WHERE EXISTS (
	SELECT 1 
	FROM #EmployeeSales e2 
	WHERE SalesMonth = e2.SalesMonth
	GROUP BY e2.SalesMonth
	HAVING e1.SalesAmount = MAX(e2.SalesAmount)
	)

--20.15 Find employees who made sales in every month using NOT EXISTS
SELECT DISTINCT e1.EmployeeName 
FROM #EmployeeSales e1
WHERE NOT EXISTS (
	SELECT m.SalesMonth
	FROM (SELECT DISTINCT SalesMonth FROM #EmployeeSales) m
	WHERE NOT EXISTS(
		SELECT 1
		FROM #EmployeeSales e2
		WHERE e1.EmployeeName = e2.EmployeeName
		AND m.SalesMonth = e2.SalesMonth
	)
)

--20.16 Retrieve the names of products that are more expensive than the average price of all products.
SELECT Name FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)

--20.17 Find the products that have a stock count lower than the highest stock count.
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products)

--20.18 Get the names of products that belong to the same category as 'Laptop'.
SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop')

--20.19 Retrieve products whose price is greater than the lowest price in the Electronics category.
SELECT *
FROM Products
WHERE Price > (SELECT MIN(Price) FROM Products WHERE Category = 'Electronics')

--20.20 Find the products that have a higher price than the average price of their respective category.
SELECT *
FROM Products p1
WHERE Price > (SELECT AVG(Price) FROM Products p2 WHERE p1.Category = p2.Category)

--20.21 Find the products that have been ordered at least once.
SELECT DISTINCT p.ProductID, p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID

--20.22	Retrieve the names of products that have been ordered more than the average quantity ordered.
SELECT
	p.ProductID,
	p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders)

--20.23 Find the products that have never been ordered.
SELECT p.ProductID, p.Name FROM Products p
LEFT JOIN Orders o
ON o.ProductID = p.ProductID
WHERE o.OrderID IS NULL

--20.24 Retrieve the product with the highest total quantity ordered.
SELECT TOP 1 p.ProductID, p.Name, SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalQuantity DESC

--20.25 Find the products that have been ordered more times than the average number of orders placed.
SELECT p.ProductID, p.Name, COUNT(o.OrderID) AS OrderCount
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name
HAVING COUNT(o.OrderID) > (
    SELECT AVG(OrderCount) FROM (
        SELECT COUNT(*) AS OrderCount
        FROM Orders
        GROUP BY ProductID
    ) AS ProductOrderCounts
)
