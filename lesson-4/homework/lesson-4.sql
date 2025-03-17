-----WILDCARD AND SPECIAL OPERATORS

--1 TASK
SELECT * FROM salesman
WHERE city = ' Paris' OR city = ' Rome'

--2 TASK
SELECT * FROM salesman
WHERE city = ' Paris' OR city = ' Rome'

--3 TASK
SELECT * FROM salesman
WHERE city NOT IN (' Paris', ' Rome')

--4 TASK
SELECT * FROM customer
WHERE customer_id IN (3007, 3008, 3009)

--5 TASK
SELECT * FROM salesman
WHERE commission BETWEEN 0.12 AND 0.14

--6 TASK
SELECT * FROM orders
WHERE purch_amt BETWEEN 500 AND 4000 AND purch_amt NOT IN (948.50, 1983.43)

--7 TASK
SELECT * FROM salesman
WHERE name BETWEEN 'A' and 'L'

--8 TASK
SELECT * FROM salesman
WHERE name NOT BETWEEN 'A' and 'M'

--9 TASK
SELECT * FROM customer
WHERE cust_name LIKE 'B%'

--10 TASK
SELECT * FROM customer
WHERE cust_name LIKE '%N'

--11 TASK
SELECT * FROM salesman
WHERE name LIKE 'N__L%'

--20 TASK
SELECT * FROM customer
WHERE grade IS NULL

--21 TASK
SELECT * FROM customer
WHERE grade IS NOT NULL

--22 TASK
SELECT * FROM emp_details
WHERE EMP_LNAME LIKE 'D%'

-----SORT FILTER
--1 TASK
SELECT CONCAT(FIRST_NAME,LAST_NAME) AS Full_Name, SALARY FROM employees
WHERE SALARY < 6000

--2 TASK
SELECT FIRST_NAME, LAST_NAME,DEPARTMENT_ID, SALARY FROM employees
WHERE SALARY > 8000

--3 TASK
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID FROM employees
WHERE LAST_NAME = ' McEwen'

--4 TASK
SELECT * FROM employees
WHERE DEPARTMENT_ID IS NULL

--5 TASK
SELECT * FROM departments
WHERE DEPARTMENT_NAME = 'Marketing'

--6 TASK
SELECT CONCAT(FIRST_NAME, '', LAST_NAME) AS Full_Name, HIRE_DATE,SALARY,DEPARTMENT_ID FROM employees
WHERE FIRST_NAME NOT LIKE '%M%'
ORDER BY DEPARTMENT_ID

--7 TASK
SELECT * FROM employees
WHERE SALARY BETWEEN 8000 AND 12000
	AND COMMISSION_PCT IS NOT NULL
	OR DEPARTMENT_ID NOT IN (40, 70, 120)
	AND HIRE_DATE < '1987-06-05'

--8 TASK
SELECT CONCAT(FIRST_NAME, '', LAST_NAME) AS Full_Name, SALARY FROM employees
WHERE COMMISSION_PCT IS NULL

--9 TASK
SELECT CONCAT(FIRST_NAME, '', LAST_NAME) AS Full_Name,CONCAT(PHONE_NUMBE, ' - ', EMAIL) AS Contact_Details,SALARY FROM employees
WHERE SALARY BETWEEN 9000 AND 17000

--10 TASK
SELECT FIRST_NAME, LAST_NAME, SALARY FROM employees
WHERE FIRST_NAME LIKE '%M'

--11 TASK
SELECT CONCAT(FIRST_NAME, '', LAST_NAME) AS Full_Name, SALARY FROM employees
WHERE SALARY NOT BETWEEN 7000 AND 15000
ORDER BY Full_Name

--12 TASK
SELECT CONCAT(FIRST_NAME, '', LAST_NAME) AS Full_Name, JOB_ID, HIRE_DATE FROM employees
WHERE HIRE_DATE BETWEEN '2007-11-05' AND '2009-07-05'

--13 TASK
SELECT CONCAT(FIRST_NAME, '', LAST_NAME) AS Full_Name, DEPARTMENT_ID FROM employees
WHERE DEPARTMENT_ID = 70 OR DEPARTMENT_ID = 90

--14 TASK
SELECT CONCAT(FIRST_NAME, '', LAST_NAME) AS Full_Name, SALARY, MANAGER_ID FROM employees
WHERE MANAGER_ID IS NOT NULL

--15 TASK
SELECT * FROM employees
WHERE HIRE_DATE < '2002-06-21'

--16 TASK
SELECT FIRST_NAME, LAST_NAME, EMAIL, SALARY, MANAGER_ID FROM employees
WHERE MANAGER_ID IN (120, 103, 145)

