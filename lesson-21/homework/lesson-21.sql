--21.1 Write a query to assign a row number to each sale based on the SaleDate.
SELECT
	SaleID,
	ProductName,
	SaleAmount,
	Quantity,
	CustomerID,
	SaleDate,
	ROW_NUMBER() OVER(ORDER BY SaleDate) AS RowNum
FROM ProductSales

--21.2 Write a query to rank products based on the total quantity sold (use DENSE_RANK())
SELECT
	ProductName,
	SUM(Quantity) AS TotalQuantity,
	DENSE_RANK() OVER(ORDER BY SUM(Quantity) DESC) AS QuanRank
FROM ProductSales
GROUP BY ProductName 

--21.3 Write a query to identify the top sale for each customer based on the SaleAmount.
;WITH cte AS (
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS RN
FROM ProductSales
)
SELECT SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID
FROM cte
WHERE RN=1

--21.4 Write a query to display each sale's amount along with the next sale amount in the order of SaleDate using the LEAD() function
SELECT
	SaleID,
	ProductName,
	SaleDate,
	SaleAmount,
	LEAD(SaleAmount) OVER(ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales

--21.5 Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate using the LAG() function
SELECT
	SaleID,
	ProductName,
	SaleDate,
	SaleAmount,
	LAG(SaleAmount) OVER(ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales

--21.6 Write a query to rank each sale amount within each product category.
SELECT
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
	RANK() OVER(PARTITION BY ProductName ORDER BY SaleAmount DESC) AS ProdSalesRank
FROM ProductSales

--21.7 Write a query to identify sales amounts that are greater than the previous sale's amount
WITH cte AS(
SELECT
	SaleID,
	ProductName,
	SaleDate,
	SaleAmount,
	LAG(SaleAmount) OVER(ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales
)
SELECT * FROM cte
WHERE SaleAmount > PrevSaleAmount

--21.8 Write a query to calculate the difference in sale amount from the previous sale for every product
SELECT
	SaleID,
	ProductName,
	SaleDate,
	SaleAmount,
	ISNULL(LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate),0) AS PrevSaleAmount,
	SaleAmount - ISNULL(LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate),0) AS AmountDiff
FROM ProductSales

--21.9 Write a query to compare the current sale amount with the next sale amount in terms of percentage change.
SELECT
	SaleID,
	ProductName,
	SaleDate,
	SaleAmount,
	COALESCE(LEAD(SaleAmount) OVER(ORDER BY SaleDate),0) AS NextSaleAmount,
	ROUND((COALESCE(LEAD(SaleAmount) OVER(ORDER BY SaleDate),0)-SaleAmount)*100.00/SaleAmount, 2) AS PercentageChange
FROM ProductSales

--21.10 Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
	ISNULL(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate),0) AS PrevSaleAmount,
    ROUND(SaleAmount/ NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate),0), 2) AS AmountRatio
FROM ProductSales

--21.11 Write a query to calculate the difference in sale amount from the very first sale of that product.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DifferenceFromFirstSale
FROM ProductSales

--21.12 Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).
;WITH SalesWithValue AS (
    SELECT 
        *,
        SaleAmount * Quantity AS TotalValue,
        ROW_NUMBER() OVER (PARTITION BY ProductName ORDER BY SaleDate) AS rn
    FROM ProductSales
),
SalesWithPrevious AS (
    SELECT 
        curr.ProductName,
        curr.SaleDate,
        curr.TotalValue,
        LAG(curr.TotalValue) OVER (PARTITION BY curr.ProductName ORDER BY curr.rn) AS PrevTotalValue
    FROM SalesWithValue curr
)
SELECT *
FROM SalesWithPrevious
WHERE PrevTotalValue IS NOT NULL
  AND TotalValue > PrevTotalValue
ORDER BY ProductName, SaleDate;

--21.13 Write a query to calculate a "closing balance" for sales amounts which adds the current sale amount to a running total of previous sales.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM ProductSales

--21.14 Write a query to calculate the moving average of sales amounts over the last 3 sales.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    ROUND(AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS MovingAvgSales
FROM ProductSales

--21.15 Write a query to show the difference between each sale amount and the average sale amount.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
	AVG(SaleAmount) OVER() AvgSaleAmt,
    SaleAmount - AVG(SaleAmount) OVER() AS DiffFromAvg
FROM ProductSales

select * from Employees1
--21.16 Find Employees Who Have the Same Salary Rank
SELECT *
FROM Employees1
WHERE Salary IN (
    SELECT Salary
    FROM Employees1
    GROUP BY Salary
    HAVING COUNT(*) > 1
)
ORDER BY Salary, EmployeeID;

--21.17 Identify the Top 2 Highest Salaries in Each Department
WITH cte AS(
SELECT 
	EmployeeID,
	Name,
	Department,
	Salary,
	DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS SalRank
FROM Employees1
)
SELECT * FROM cte
WHERE SalRank <= 2

--21.18 Find the Lowest-Paid Employee in Each Department
;WITH cte AS(
SELECT 
	EmployeeID,
	Name,
	Department,
	Salary,
	DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary) AS SalRank
FROM Employees1
)
SELECT * FROM cte
WHERE SalRank = 1;

--21.19 Calculate the Running Total of Salaries in Each Department
SELECT 
	EmployeeID,
	Name,
	Department,
	Salary,
	SUM(Salary) OVER(PARTITION BY Department ORDER BY EmployeeID) AS RunningTotal
FROM Employees1

--21.20 Find the Total Salary of Each Department Without GROUP BY
SELECT DISTINCT
	Department,
	SUM(Salary) OVER(PARTITION BY Department) AS TotalSalary
FROM Employees1
ORDER BY Department

--21.21 Calculate the Average Salary in Each Department Without GROUP BY
SELECT DISTINCT
	Department,
	AVG(Salary) OVER(PARTITION BY Department) AS AvgSalary
FROM Employees1
ORDER BY Department

--21.22 Find the Difference Between an Employee’s Salary and Their Department’s Average
SELECT
	EmployeeID,
	Name,
	Department,
	Salary,
	Salary - AVG(Salary) OVER(PARTITION BY Department) AS DiffAvg
FROM Employees1

--21.23 Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
SELECT
	EmployeeID,
	Name,
	Salary,
	AVG(Salary) OVER(ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM Employees1

--21.24 Find the Sum of Salaries for the Last 3 Hired Employees
WITH RankedEmployees AS (
    SELECT Salary,
           ROW_NUMBER() OVER (ORDER BY HireDate DESC) AS rn
    FROM Employees1
)
SELECT SUM(Salary) AS TotalSalary
FROM RankedEmployees
WHERE rn <= 3;