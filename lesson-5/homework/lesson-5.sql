--1 TASK (EASY)
SELECT ProductName as Name FROM Products

--2 TASK (EASY)
SELECT * FROM Customers AS Client

--3 TASK (EASY)
SELECT ProductID,ProductName,Price FROM Products
UNION
SELECT * FROM Products_discontinued

--4 TASK (EASY)
SELECT ProductID FROM Products
INTERSECT
SELECT ProductID FROM Products_discontinued

--5 TASK (EASY)
SELECT ProductID FROM Products
UNION ALL
SELECT ProductID FROM Orders

--6 TASK (EASY)
SELECT DISTINCT Name as CustomerName, Location FROM Customers

--7 TASK (EASY)
SELECT  ProductID, ProductName, Price,
	CASE
		WHEN Price > 100 THEN 'High'
		ELSE 'Low'
	END AS [Price_category]
FROM Products

--8 TASK (EASY)
--SAVOLNI TOGIRLASH KERAK

--9 TASK (EASY)
SELECT Category, COUNT(ProductID) AS Num_Prod FROM Products
GROUP BY Category

--10 TASK (EASY)
SELECT 
	ProductID,
	ProductName,
	Category,
	Price,
	StockQuantity,
	IIF(StockQuantity > 100, 'Yes', 'No') as Status
FROM Products

--11 TASK (MEDIUM)
SELECT
	c.CustomerID,
	c.Name AS ClientName,
	c.LoyaltyStatus,
	o.Quantity,
	o.TotalAmount
FROM Orders AS o
JOIN Customers AS c ON o.CustomerID = c.CustomerID

--12 TASK (MEDIUM)
--SAVOLNI TOGIRLASH KERAK

--13 TASK (MEDIUM)
SELECT ProductID FROM Products
EXCEPT
SELECT ProductID FROM Products_Discontinued

--14 TASK (MEDIUM)
SELECT 
	OrderID,
	CustomerID,
	ProductID,
	Quantity,
	CASE
		WHEN Quantity >= 5 THEN 'Eligible'
		ELSE 'Not Eligible'
	END AS Status
FROM Orders

--15 TASK (MEDIUM)
SELECT 
	ProductID,
	ProductName,
	Price,
	IIF(Price > 100, 'Expensive', 'Affordable') AS Status
FROM Products

--16 TASK (MEDIUM)
SELECT CustomerID, COUNT(OrderID) AS NumOfOrders FROM Orders
GROUP BY CustomerID

--17 TASK (MEDIUM)
SELECT * FROM Employees
WHERE SALARY > 6000

--18 TASK (MEDIUM)
SELECT CustomerID, SUM(SaleAmount) AS TotalSales FROM Sales
GROUP BY CustomerID

--19 TASK (MEDIUM)
SELECT 
	c.CustomerID,
	c.Name,
	OrderDate AS OrderDate
FROM Customers AS c
LEFT JOIN Orders AS o ON c.CustomerID = o.CustomerID

--20 TASK (MEDIUM)
UPDATE Employees
SET Salary = CASE
                WHEN DepartmentID = 2 THEN Salary * 1.10
                ELSE Salary
             END
WHERE DepartmentID = 2

--1 TASK (HARD)
/* THERE IS NO RETURN TABLE */

--2 TASK (HARD)
SELECT ProductID FROM Products
INTERSECT
SELECT ProductID FROM Products_Discontinued

--3 TASK (HARD)
SELECT 
	CustomerID,
	SUM(SaleAmount) AS TotalSales,
	CASE
		WHEN SUM(SaleAmount)>10000 THEN 'Top Tier'
		WHEN SUM(SaleAmount) BETWEEN 5000 AND 10000 THEN 'Mid Tier'
		ELSE 'Low Tier'
	END AS SalesCategory		
FROM Sales
GROUP BY CustomerID

--4 TASK (HARD)
--DIDN`T UNDERSTAND QUESTION

--5 TASK (HARD)
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM INVOICES

--6 TASK (HARD)
SELECT CustomerID, ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID, ProductID

--7 TASK (HARD) 
SELECT 
	SaleID,
	ProductID,
	CustomerID,
	SaleAmount,
	CASE 
		WHEN SaleAmount >= 500 THEN '20%'
		WHEN SaleAmount BETWEEN 400 AND 499 THEN '15%'
		WHEN SaleAmount BETWEEN 300 AND 399 THEN '10%'
		WHEN SaleAmount BETWEEN 200 AND 299 THEN '5%'
		ELSE 'No Discount'
	END AS Discount
FROM Sales

--8 TASK (HARD) Use UNION and INNER JOIN to return all products that are either in the Products or DiscontinuedProducts table and also show if they are currently in stock.
SELECT p.ProductID, p.ProductName, p.Category, 
       CASE 
           WHEN P.StockQuantity > 0 THEN 'In Stock'
           ELSE 'Out of Stock'
       END AS StockStatus
FROM (
    SELECT ProductID, ProductName, Category, StockQuantity FROM Products
    UNION
    SELECT ProductID, ProductName, NULL AS Category, NULL AS StockQuantity FROM Products_Discontinued
) AS p
JOIN Products pr ON p.ProductID = pr.ProductID;

--9 TASK (HARD) Write a query that uses IIF to create a new column StockStatus, where the status is 'Available' if Stock > 0, and 'Out of Stock' if Stock = 0.
SELECT 
	ProductName,
	Category,
	StockQuantity,
	IIF(StockQuantity > 0, 'Available', 'Out of Stock') AS StockStatus
FROM Products

--10 TASK (HARD) Write a query that uses EXCEPT to find customers in the Customers table who are not in the VIP_Customers table based on CustomerID.
/* THERE IS NO VIP_Customers TABLE */