--17 TASK
SELECT * FROM employees
WHERE FIRST_NAME LIKE '%D%'
	OR FIRST_NAME LIKE '%S%'
	OR FIRST_NAME LIKE '%N%'
ORDER BY SALARY DESC

--18 TASK
SELECT CONCAT(FIRST_NAME, '', LAST_NAME) AS Full_Name, HIRE_DATE, COMMISSION_PCT, 
CONCAT(EMAIL, '- ', PHONE_NUMBE) AS Contact_details, SALARY
FROM employees
WHERE SALARY > 11000 OR PHONE_NUMBE LIKE '______3%'
ORDER BY FIRST_NAME DESC

--19 TASK
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID FROM employees
WHERE FIRST_NAME LIKE '___S%'

--20 TASK
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, DEPARTMENT_ID FROM employees
WHERE DEPARTMENT_ID NOT IN (50,30,80)

--21 TASK
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, DEPARTMENT_ID FROM employees
WHERE DEPARTMENT_ID IN (30,40,90)

--22 TASK
SELECT EMPLOYEE_ID FROM job_history
GROUP BY EMPLOYEE_ID
HAVING COUNT(EMPLOYEE_ID)>=2

--23 TASK
SELECT JOB_ID, COUNT(JOB_ID) AS count, SUM(SALARY) AS sum, (MAX(SALARY) - MIN(SALARY)) AS salary_difference
FROM employees
GROUP BY JOB_ID

--24 TASK
SELECT JOB_ID FROM job_history
WHERE DATEDIFF(DAY,START_DATE,END_DATE) > 300
GROUP BY JOB_ID
HAVING COUNT(*)>=2

--25 TASK
SELECT COUNTRY_ID, COUNT(*) AS count
FROM locations
GROUP BY COUNTRY_ID

--26 TASK
SELECT MANAGER_ID, COUNT(*) FROM employees
GROUP BY MANAGER_ID

--27 TASK
SELECT * FROM jobs
ORDER BY JOB_TITLE DESC

--28 TASK
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE FROM employees
WHERE JOB_ID IN (' SA_REP', ' SA_MAN')

--29 TASK
SELECT DEPARTMENT_ID, AVG(SALARY) 
FROM employees
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID

--30 TASK
SELECT DISTINCT(DEPARTMENT_ID) FROM employees
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 4

--31 TASK
SELECT DEPARTMENT_ID FROM employees
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID
HAVING COUNT(COMMISSION_PCT) > 10

--32 TASK
SELECT EMPLOYEE_ID, MAX(END_DATE) AS Max FROM job_history
	WHERE EMPLOYEE_ID IN (
		SELECT EMPLOYEE_ID FROM job_history
		GROUP BY EMPLOYEE_ID
		HAVING COUNT(EMPLOYEE_ID)>1
	)
GROUP BY EMPLOYEE_ID

--33 TASK
SELECT * FROM employees
WHERE COMMISSION_PCT IS NULL
	AND SALARY BETWEEN 7000 AND 12000
	AND DEPARTMENT_ID = 50

--34 TASK
SELECT JOB_ID, AVG(SALARY) AS Avg_salary FROM employees
GROUP BY JOB_ID
HAVING AVG(SALARY) >= 8000

--35 TASK
SELECT JOB_TITLE, MAX_SALARY - MIN_SALARY AS salary_difference FROM jobs
WHERE MAX_SALARY BETWEEN 12000 AND 18000

--36 TASK
SELECT FIRST_NAME, LAST_NAME FROM employees
WHERE FIRST_NAME LIKE ' D%' OR LAST_NAME LIKE ' D%'

--37 TASK
SELECT * FROM jobs
WHERE MIN_SALARY > 9000

--38 TASK
SELECT * FROM employees
WHERE HIRE_DATE > '1987-09-07'

--Telegram Questions
--1 TASK (EASY) Write a query to select the top 5 employees from the Employees table.
SELECT TOP 5 * FROM Employees

--2 TASK (EASY) Use SELECT DISTINCT to select unique ProductName values from the Products table.
SELECT DISTINCT ProductName FROM Products

--3 TASK (EASY) Write a query that filters the Products table to show products with Price > 100.
SELECT * 
FROM Products
WHERE Price > 100

--4 TASK (EASY) Write a query to select all CustomerName values that start with 'A' using the LIKE operator.
SELECT FirstName 
FROM Customers
WHERE FirstName LIKE 'A%'

