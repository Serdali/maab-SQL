--2.1 Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
CREATE TABLE Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))

--2.2 Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
	(1, 'John Wick', 20000),
	(2, 'Alex Cross', 25000),
	(3, 'Lucy Lee', 16000)

--2.3 Update the Salary of an employee where EmpID = 1.
UPDATE Employees
SET Salary = 22500
WHERE EmpID = 1

--2.4 Delete a record from the Employees table where EmpID = 2.
DELETE FROM Employees
WHERE EmpID = 2

--2.5 Demonstrate the difference between DELETE, TRUNCATE, and DROP commands on a test table.
DELETE FROM TestTable
WHERE ID = 1

TRUNCATE TABLE TestTable

DROP TABLE TestTable

--2.6 Modify the Name column in the Employees table to VARCHAR(100).
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100)

--2.7 Add a new column Department (VARCHAR(50)) to the Employees table
ALTER TABLE Employees
ADD Department VARCHAR(50)

--2.8 Change the data type of the Salary column to FLOAT.
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT

--2.9 Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
CREATE TABLE Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50))

--2.10 Remove all records from the Employees table without deleting its structure.
DELETE FROM Employees

--2.11 Insert five records into the Departments table using INSERT INTO SELECT from an existing table.
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES 
	(1, 'IT'),
	(2, 'Sales'),
	(3, 'Marketing'),
	(4, 'Finance'),
	(5, 'HR')

--2.12 Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Employees
SET DepartmentName = 'Management'
WHERE Salary > 50000

--2.13 Write a query that removes all employees but keeps the table structure intact.
DELETE FROM Employees

--2.14 Drop the Department column from the Employees table.
ALTER TABLE Employees
DROP COLUMN DepartmentID

--2.15 Rename the Employees table to StaffMembers using SQL commands.
EXEC sp_rename 'Employees', 'StaffMembers'

--2.16 Write a query to completely remove the Departments table from the database.
DROP TABLE Departments

--2.17	Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE Products (ProductID INT Primary Key, ProductName VARCHAR(50), Category VARCHAR(50), Price DECIMAL(10,2))

--2.18 Add a CHECK constraint to ensure Price is always greater than 0.
ALTER TABLE Products
ADD CONSTRAINT chk_prod_price CHECK (Price > 0)

--2.19 Modify the table to add a StockQuantity column with a DEFAULT value of 50.
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50

--2.20 Rename Category to ProductCategory
sp_rename 'dbo.Products.Category', 'ProductCategory', 'COLUMN'

--2.21 Insert 5 records into the Products table using standard INSERT INTO queries.
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES 
	(1, 'Laptop', 'Electronics', 53.5, 100),
	(2, 'Keyboard', 'Electronics', 66.52, 120),
	(3, 'Kettle', 'Kitchen', 23.35, 150),
	(4, 'Kitchen Table', 'Kitchen', 57.42, 110),
	(5, 'Notebook', 'Stationery', 5.25, 130)

--2.22 Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT *
INTO Products_Backup
FROM Products

--2.23 Rename the Products table to Inventory.
sp_rename 'Products', 'Inventory'

--2.24 Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
ALTER TABLE Inventory
DROP CONSTRAINT IF EXISTS chk_prod_price

-- Alter the column
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT NOT NULL

-- Re-add the CHECK constraint
ALTER TABLE Inventory
ADD CONSTRAINT chk_prod_price CHECK (Price > 0)

--2.25 Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5.
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5)