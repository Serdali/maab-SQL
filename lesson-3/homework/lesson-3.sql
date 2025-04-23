--3.1 Define and explain the purpose of BULK INSERT in SQL Server.
--BULK INSERT is a T-SQL command in SQL Server used to import large amounts of data from a data file directly into a SQL Server table.

--3.2 List four file formats that can be imported into SQL Server.
-- They are .txt, .csv, .xlsx, .xml

--3.3 Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
CREATE TABLE Products (ProductID INT Primary Key, ProductName VARCHAR(50), Price DECIMAL(10,2))

--3.4 Insert three records into the Products table using INSERT INTO
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
	(1, 'Laptop', 53.5),
	(2, 'Keyboard', 66.52),
	(3, 'Kettle', 23.35)

--3.5 Explain the difference between NULL and NOT NULL with examples.
--NULL: Represents missing, unknown, or undefined data. It does not equal zero or an empty string. It can be inserted a row without providing a value for a column that allows NULL.
--NOT NULL: Means the column must always have a value.
CREATE TABLE Employees (
    ID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NULL
);
--for null
INSERT INTO Employees (ID, Name, Email)
VALUES (3, 'Alice Green', NULL)
--for not null
INSERT INTO Employees (ID, Name, Email)
VALUES (1, 'John Smith', 'john.smith@email.com')

--3.6 Add a UNIQUE constraint to the ProductName column in the Products table.
ALTER TABLE Products
ADD CONSTRAINT UQ_productname UNIQUE(ProductName)

--3.7 Write a comment in a SQL query explaining its purpose.
-- Above query selects all products with a price greater than 100

--3.8 Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
CREATE TABLE Categories (CategoryID INT PRIMARY KEY, CategoryName VARCHAR(50) UNIQUE)
--3.9 Explain the purpose of the IDENTITY column in SQL Server
--The IDENTITY column is used to automatically generate unique numeric values for a column, typically used as a primary key

--3.10 Use BULK INSERT to import data from a text file into the Products table
BULK INSERT Products
FROM 'C:\DATA\products.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)

--3.11 Create a FOREIGN KEY in the Products table that references the Categories table
ALTER TABLE Products
ADD CategoryID INT

ALTER TABLE Products
ADD CONSTRAINT FK_prod_categories 
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)

--3.12 Explain the differences between PRIMARY KEY and UNIQUE KEY with examples.
--A PRIMARY KEY is used to uniquely identify each row in a table, and it cannot have NULL values. Each table can have only one primary key.

--A UNIQUE KEY also ensures that all values in a column are different, but it can allow one NULL, and a table can have multiple unique keys.

--3.13 Add a CHECK constraint to the Products table ensuring Price > 0.
ALTER TABLE Products
ADD CONSTRAINT CHK_prod_price CHECK (Price>0)

--3.14 Modify the Products table to add a column Stock (INT, NOT NULL).
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0

--3.15 Use the ISNULL function to replace NULL values in a column with a default value.
UPDATE Products
SET Stock = ISNULL(Stock,0)

--3.16 Describe the purpose and usage of FOREIGN KEY constraints in SQL Server
--A FOREIGN KEY in SQL Server is used to create a relationship between two tables. 
--It links a column in one table to the primary key or unique key of another table.

--3.17 Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
CREATE TABLE Customers (
	CustomerID INT,
	CustomerName VARCHAR(50),
	Age INT,
	CHECK (Age>=18)
)

--3.18 Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE NewTable (
	ID INT IDENTITY(100,10),
	Name VARCHAR(100)
)

--3.19 Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
CREATE TABLE OrderDetails (
	OrderID INT,
	Product INT,
	Quantity INT,
	PRIMARY KEY (OrderID,Product)
)

--3.20 Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.
SELECT ISNULL(Email, 'No Email') AS UserEmail
FROM Users

SELECT COALESCE(Phone, AlternatePhone, 'No Contact') AS ContactNumber
FROM Customers

--3.21 Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
CREATE TABLE Employees (
	EmpID INT PRIMARY KEY,
	Email VARCHAR(100) UNIQUE
)

--3.22 Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
)

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)