--11.1 Show all orders placed after 2022 along with the names of the customers who placed them.
SELECT 
	o.OrderID,
	c.FirstName AS CustomerName,
	o.OrderDate
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) > 2022

--11.2 Display the names of employees who work in either the Sales or Marketing department.
SELECT 
	e.Name AS EmployeeName,
	d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')

--11.3 For each department, show the name of the employee who earns the highest salary.
SELECT 
	d.DepartmentName,
	e.Name AS TopEmployeeName,
	e.Salary AS MaxSalary
FROM Departments d
CROSS APPLY
(SELECT TOP 1 *
 FROM Employees
 WHERE d.DepartmentID = DepartmentID
 ORDER BY Salary DESC) e

--11.4 List all customers from the USA who placed orders in the year 2023.
SELECT
	c.FirstName AS CustomerName,
	o.OrderID,
	o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023 AND c.Country = 'USA'

--11.5 Show how many orders each customer has placed.
SELECT
	c.FirstName AS CustomerName,
	o.order_count AS TotalOrders
FROM Customers c
CROSS APPLY
(SELECT COUNT(*) AS order_count
FROM Orders
WHERE c.CustomerID = CustomerID
) o

--11.6 Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
SELECT 
	p.ProductName,
	s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies' ,'Clothing Mart')

--11.7 For each customer, show their most recent order. Include customers who haven't placed any orders.
SELECT
	c.FirstName AS CustomerName,
	o.OrderDate AS MostRecentOrderDate,
	o.OrderID
FROM Customers c
OUTER APPLY
(SELECT TOP 1 *
FROM Orders
WHERE c.CustomerID = CustomerID
ORDER BY OrderDate DESC
) o

--11.8 Show the customers who have placed an order where the total amount is greater than 500.
SELECT 
	c.FirstName AS CustomerName, 
	o.OrderID,
	o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500

--11.9 List product sales where the sale was made in 2022 or the sale amount exceeded 400.
SELECT 
	p.ProductName,
	s.SaleDate,
	s.SaleAmount
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
AND (YEAR(s.SaleDate) = 2022 OR s.SaleAmount>400)

--11.10 Display each product along with the total amount it has been sold for.
SELECT
	p.ProductName,
	s.TotalSalesAmount
FROM Products p
CROSS APPLY
(SELECT
	ProductID,
	SUM(SaleAmount) AS TotalSalesAmount
FROM Sales
WHERE p.ProductID = ProductID
GROUP BY ProductID
) s

--11.11 Show the employees who work in the HR department and earn a salary greater than 50000.
SELECT  
	e.Name AS EmployeeName,
	d.DepartmentName,
	e.Salary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName = 'Human Resources' AND e.Salary > 50000)

--11.12 List the products that were sold in 2023 and had more than 50 units in stock at the time.
SELECT 
	p.ProductName,
	s.SaleDate,
	p.StockQuantity
FROM Products p
JOIN Sales s 
ON p.ProductID = s.ProductID
AND (YEAR(s.SaleDate)=2023 AND p.StockQuantity > 50)

--11.13 Show employees who either work in the Sales department or were hired after 2020.
SELECT  
	e.Name AS EmployeeName,
	d.DepartmentName,
	e.HireDate
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName = 'Sales' OR YEAR(e.HireDate) > 2020)

--11.14 List all orders made by customers in the USA whose address starts with 4 digits.
SELECT 
	c.FirstName AS CustomerName,
	o.OrderID,
	c.Address,
	o.OrderDate
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
AND (c.Country = 'USA' AND c.Address LIKE '[0-9][0-9][0-9][0-9]%')

--11.15 Display product sales for items in the Electronics category or where the sale amount exceeded 350.
SELECT 
	p.ProductName,
	c.CategoryName,
	s.SaleAmount
FROM Products p
JOIN Categories c ON p.Category = c.CategoryID
JOIN Sales s ON p.ProductID = s.ProductID
AND (c.CategoryName = 'Electronics' OR s.SaleAmount > 350)

--11.16 Show the number of products available in each category.
SELECT 
	c.CategoryName,
	p.ProductCount
FROM Categories c
CROSS APPLY
(SELECT Category,COUNT(*) AS ProductCount
 FROM Products
 WHERE c.CategoryID = Category
 GROUP BY Category
) p

--11.17 List orders where the customer is from Los Angeles and the order amount is greater than 300.
SELECT 
	c.FirstName AS CustomerName,
	c.City,
	o.OrderID,
	o.TotalAmount
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
AND (c.City = 'Los Angeles' AND o.TotalAmount > 300)

--11.18 Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
SELECT  
	e.Name AS EmployeeName,
	d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName IN ('Human Resources','Finance') OR Name LIKE '%[aeiou]%[aeiou]%[aeiou]%[aeiou]%')

--11.19 List products that had a sales quantity above 100 and a price above 500.
SELECT 
	p.ProductName,
	s.SaleAmount AS QuantitySold,
	p.Price
FROM Sales s
JOIN Products p
ON s.ProductID = p.ProductID
WHERE s.SaleAmount > 100 AND p.Price > 500

--11.20 Show employees who are in the Sales or Marketing department and have a salary above 60000.
SELECT  
	e.Name AS EmployeeName,
	d.DepartmentName,
	e.Salary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
AND(d.DepartmentName = 'Marketing' OR d.DepartmentName = 'Sales' AND e.Salary > 60000)