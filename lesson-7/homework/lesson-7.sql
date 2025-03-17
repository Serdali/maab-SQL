--1 TASK (EASY) 
SELECT MIN(Price) AS Min_price FROM Products

--2 TASK (EASY) 
SELECT MAX(Salary) AS Max_salary FROM Employees

--3 TASK (EASY) 
SELECT COUNT(*) AS Num_of_rows FROM Customers

--4 TASK (EASY) 
SELECT COUNT(DISTINCT Category) AS Num_of_unique 
FROM Products

--5 TASK (EASY) 
SELECT 
	ProductID,
	SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID

--6 TASK (EASY)
/* NO AGE COLUMN IN EMPLOYEE TABLE */

--7 TASK (EASY)
SELECT DepartmentID, COUNT(*) AS employee_count FROM Employees
GROUP BY DepartmentID

--8 TASK (EASY)
SELECT 
	Category, 
	MIN(Price) AS Min, 
	MAX(Price) AS Max 
FROM Products
GROUP BY Category

--9 TASK (EASY)
/* NO REGION COLUMN IN SALES TABLE */

--10 TASK (EASY)
SELECT 
	DepartmentID, 
	COUNT(*) AS employee_count
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 5

--11 TASK (MEDIUM)
SELECT
	ProductID,
	SUM(SaleAmount) AS TotalSales, 
	AVG(SaleAmount) AS AvgSales 
FROM Sales
GROUP BY ProductID

--12 TASK (MEDIUM)
SELECT 
	RoleName,
	COUNT(RoleName) AS employee_count
FROM EmployeeRoles
GROUP BY RoleName

--13 TASK (MEDIUM)
SELECT 
	DepartmentID,
	MAX(Salary) AS Max,
	MIN(Salary) AS Min
FROM Employees
GROUP BY DepartmentID

--14 TASK (MEDIUM)
SELECT 
	DepartmentID,
	AVG(Salary) AS avg_salary
FROM Employees
GROUP BY DepartmentID

--15 TASK (MEDIUM)
SELECT 
	DepartmentID,
	AVG(Salary) AS avg_salary,
	COUNT(*) AS employee_count
FROM Employees
GROUP BY DepartmentID

--16 TASK (MEDIUM)
SELECT 
	ProductName,
	AVG(Price) AS avg_price
FROM Products
GROUP BY ProductName
HAVING AVG(Price) > 100

--17 TASK (MEDIUM)
SELECT 
	COUNT(DISTINCT ProductID) AS product_count
FROM Sales
WHERE SaleAmount > 100

--18 TASK (MEDIUM)
SELECT 
	YEAR(SaleDate) AS Year,
	SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate)

--19 TASK (MEDIUM)
/* NO REGION COLUMN IN SALES TABLE */

--20 TASK (MEDIUM)
SELECT 
	DepartmentID,
	SUM(Salary) AS total_salary
FROM Employees
GROUP BY DepartmentID
HAVING SUM(Salary) > 100000

--21 TASK (HARD)
SELECT 
	ProductID,
	AVG(SaleAmount) AS avg_sales
FROM Sales
GROUP BY ProductID
HAVING AVG(SaleAmount) > 200

--22 TASK (HARD)
SELECT 
	Name,
	SUM(Salary) AS Total_salary
FROM Employees
GROUP BY Name
HAVING SUM(Salary) > 5000

--23 TASK (HARD)
SELECT 
	DepartmentID,
	SUM(Salary) AS total_salary,
	AVG(Salary) AS avg_salary
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary)>6000

--24 TASK (HARD)
SELECT 
	CustomerID,
	MAX(TotalAmount) AS Max,
	MIN(TotalAmount) AS Min
FROM Orders
GROUP BY CustomerID
HAVING MIN(TotalAmount) > 50

--25 TASK (HARD)
/* NO REGION COLUMN IN SALES TABLE */

--26 TASK (HARD) THERE IS NOT ORDER QUANTITY IN THE TABLE, SO USED STOCKQUANTITY
SELECT 
	Category,
	MIN(StockQuantity) AS Min,
	MAX(StockQuantity) AS Max
FROM Products
GROUP BY Category

--27 TASK (HARD)
/* NO REGION COLUMN IN SALES TABLE */

--28 TASK (HARD)
/* NO SUCH TABLE */

-- 29 TASK (HARD) THERE IS NOT ORDER QUANTITY IN THE TABLE, SO USED STOCKQUANTITY
SELECT 
	Category,
	COUNT(StockQuantity)
FROM Products
GROUP BY Category
HAVING COUNT(StockQuantity) > 50

-- 30 TASK (HARD)
/* NO SUCH TABLE */