--5 TASK (EASY) Order the results of a Products query by Price in ascending order.
SELECT * 
FROM Products
ORDER BY Price

--6 TASK (EASY) Write a query that uses the WHERE clause to filter for employees with Salary >= 5000 and Department = 'HR'.
SELECT * 
FROM Employees
WHERE Salary >= 5000 AND DepartmentID = 2 /*2 is HR from departments table*/

--7 TASK (EASY) Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".
SELECT CustomerID, FirstName, LastName, ISNULL(Email, 'noemail@example.com') AS Email FROM Customers

--8 TASK (EASY) Write a query that shows all products with Price BETWEEN 50 AND 100.
SELECT ProductName, Price 
FROM Products
WHERE Price BETWEEN 50 AND 100

--9 TASK (EASY) Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
SELECT DISTINCT Category, ProductName FROM Products

--10 TASK (EASY) Order the results by ProductName in descending order.
SELECT * 
FROM Products
ORDER BY ProductName DESC

--11 TASK (MEDIUM) Write a query to select the top 10 products from the Products table, ordered by Price DESC. 
SELECT TOP 10 * 
FROM Products
ORDER BY Price DESC

--12 TASK (MEDIUM) Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
--Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
/*NO SUCH TABLE*/

--13 TASK (MEDIUM) Write a query that selects distinct Category and Price from the Products table.
SELECT DISTINCT Category,Price FROM Products

--14 TASK (MEDIUM) Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
--Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
/*NO SUCH TABLE*/

--15 TASK (MEDIUM) Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
SELECT * 
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY

--16 TASK (MEDIUM) Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.
SELECT ProductName,Price,StockQuantity 
FROM Products
WHERE Price <= 1000 AND StockQuantity > 50
ORDER BY StockQuantity

--17 TASK (MEDIUM) Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.
SELECT * 
FROM Products
WHERE ProductName LIKE '%E%'

--18 TASK (MEDIUM) Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
SELECT * 
FROM EmployeeDepartments
WHERE DepartmentName IN ('HR', 'IT', 'Finance')

--19 TASK (MEDIUM) Write a query that uses the ANY operator to find employees who earn more than the average salary of all employees.
SELECT * 
FROM Employees
WHERE Salary > ANY (SELECT AVG(Salary) FROM Employees)

--20 TASK (MEDIUM) Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.
SELECT * 
FROM Customers
ORDER BY City ASC, PostalCode DESC

--21 TASK (HARD) Write a query that selects the top 10 products with the highest sales, using TOP(10) and ordered by SalesAmount DESC.
SELECT TOP(10) ProductID, SaleAmount
FROM Sales
ORDER BY SaleAmount DESC

--22 TASK (HARD) Use COALESCE to combine FirstName and LastName into one column named FullName in the Employees table.
SELECT COALESCE (FirstName,'') + ' ' + COALESCE(LastName,'') AS FullName
FROM Employees

--23 TASK (HARD) Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
SELECT 
	DISTINCT Category, 
	ProductName,
	Price
FROM Products
WHERE Price > 50

--24 TASK (HARD) Write a query that selects products whose Price is within 10% of the average price in the Products table.
SELECT 
	ProductName,
	Price
FROM Products
WHERE Price BETWEEN 
	(SELECT AVG(Price) FROM Products)* 0.9 
	AND
	(SELECT AVG(Price)  FROM Products)* 1.1

--25 TASK (HARD) Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
/*NO SUCH TABLE*/

--26 TASK (HARD) Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
SELECT * FROM Customers
WHERE Email LIKE '%@gmail.com'

--27 TASK (HARD) Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.
SELECT 
	Name,
	DepartmentID,
	Salary
FROM Employees
WHERE Salary > ALL (SELECT Salary FROM Employees WHERE DepartmentID = 1) /*1 is Sales from departments table*/

--28 TASK (HARD) Use ORDER BY with OFFSET-FETCH to show employees with the highest salaries, displaying 10 employees at a time (pagination).
SELECT * FROM Employees
ORDER BY Salary DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY

--29 TASK (HARD) Write a query that filters the Orders table for orders placed in the last 30 days using BETWEEN and CURRENT_DATE.
SELECT * 
FROM Orders
WHERE OrderDate BETWEEN DATEADD(day, -30, CURRENT_TIMESTAMP) AND CURRENT_TIMESTAMP

--30 TASK (HARD) Use ANY with a subquery to select all employees who earn more than the average salary for their department.
SELECT * 
FROM Employees e
WHERE Salary > ANY 
	(SELECT AVG(Salary) 
	FROM Employees 
	GROUP BY DepartmentID
	HAVING DepartmentID = e.DepartmentID)

