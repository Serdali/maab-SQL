--5.1 Write a query that uses an alias to rename the ProductName column as Name in the Products table.
SELECT ProductName as Name FROM Products

--5.2 Write a query that uses an alias to rename the Customers table as Client for easier reference.
SELECT * FROM Customers AS Client

--5.3 Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted

--5.4 Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
SELECT ProductID FROM Products
INTERSECT
SELECT ProductID FROM Products_Discounted

--5.5 Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.
SELECT DISTINCT FirstName as CustomerName, Country FROM Customers

--5.6 Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
SELECT  ProductID, ProductName, Price,
	CASE
		WHEN Price > 100 THEN 'High'
		ELSE 'Low'
	END AS Price_category
FROM Products

--5.7 Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
SELECT 
	ProductID,
	StockQuantity,
	IIF(StockQuantity > 100, 'Yes','No') AS HighStock
FROM Products_Discounted

--5.8 Use UNION to combine results from two queries that select ProductName from Products and ProductName from OutOfStock tables.
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM OutOfStock

--5.9 Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
SELECT ProductName  FROM Products
EXCEPT
SELECT ProductName  FROM Products_Discounted

--5.10 Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
SELECT 
	ProductID,
	ProductName,
	Price,
	IIF(Price > 1000, 'Expensive', 'Affordable') AS Status
FROM Products

--5.11 Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
SELECT 
	EmployeeID,
	FirstName,
	LastName,
	Salary, 
	Age
FROM Employees
WHERE Age<25 OR Salary > 60000

--5.12 Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5
UPDATE Employees
SET Salary = 
	CASE
		WHEN EmployeeID = 5 OR DepartmentName = 'HR' THEN Salary * 1.10
		ELSE Salary
	END
WHERE DepartmentName = 'HR' OR EmployeeID = 5

--5.13 Use INTERSECT to show products that are common between Products and Products_Discounted tables.
SELECT ProductID FROM Products
INTERSECT
SELECT ProductID FROM Products_Discounted

--5.14 Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
SELECT 
	*,
	CASE
		WHEN SaleAmount > 500 THEN 'Top Tier'
		WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
		ELSE 'Low Tier'
	END AS SalesCategory		
FROM Sales

--5.15 Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Invoices table.
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Invoices

--5.16 Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%
SELECT 
	CustomerID,
	Quantity,
	CASE 
		WHEN Quantity = 1 THEN '3%'
		WHEN Quantity BETWEEN 1 AND 3 THEN '5%'
		ELSE '7%'
	END AS Discount_percentage
FROM Orders