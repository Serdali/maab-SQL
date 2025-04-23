--9.1 Using Products, Suppliers table List all combinations of product names and supplier names.
SELECT 
	p.ProductName,
	s.SupplierName
FROM Products p
CROSS JOIN Suppliers s

--9.2 Using Departments, Employees table Get all combinations of departments and employees.
SELECT 
	d.DepartmentName,
	e.Name
FROM Departments d
CROSS JOIN Employees e

--9.3 Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
SELECT 
	p.ProductName,
	s.SupplierName
FROM Products p
JOIN Suppliers s
ON p.SupplierID = s.SupplierID

--9.4 Using Orders, Customers table List customer names and their orders ID.
SELECT 
	c.FirstName,
	o.OrderID
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID

--9.5 Using Courses, Students table Get all combinations of students and courses.
SELECT 
	s.Name,
	c.CourseName
FROM Courses c
CROSS JOIN Students s

--9.6 Using Products, Orders table Get product names and orders where product IDs match.
SELECT
	p.ProductName,
	o.OrderID
FROM Products p
JOIN Orders o
ON p.ProductID = o.ProductID

--9.7 Using Departments, Employees table List employees whose DepartmentID matches the department.
SELECT
	e.Name,
	d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID

--9.8 Using Students, Enrollments table List student names and their enrolled course IDs.
SELECT 
	s.Name,
	e.CourseID
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID

--9.9 Using Payments, Orders table List all orders that have matching payments.
SELECT 
	o.OrderID,
	p.PaymentID
FROM Payments p
JOIN Orders o
ON p.OrderID = o.OrderID

--9.10 Using Orders, Products table Show orders where product price is more than 100.
SELECT 
	o.OrderID,
	p.ProductName,
	p.Price
FROM Orders o
JOIN Products p
ON o.ProductID = p.ProductID
WHERE p.Price > 100

--9.11 Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
SELECT
	e.Name,
	d.DepartmentID
FROM Employees e
CROSS JOIN Departments d
WHERE
    e.DepartmentID <> d.DepartmentID

--9.12 Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
SELECT
	o.OrderID
FROM Orders o
JOIN Products p
ON o.ProductID = p.ProductID
WHERE o.Quantity > p.StockQuantity

--9.13 Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
SELECT 
	c.FirstName,
	s.ProductID,
	s.SaleAmount
FROM Customers c
JOIN Sales s
ON c.CustomerID = s.CustomerID
WHERE s.SaleAmount > 500

--9.14 Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
SELECT
	s.Name,
	c.CourseName
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
JOIN Students s ON e.StudentID = s.StudentID

--9.15 Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
SELECT 
	p.ProductName,
	s.SupplierName
FROM Products p
JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%Tech%'

--9.16 Using Orders, Payments table Show orders where payment amount is less than total amount.
SELECT
	o.OrderID,
	p.Amount,
	o.TotalAmount
FROM Orders o
JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.Amount < o.TotalAmount

--9.17 Using Employees table List employee names with salaries greater than their manager’s salary.
SELECT
	e.Name,
	e.Salary
FROM Employees e
JOIN Employees m
ON e.ManagerID = m.EmployeeID
WHERE e.Salary > m.Salary

--9.18 Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
SELECT
	p.ProductName,
	c.CategoryName
FROM Products p
JOIN Categories c
ON p.Category = c.CategoryID
WHERE c.CategoryName IN ('Electronics','Furniture')

--9.19 Using Sales, Customers table Show all sales from customers who are from 'USA'.
SELECT 
	c.CustomerID,
	c.FirstName,
	s.SaleAmount,
	s.SaleID,
	c.Country
FROM Sales s
JOIN Customers c
ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA'

--9.20 Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
SELECT
	o.OrderID,
	c.CustomerID,
	c.FirstName,
	c.Country,
	o.TotalAmount
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany' AND o.TotalAmount>100

--9.21 Using Employees table List all pairs of employees from different departments.
SELECT * FROM Employees e
CROSS JOIN Employees d
WHERE e.DepartmentID != d.DepartmentID

--9.22 Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
SELECT
	p.OrderID,
	p.PaymentDate,
	p.Amount,
	p.PaymentMethod
FROM Payments p
JOIN Orders o
ON p.OrderID = o.OrderID
JOIN Products pd
ON o.ProductID = pd.ProductID
WHERE p.Amount != (o.Quantity*pd.Price)

--9.23 Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
SELECT 
	s.StudentID, 
	s.Name, 
	s.Age, 
	s.Major
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.EnrollmentID IS NULL

--9.24 Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.
SELECT
	e.Name AS emp_name,
	m.Name AS manager_name,
	m.Salary AS manager_salary
FROM Employees e
JOIN Employees m
ON e.ManagerID = m.EmployeeID
WHERE e.Salary >= m.Salary

--9.25 Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
SELECT 
	c.CustomerID,
	c.FirstName,
	o.OrderID,
	o.TotalAmount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL