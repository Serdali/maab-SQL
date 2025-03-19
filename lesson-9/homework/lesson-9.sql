--1 TASK (EASY) Write a query to join Employees and Departments using an INNER JOIN, and apply a WHERE clause to show only employees whose salary is greater than 5000.
SELECT
	e.Name,
	e.Salary,
	d.DepartmentName
FROM [hwlesson_9].[dbo].Employees e
JOIN [hwlesson_9].[dbo].Departments d 
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000

--2 TASK (EASY) Write a query to join Customers and Orders using an INNER JOIN, and apply the WHERE clause to return only orders placed in 2023.
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	o.OrderID,	
	o.OrderDate,
	o.TotalAmount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023

--3 TASK (EASY) Write a query to demonstrate a LEFT OUTER JOIN between Employees and Departments, showing all employees and their respective departments (including employees without departments).
SELECT
	e.Name,
	d.DepartmentName
FROM Employees e
LEFT JOIN Departments d 
ON e.DepartmentID = d.DepartmentID

--4 TASK (EASY) Write a query to perform a RIGHT OUTER JOIN between Products and Suppliers, showing all suppliers and the products they supply (including suppliers without products).
SELECT 
	s.SupplierName,
	p.ProductName
FROM Products p
RIGHT JOIN Suppliers s
ON p.SupplierID = s.SupplierID

--5 TASK (EASY) Write a query to demonstrate a FULL OUTER JOIN between Orders and Payments, showing all orders and their corresponding payments (including orders without payments and payments without orders).
SELECT 
	o.OrderID,
	p.PaymentID
FROM Orders o
FULL JOIN Payments p 
ON o.OrderID = p.OrderID

--6 TASK (EASY) Write a query to perform a SELF JOIN on the Employees table to display employees and their respective managers (showing EmployeeName and ManagerName).
SELECT
	e1.Name AS EmployeeName,
	e2.Name AS ManagerName
FROM Employees e1
JOIN Employees e2
ON e1.ManagerID = e2.EmployeeID

--7 TASK (EASY) Write a query to join Students and Courses using INNER JOIN, and use the WHERE clause to show only students enrolled in 'Math 101'.(USE ENROLLMENTS TABLE AS A BRIDGE TABLE)
SELECT 
	s.Name,
	c.CourseName
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
JOIN Courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101'

--8 TASK (EASY) Write a query that uses INNER JOIN between Customers and Orders, and filters the result with a WHERE clause to show customers who have placed more than 3 items at once.
SELECT 
	c.FirstName,
	c.LastName,
	o.Quantity
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3

--9 TASK (EASY) Write a query to join Employees and Departments using a LEFT OUTER JOIN and use the WHERE clause to filter employees in the 'HR' department(Human Resources).
SELECT 
	e.Name,
	d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources'

--10 TASK (MEDIUM) Write a query to perform an INNER JOIN between Employees and Departments, and use the HAVING clause to show employees who belong to departments with more than 10 employees.
SELECT 
	e.Name,
	d.DepartmentName
FROM Employees e
JOIN Departments d 
ON e.DepartmentID = d.DepartmentID
WHERE e.DepartmentID IN (
	SELECT DepartmentID
	FROM Employees
	GROUP BY DepartmentID
	HAVING COUNT(EmployeeID) >= 10
)

--11 TASK (MEDIUM) Write a query to perform a LEFT OUTER JOIN between Products and Sales, and use the WHERE clause to filter only products with no sales.
SELECT 
	p.ProductName,
	s.SaleAmount
FROM Products p
LEFT OUTER JOIN Sales s
ON p.ProductID = s.ProductID
WHERE s.SaleAmount IS NULL

--12 TASK (MEDIUM) Write a query to perform a RIGHT OUTER JOIN between Customers and Orders, and filter the result using the HAVING clause to show only customers who have placed at least one order.
SELECT
	c.CustomerID,
	c.FirstName,
	COUNT(o.OrderID) AS TotalOrders	
FROM Customers c
RIGHT OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,c.FirstName
HAVING COUNT(o.OrderID) > 0

--13 TASK (MEDIUM) Write a query that uses a FULL OUTER JOIN between Employees and Departments, and filters out the results where the department is NULL.
SELECT 
	e.*,
	d.DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IS NULL

--14 TASK (MEDIUM) Write a query to perform a SELF JOIN on the Employees table to show employees who report to the same manager.
SELECT
	e1.Name AS EmployeeName,
	ISNULL (e2.Name,'No manager') AS ManagerName
FROM Employees e1
LEFT JOIN Employees e2
ON e1.ManagerID = e2.EmployeeID

