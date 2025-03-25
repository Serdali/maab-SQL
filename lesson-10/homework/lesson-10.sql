--1 TASK (EASY) Write a query to perform an INNER JOIN between Orders and Customers using AND in the ON clause to filter orders placed after 2022.
SELECT 
	o.OrderID,
	o.OrderDate,
	c.CustomerID
FROM [hwlesson_9].[dbo].Orders o
INNER JOIN [hwlesson_9].[dbo].Customers c
ON o.CustomerID = c.CustomerID
AND YEAR(o.OrderDate) > 2022

--2 TASK (EASY) Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department.
SELECT 
	e.EmployeeID,
	e.Name,
	d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND(d.DepartmentName = 'Sales' OR d.DepartmentName = 'Marketing')

--3 TASK (EASY) Write a query to demonstrate a CROSS APPLY between Departments and a derived table that shows their Employees, top-performing employee (e.g., top 1 Employee who gets the most salary).
SELECT * FROM Departments d
CROSS APPLY
(SELECT TOP 1
	EmployeeID,
	Name,
	Salary
FROM Employees
WHERE DepartmentID = d.DepartmentID
ORDER BY Salary DESC) e

--4 TASK (EASY) Write a query to join Customers and Orders using AND in the ON clause to filter customers who have placed orders in 2023 and who lives in the USA.
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	c.Country,
	o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
AND (YEAR(o.OrderDate) = 2023 AND c.Country = 'USA')

--5 TASK (EASY) Write a query to join a derived table (SELECT CustomerID, COUNT(*) FROM Orders GROUP BY CustomerID) with the Customers table to show the number of orders per customer.
SELECT 
	c.CustomerID,
	c.FirstName,
	o.OrderCount
FROM Customers c
CROSS APPLY
   (SELECT CustomerID, COUNT(*) AS OrderCount
    FROM Orders
	WHERE CustomerID = c.CustomerID
    GROUP BY CustomerID) o

--6 TASK (EASY) Write a query to join Products and Suppliers using OR in the ON clause to show products supplied by either 'Gadget Supplies' or 'Clothing Mart'.
SELECT 
	p.ProductID,
	p.ProductName,
	s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
AND (s.SupplierName = 'Gadget Supplies' OR s.SupplierName = 'Clothing Mart')

--7 TASK (EASY) Write a query to demonstrate the use of OUTER APPLY between Customers and a derived table that returns each Customers''s most recent order.
SELECT 
	c.CustomerID, c.FirstName, c.LastName, o.OrderDate
FROM Customers c
OUTER APPLY
(SELECT TOP 1
	CustomerID,
	OrderDate
 FROM Orders
 WHERE CustomerID = c.CustomerID
 ORDER BY OrderDate DESC
) o

--8 TASK (MEDIUM) Write a query that uses the AND logical operator in the ON clause to join Orders and Customers, and filter customers who placed an order with a total amount greater than 500.
SELECT 
	o.OrderID,
	o.CustomerID,
	c.FirstName,
	c.LastName,
	o.TotalAmount
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
AND o.TotalAmount > 500
--9 TASK (MEDIUM) Write a query that uses the OR logical operator in the ON clause to join Products and Sales to filter products that were either sold in 2022 or the SaleAmount is more than 400.
SELECT 
	p.ProductID,
	p.ProductName,
	s.SaleDate,
	s.SaleAmount
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
AND (YEAR(s.SaleDate) = 2022 OR s.SaleAmount>400)

--10 TASK (MEDIUM) Write a query to join a derived table that calculates the total sales (SELECT ProductID, SUM(Amount) FROM Sales GROUP BY ProductID) with the Products table to show total sales for each product.
SELECT 
	p.ProductID,
	p.ProductName,
	s.TotalSales
FROM Products p
CROSS APPLY
	(SELECT ProductID, 
	SUM(SaleAmount) AS TotalSales
	FROM Sales
	WHERE ProductID = p.ProductID
	GROUP BY ProductID) s

--11 TASK (MEDIUM) Write a query to join Employees and Departments using AND in the ON clause to filter employees who belong to the 'HR' department and whose salary is greater than 50000.
SELECT  
	e.EmployeeID,
	e.Name,
	d.DepartmentName,
	e.Salary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName = 'Human Resources' AND e.Salary > 50000)

