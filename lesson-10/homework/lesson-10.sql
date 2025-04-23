--10.1 Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
SELECT 
	e.Name AS EmployeeName,
	e.Salary,
	d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000

--10.2 Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
SELECT 
	c.FirstName,
	c.LastName,
	o.OrderDate
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023

--10.3 Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
SELECT
	e.Name AS EmployeeName,
	d.DepartmentName
FROM Employees e
LEFT OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID

--10.4 Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
SELECT 
	s.SupplierName,
	p.ProductName
FROM Products p
RIGHT JOIN Suppliers s
ON p.SupplierID = s.SupplierID

--10.5 Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
SELECT 
	o.OrderID,
	o.OrderDate,
	p.PaymentDate,
	p.Amount
FROM Orders o
FULL JOIN Payments p 
ON o.OrderID = p.OrderID

--10.6 Using the Employees table, write a query to show each employee's name along with the name of their manager.
SELECT 
	e.Name AS EmployeeName,
	m.Name AS ManagerName
FROM Employees e
JOIN Employees m
ON e.ManagerID = m.EmployeeID

--10.7 Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
SELECT 
	s.Name AS StudentName,
	c.CourseName
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
JOIN Courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101'

--10.8 Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
SELECT 
	c.FirstName,
	c.LastName,
	o.Quantity
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3

--10.9 Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
SELECT 
	e.Name AS EmployeeName, 
	d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources'

--10.10 Using the Employees and Departments tables, write a query to return department names that have more than 10 employees.
SELECT
	d.DepartmentName,
	COUNT(e.EmployeeID) AS EmployeeCount
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) >= 10

--10.11 Using the Products and Sales tables, write a query to find products that have never been sold.
SELECT 
	p.ProductID,
	p.ProductName
FROM Products p
LEFT OUTER JOIN Sales s
ON p.ProductID = s.ProductID
WHERE s.SaleAmount IS NULL

--10.12 Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
SELECT
	c.FirstName,
	c.LastName,
	COUNT(o.OrderID) AS TotalOrders	
FROM Customers c
RIGHT OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName,c.LastName
HAVING COUNT(o.OrderID) > 0

--10.13 Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
SELECT 
	e.Name AS EmployeeName,
	d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID

--10.14 Using the Employees table, write a query to find pairs of employees who report to the same manager.
SELECT
	e1.Name AS Employee1,
	e2.Name AS Employee2,
	e2.ManagerID AS ManagerID
FROM Employees e1
JOIN Employees e2
ON e1.ManagerID = e2.ManagerID
WHERE 
    e1.EmployeeID < e2.EmployeeID
    AND e1.ManagerID IS NOT NULL

--10.15 Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
SELECT 
	o.OrderID,
	o.OrderDate,
	c.FirstName,
	c.LastName
FROM Orders o
LEFT OUTER JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022

--10.16 Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
SELECT  
	e.Name AS EmployeeName,
	e.Salary,
	d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID AND d.DepartmentName = 'Sales' 
WHERE e.Salary >= 60000

--10.17 Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
SELECT
	o.OrderID,
	o.OrderDate,
	p.PaymentDate,
	p.Amount
FROM Orders o
JOIN Payments p
ON o.OrderID = p.OrderID

--10.18 Using the Products and Orders tables, write a query to find products that were never ordered.
SELECT 
	p.ProductID,
	p.ProductName
FROM Products p
LEFT OUTER JOIN Orders o
ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL

--10.19 Using the Employees table, write a query to find employees whose salary is greater than the average salary of all employees.
SELECT 
	Name AS EmployeeName,
	Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees)

--10.20 Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
SELECT 
	o.OrderID,
	o.OrderDate
FROM Orders o
LEFT OUTER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE YEAR(o.OrderDate) < 2023 AND p.PaymentID IS NULL

--10.21 Using the Products and Categories tables, write a query to return products that do not have a matching category.
SELECT
	p.ProductID,
	p.ProductName
FROM Products p
FULL OUTER JOIN Categories c
ON p.Category = c.CategoryID
WHERE c.CategoryID IS NULL

--10.22 Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
SELECT
	e1.Name AS Employee1,
	e2.Name AS Employee2,
	e1.ManagerID,
	e1.Salary
FROM Employees e1
JOIN Employees e2
ON e1.ManagerID = e2.ManagerID
   AND e1.EmployeeID < e2.EmployeeID
WHERE e1.Salary > 60000 AND e2.Salary > 60000

--10.23 Using the Employees and Departments tables, write a query to return employees who work in departments whose name starts with the letter 'M'.
SELECT  
	e.Name AS EmployeeName,
	d.DepartmentName
FROM Employees e
RIGHT OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%'

--10.24 Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
SELECT 
	s.SaleID,
	p.ProductName,
	s.SaleAmount
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 500

--10.25 Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
SELECT 
	s.StudentID,
	s.Name AS StudentName
FROM Students s
LEFT OUTER JOIN Enrollments e
ON s.StudentID = e.StudentID
LEFT OUTER JOIN Courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName <> 'Math 101' OR c.CourseName IS NULL

--10.26 Using the Orders and Payments tables, write a query to return orders that are missing payment details.
SELECT
	o.OrderID,
	o.OrderDate,
	p.PaymentID
FROM Orders o
FULL OUTER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL

--10.27 Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
SELECT 
	p.ProductID,
	p.ProductName,
	c.CategoryName
FROM Products p
JOIN Categories c
ON p.Category = c.CategoryID
WHERE c.CategoryName IN ('Electronics','Furniture')