--15 TASK (MEDIUM) Write a query to perform a LEFT OUTER JOIN between Orders and Customers, followed by a WHERE clause to filter orders placed in the year 2022.
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	o.OrderID,	
	o.OrderDate,
	o.TotalAmount
FROM Orders o
LEFT OUTER JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022

--16 TASK (MEDIUM) Write a query to use the ON clause with INNER JOIN to return only the employees from the 'Sales' department whose salary is greater than 5000.
SELECT  
	e.Name,
	e.Salary,
	d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID AND d.DepartmentName = 'Sales' 
WHERE e.Salary > 50000

--17 TASK (MEDIUM) Write a query to join Employees and Departments using INNER JOIN, and use WHERE to filter employees whose department's DepartmentName is 'IT'.
SELECT 
	e.Name,
	d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'IT'

--18 TASK (MEDIUM) Write a query to join Orders and Payments using a FULL OUTER JOIN, and use the WHERE clause to show only the orders that have corresponding payments.
SELECT 
	o.OrderID,
	p.Amount
FROM Orders o
FULL OUTER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE o.OrderID IS NOT NULL AND p.Amount IS NOT NULL

--19 TASK (MEDIUM) Write a query to perform a LEFT OUTER JOIN between Products and Orders, and use the WHERE clause to show products that have no orders.
SELECT 
	p.ProductID,
	p.ProductName,
	o.OrderID
FROM Products p
LEFT OUTER JOIN Orders o
ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL

--20 TASK (HARD) Write a query using a JOIN between Employees and Departments, followed by a WHERE clause to show employees whose salary is higher than the average salary of all employees.
SELECT
	e.EmployeeID,
	e.Name,
	e.Salary,
	d.DepartmentName
FROM Employees e
JOIN Departments d 
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > (SELECT AVG(Salary) FROM Employees)

--21 TASK (HARD) Write a query to perform a LEFT OUTER JOIN between Orders and Payments, and use the WHERE clause to return all orders placed before 2020 that have not been paid yet.
SELECT
	o.OrderID,
	p.PaymentID,
	p.Amount
FROM Orders o
LEFT OUTER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE YEAR(o.OrderDate) > 2023 AND p.PaymentID IS NULL

--22 TASK (HARD) Write a query to perform a FULL OUTER JOIN between Products and Categories, and use the WHERE clause to filter only products that have no category assigned.
SELECT
	p.ProductID,
	p.ProductName,
	c.CategoryName
FROM Products p
FULL OUTER JOIN Categories c
ON p.Category = c.CategoryID
WHERE c.CategoryName IS NULL

--23 TASK (HARD) Write a query to perform a SELF JOIN on the Employees table to find employees who report to the same manager and earn more than 50000.
SELECT
	e1.Name AS EmployeeName,
	e1.Salary,
	ISNULL (e2.Name,'No manager') AS ManagerName
FROM Employees e1
LEFT JOIN Employees e2
ON e1.ManagerID = e2.EmployeeID
WHERE e1.Salary > 50000

--24 TASK (HARD) Write a query to join Employees and Departments using a RIGHT OUTER JOIN, and use the WHERE clause to show employees from departments where the department name starts with ‘M’.
SELECT  
	e.EmployeeID,
	e.Name,
	d.DepartmentName
FROM Employees e
RIGHT OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%'

--25 TASK (HARD) Write a query to join Products and Sales, and use WHERE to filter only sales greater than 400.
SELECT 
	p.ProductName,
	s.SaleAmount
FROM Products p
JOIN Sales s
ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 400


--26 TASK (HARD) Write a query to perform a LEFT OUTER JOIN between Students and Courses, and use the WHERE clause to show only students who have not enrolled in 'Math 101'.(USE ENROLLMENTS TABLE AS A BRIDGE TABLE)
SELECT 
	s.Name,
	c.CourseName
FROM Students s
LEFT OUTER JOIN Enrollments e
ON s.StudentID = e.StudentID
LEFT OUTER JOIN Courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName <> 'Math 101' OR c.CourseName IS NULL

--27 TASK (HARD) Write a query using a FULL OUTER JOIN between Orders and Payments, followed by a WHERE clause to filter out the orders with no payment.
SELECT 
	o.OrderID,
	p.Amount
FROM Orders o
FULL OUTER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.Amount IS NULL

--28 TASK (HARD) Write a query to join Products and Categories using an INNER JOIN, and use the WHERE clause to filter products that belong to either 'Electronics' or 'Furniture'.
SELECT 
	p.ProductID,
	p.ProductName,
	c.CategoryID,
	c.CategoryName
FROM Products p
JOIN Categories c
ON p.Category = c.CategoryID
WHERE c.CategoryName = 'Electronics' OR c.CategoryName = 'Furniture' 

