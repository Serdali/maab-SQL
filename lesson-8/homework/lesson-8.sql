--1 TASK (EASY)
SELECT 
	c.CustomerName,
	o.OrderDate
FROM [hwlesson_8].[dbo].[Customers] c
JOIN [hwlesson_8].[dbo].[Orders] o ON c.CustomerID = o.CustomerID

--2 TASK (EASY)
SELECT 
	e.EmployeeID,
	e.Name,
	ed.DepartmentName,
	e.Salary,
	e.HireDate
FROM Employees e
JOIN EmployeeDepartments ed ON e.EmployeeID = ed.EmployeeID

--3 TASK (EASY)
SELECT
	p.ProductName,
	pc.CategoryName
FROM Products p
JOIN ProductCategories pc ON p.ProductID = pc.ProductID

--4 TASK (EASY)
SELECT 
	c.CustomerID,
	c.CustomerName,
	c.Country,
	o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID

--5 TASK (EASY)
SELECT
	o.OrderID,
	o.OrderDate,
	p.ProductName
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID

--6 TASK (EASY)
SELECT 
	p.ProductName,
	pc.CategoryName
FROM Products p
CROSS JOIN ProductCategories pc

--7 TASK (EASY)
SELECT  
	c.CustomerID,
	c.CustomerName,
	c.Country,
	o.OrderID,
	o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID

--8 TASK (EASY)
SELECT
	p.ProductID,
	p.ProductName,
	od.OrderDate,
	od.TotalAmount
FROM Products p
CROSS JOIN OrderDetails od
WHERE od.TotalAmount > 500

--9 TASK (EASY)
SELECT
	e.Name,
	d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID

--10 TASK (EASY)
/* QUESTION IS NOT CLEAR, IT DIDN`T MENTION TABLES NAME */
SELECT t1*, t2*
FROM Table1 t1
JOIN Tabel2 t2 ON t1.column_name <> t2.column_name

--11 TASK (MEDIUM)
SELECT  
	c.CustomerName,
	SUM(od.Quantity) AS order_amount
FROM Customers c
JOIN OrderDetails od ON c.CustomerID = od.CustomerID
GROUP BY CustomerName

--12 TASK (MEDIUM)
/* NO SUCH TABLES NAME */

--13 TASK (MEDIUM)
SELECT 
	e.Name,
	e.Salary,
	d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.Salary > 50000

--14 TASK (MEDIUM)
SELECT 
	e.Name,
	ed.DepartmentName,
	e.Salary,
	e.HireDate
FROM Employees e
JOIN EmployeeDepartments ed ON e.EmployeeID = ed.EmployeeID

--15 TASK (MEDIUM)
/* NO SUPPLIER TABLE */

--16 TASK (MEDIUM)
SELECT 
	p.ProductName,
	SUM(s.SaleAmount) AS TotalSalesQuantity
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName

--17 TASK (MEDIUM)
SELECT 
	e.Name,
	e.Salary,
	d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 40000 AND d.DepartmentName = 'Human Resources'

--18 TASK (MEDIUM)
/* QUESTION IS NOT CLEAR, IT DIDN`T MENTION TABLES NAME */
SELECT t1*, t2*
FROM Table1 t1
JOIN Tabel2 t2 ON t1.column_name >= t2.column_name

--19 TASK (MEDIUM)
/* NO SUPPLIER TABLE */

--20 TASK (MEDIUM)
/* NO REGION TABLE */

--21 TASK (HARD)
SELECT  
	a.AuthorID,
	a.Name,
	b.Title
FROM Authors a
JOIN Books_Authors ba ON a.AuthorID = ba.AuthorID
JOIN Books b ON b.BookID = ba.BookID

--22 TASK (HARD)
SELECT 
	DISTINCT p.ProductName,
	pc.CategoryName
FROM Products p
JOIN ProductCategories pc ON p.ProductID = pc.ProductID
WHERE pc.CategoryName <> 'Electronics'

--23 TASK (HARD)
SELECT 
	p.ProductName,
	od.TotalAmount
FROM OrderDetails od
CROSS JOIN Products p
WHERE od.TotalAmount > 100

--24 TASK (HARD)
SELECT 
	e.Name,
	d.DepartmentName,
	e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
AND	HireDate <= DATEADD(YEAR, -5, GETDATE())

--25 TASK (HARD)
SELECT 
	e.EmployeeID,
	e.Name,
	d.DepartmentName,
	e.HireDate
FROM Employees e
JOIN Departments d 
ON e.DepartmentID = d.DepartmentID

SELECT 
	e.EmployeeID,
	e.Name,
	d.DepartmentName,
	e.HireDate
FROM Employees e
LEFT JOIN Departments d 
ON e.DepartmentID = d.DepartmentID

--26 TASK (HARD)
/* NO SUPPLIER TABLE */

--27 TASK (HARD)
SELECT
	c.CustomerID,
	c.CustomerName,
	COUNT(od.OrderID) AS OrderCount
FROM Customers c
JOIN OrderDetails od
ON c.CustomerID = od.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(od.OrderID) > 10

--28 TASK (HARD)
/* NO COURCES AND STUDENTS TABLE */

--29 TASK (HARD)
SELECT 
	e.EmployeeID,
	e.Name,
	d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Marketing'

--30 TASK (HARD)
/* QUESTION IS NOT CLEAR, IT DIDN`T MENTION TABLES NAME */