-- ### Task 1: Basic INNER JOIN
--Question: Retrieve all employee names along with their corresponding department names.
SELECT
	e.Name,
	d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID

--### Task 2: LEFT JOIN
--Question: List all students along with their class names, including students who are not assigned to any class.
SELECT
	s.StudentName,
	c.ClassName
FROM Students s
LEFT JOIN Classes c
ON s.ClassID = c.ClassID


--### Task 3: RIGHT JOIN
--Question: List all customers and their orders, including customers who haven’t placed any orders.
SELECT  
	c.CustomerName,
	o.OrderID,
	o.OrderDate
FROM Orders o
RIGHT JOIN Customers c
ON o.CustomerID = c.CustomerID


--### Task 4: FULL OUTER JOIN
--Question: Retrieve a list of all products and their sales, including products with no sales and sales with invalid product references.
SELECT 
	p.ProductID,
	p.ProductName,
	s.SaleID,
	s.Quantity
FROM Products p
FULL OUTER JOIN Sales s
ON p.ProductID = s.ProductID


--### Task 5: SELF JOIN
--Question: Find the names of employees along with the names of their managers. Use employee table
SELECT 
	e1.Name,
	ISNULL(e2.Name,'No manager') AS Manager_Name
FROM Employee e1
LEFT JOIN Employee e2
ON e1.ManagerID = e2.EmployeeID


--### Task 6: CROSS JOIN
--Question: Generate all possible combinations of colors and sizes.
SELECT * FROM Colors
CROSS JOIN Sizes

--### Task 7: Join with WHERE Clause
--Question: Find all movies released after 2015 and their associated actors.
SELECT 
	m.Title,
	a.Name,
	m.ReleaseYear
FROM Movies m
JOIN Actors a
ON m.MovieID = a.MovieID
WHERE ReleaseYear > 2015

--### Task 8: MULTIPLE JOINS
--Question: Retrieve the order date, customer name, and the product ID for all orders. Use orders_1, customer, OrderDetails table
SELECT  
	o.OrderDate,
	c.CustomerName,
	od.ProductID
FROM Orders_1 o
JOIN Customer c
ON o.CustomerID = c.CustomerID
JOIN OrderDetails od
ON o.OrderID = od.OrderID


--### Task 9: JOIN with Aggregation
--Question: Calculate the total revenue generated for each product. use Sales_1 and Products_1 tables
SELECT 
	s.ProductID,
	p.ProductName,
	SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales_1 s
JOIN Products_1 p
ON s.ProductID = p.ProductID
GROUP BY s.ProductID, p.ProductName