--12 TASK (MEDIUM) Write a query to use OUTER APPLY to return all customers along with their most recent orders, including customers who have not placed any orders.
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	o.OrderID,
	o.OrderDate
FROM Customers c
OUTER APPLY
	(SELECT TOP 1
		OrderDate,
		OrderID
	FROM Orders
	WHERE CustomerID = c.CustomerID
	ORDER BY OrderDate DESC
	) o

--13 TASK (MEDIUM) Write a query to join Products and Sales using AND in the ON clause to filter products that were sold in 2023 and StockQuantity is more than 50.
SELECT 
	p.ProductID,
	p.ProductName,
	s.SaleDate,
	p.StockQuantity
FROM Products p
JOIN Sales s 
ON p.ProductID = s.ProductID
AND (YEAR(s.SaleDate)=2023 AND p.StockQuantity > 50)

--14 TASK (MEDIUM) Write a query to join Employees and Departments using OR in the ON clause to show employees who either belong to the 'Sales' department or hired after 2020.
SELECT  
	e.EmployeeID,
	e.Name,
	d.DepartmentName,
	e.HireDate
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName = 'Sales' OR YEAR(e.HireDate) > 2020)

--15 TASK (HARD) Write a query to demonstrate the use of the AND logical operator in the ON clause between Orders and Customers, and filter orders made by customers who are located in 'USA' and lives in an address that starts with 4 digits.
SELECT 
	o.OrderID,
	c.CustomerID,
	c.Country,
	c.Address
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
AND (c.Country = 'USA' AND c.Address LIKE '[0-9][0-9][0-9][0-9]%')

--16 TASK (HARD) Write a query to demonstrate the use of OR in the ON clause when joining Products and Sales to show products that are either part of the 'Electronics' category or Sale amount is greater than 350.
SELECT 
	p.ProductID,
	p.ProductName,
	c.CategoryName,
	s.SaleAmount
FROM Products p
JOIN Categories c ON p.Category = c.CategoryID
JOIN Sales s ON p.ProductID = s.ProductID
AND (c.CategoryName = 'Electronics' OR s.SaleAmount > 350)

--17 TASK (HARD) Write a query to join a derived table that returns a count of products per category (SELECT CategoryID, COUNT(*) FROM Products GROUP BY CategoryID) with the Categories table to show the count of products in each category.
SELECT 
	c.CategoryID,
	c.CategoryName,
	p.ProductCount
FROM Categories c
CROSS APPLY
	(SELECT Category, COUNT(*) AS ProductCount
	FROM Products
	WHERE Category = c.CategoryID
	GROUP BY Category) p

--18 TASK (HARD) Write a query to join Orders and Customers using AND in the ON clause to show orders where the customer is from 'Los Angeles' and the order amount is greater than 300.
SELECT 
	o.OrderID,
	c.CustomerID,
	c.FirstName,
	c.LastName,
	c.City,
	o.TotalAmount
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
AND (c.City = 'Los Angeles' AND o.TotalAmount > 300)

--19 TASK (HARD) Write a query to join Employees and Departments using a complex OR condition in the ON clause to show employees who are in the 'HR' or 'Finance' department, or have at least 4 vowels in their name.
SELECT  
	e.EmployeeID,
	e.Name,
	d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName IN ('Human Resources','Finance') OR Name LIKE '%[aeiou]%[aeiou]%[aeiou]%[aeiou]%')

--20 TASK (HARD) Write a query to join Sales and Products using AND in the ON clause to filter products that have both a sales quantity greater than 100 and a price above 500.
SELECT 
	p.ProductID,
	p.ProductName,
	s.SaleAmount,
	p.Price
FROM Sales s
JOIN Products p
ON s.ProductID = p.ProductID
AND (s.SaleAmount > 100 AND p.Price > 100)

--21 TASK (HARD) Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department, and with a salary greater than 60000.
SELECT  
	e.EmployeeID,
	e.Name,
	d.DepartmentName,
	e.Salary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND(d.DepartmentName = 'Marketing' OR d.DepartmentName = 'Sales' AND e.Salary > 60000)