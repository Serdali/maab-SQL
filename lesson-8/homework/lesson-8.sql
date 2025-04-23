--8.1 Using Products table, find the total number of products available in each category.
SELECT 
	Category,
	COUNT(ProductID) AS total_products
FROM Products
GROUP BY Category

--8.2 Using Products table, get the average price of products in the 'Electronics' category.
SELECT 
	Category,
	AVG(Price) AS avg_price
FROM Products
WHERE Category = 'Electronics'
GROUP BY Category

--8.3 Using Customers table, list all customers from cities that start with 'L'.
SELECT * 
FROM Customers
WHERE City LIKE 'L%'

--8.4 Using Products table, get all product names that end with 'er'.
SELECT
	ProductName
FROM Products
WHERE ProductName LIKE '%er'

--8.5 Using Customers table, list all customers from countries ending in 'A'.
SELECT
	FirstName,
	Country
FROM Customers
WHERE Country LIKE '%A'

--8.6 Using Products table, show the highest price among all products.
SELECT 
	MAX(Price) AS highest_price
FROM Products

--8.7 Using Products table, use IIF to label stock as 'Low Stock' if quantity < 30, else 'Sufficient'.
SELECT 
	ProductName,
	StockQuantity,
	IIF(StockQuantity < 30, 'Low Stock', 'Sufficient') AS stock_status
FROM Products

--8.8 Using Customers table, find the total number of customers in each country.
SELECT
	Country,
	COUNT(CustomerID) AS cust_num
FROM Customers
GROUP BY Country

--8.9 Using Orders table, find the minimum and maximum quantity ordered.
SELECT
	MIN(Quantity) AS min_quantity,
	MAX(Quantity) AS max_quantity
FROM Orders

--8.10 Using Orders and Invoices tables, list customer IDs who placed orders in 2023 (using EXCEPT) to find those who did not have invoices.
SELECT CustomerID, OrderDate FROM Orders
WHERE YEAR(OrderDate) = 2023
EXCEPT
SELECT CustomerID, InvoiceDate FROM Invoices

--8.11 Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates.
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted

--8.12 Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates.
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted

--8.13 Using Orders table, find the average order amount by year.
SELECT 
	YEAR(OrderDate) AS OrderYear,
	AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate)

--8.14 Using Products table, use CASE to group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup.
SELECT 
	ProductName,
	CASE WHEN Price < 100 THEN 'Low'
		 WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
		 ELSE 'High'
	END AS price_group
FROM Products

--8.15 Using Customers table, list all unique cities where customers live, sorted alphabetically.
SELECT
	DISTINCT City
FROM Customers

--8.16 Using Sales table, find total sales per product Id.
SELECT 
	ProductID,
	SUM(SaleAmount) AS total_sales
FROM Sales
GROUP BY ProductID

--8.17 Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname.
SELECT
	ProductName
FROM Products
WHERE ProductName LIKE '%oo%'

--8.18 Using Products and Products_Discounted tables, compare product IDs using INTERSECT.
SELECT ProductID FROM Products
INTERSECT
SELECT ProductID FROM Products_Discounted

--8.19 Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent.
SELECT TOP 3
	CustomerID,
	TotalAmount AS Totalspent
FROM Invoices
ORDER BY Totalspent DESC

--8.20 Find product ID and productname that are present in Products but not in Products_Discounted.
SELECT
	ProductID,
	ProductName
FROM Products
EXCEPT
SELECT
	ProductID,
	ProductName
FROM Products_Discounted

--8.21 Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
SELECT 
	p.ProductName,
	COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s 
ON p.ProductID = s.ProductID
GROUP BY p.ProductName

--8.22 Using Orders table, find top 5 products (by ProductID) with the highest order quantities.
SELECT TOP 5
	ProductID,
	SUM(Quantity) AS total_orders
FROM Orders
GROUP BY ProductID
ORDER BY total_orders DESC