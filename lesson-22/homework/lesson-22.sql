--22.1 Compute Running Total Sales per Customer
SELECT
	customer_id,
	customer_name,
	order_date,
	total_amount,
	SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data

--22.2 Count the Number of Orders per Product Category
SELECT DISTINCT
	product_category,
	COUNT(*) OVER(PARTITION BY product_category) AS order_count
FROM sales_data

--22.3 Find the Maximum Total Amount per Product Category
SELECT DISTINCT
	product_category,
	MAX(total_amount) OVER(PARTITION BY product_category) AS max_total_amount
FROM sales_data

--22.4 Find the Minimum Price of Products per Product Category
SELECT DISTINCT
	product_category,
	MIN(total_amount) OVER(PARTITION BY product_category) AS min_total_amount
FROM sales_data

--22.5 Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
SELECT
	order_date,
	total_amount,
	AVG(total_amount) OVER(ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
FROM sales_data

--22.6 Find the Total Sales per Region
SELECT DISTINCT
	region,
	SUM(total_amount) OVER(PARTITION BY region) AS total_sales
FROM sales_data

--22.7 Compute the Rank of Customers Based on Their Total Purchase Amount
SELECT
	customer_id,
	customer_name,
	SUM(total_amount) AS total_sales,
	RANK() OVER(ORDER BY SUM(total_amount) DESC) AS purchase_rank
FROM sales_data
GROUP BY customer_id, customer_name

--22.8 Calculate the Difference Between Current and Previous Sale Amount per Customer
SELECT
	customer_id,
	customer_name,
	order_date,
	total_amount AS current_sales,
	ISNULL(LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date),0) prev_sales,
	total_amount - ISNULL(LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date),0) AS amount_difference
FROM sales_data

--22.9 Find the Top 3 Most Expensive Products in Each Category
SELECT * 
FROM (
	SELECT 
		product_category,
        product_name,
        unit_price,
		RANK() OVER(PARTITION BY product_category ORDER BY unit_price DESC) AS prod_rank
	FROM sales_data
) ranked_product
WHERE prod_rank <= 3

--22.10 Compute the Cumulative Sum of Sales Per Region by Order Date
SELECT
	region,
	order_date,
	total_amount,
	SUM(total_amount) OVER(PARTITION BY region ORDER BY order_date) AS cum_sales
FROM sales_data

--22.11 Compute Cumulative Revenue per Product Category
SELECT
	product_category,
	order_date,
	total_amount,
	SUM(total_amount) OVER(PARTITION BY product_category ORDER BY order_date) AS cum_sales
FROM sales_data

--22.12 Here you need to find out the sum of previous values.
SELECT 
	ID,
	SUM(ID) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumPreValues
FROM Num

--22.13 Sum of Previous Values to Current Value
SELECT
	Value,
	SUM(Value) OVER(ORDER BY Value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS SumofPrevious
FROM OneColumn

--22.14 Generate row numbers for the given data. The condition is that the first row number for every partition should be odd number.
;WITH cte1 AS(
SELECT
	id,
	Vals,
	ROW_NUMBER() OVER(ORDER BY ID, Vals) AS RN 
FROM Row_Nums
),
cte2 AS (
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY RN) AS id_row,
		ROW_NUMBER() OVER(ORDER BY id) AS id_group
	FROM cte1
),
cte3 AS (
    SELECT *,    
           2 * (id_group - 1) + id_row AS RowNumber
    FROM cte2
)
SELECT Id, Vals, RowNumber
FROM cte3
ORDER BY RowNumber;

--22.15 Find customers who have purchased items from more than one product_category
SELECT DISTINCT customer_id, customer_name 
FROM (SELECT 
		customer_id,
		customer_name,
		COUNT(product_category) OVER(PARTITION BY customer_id) AS rn
	FROM sales_data) AS t
WHERE rn>1

--22.16 Find Customers with Above-Average Spending in Their Region
SELECT DISTINCT customer_id, customer_name, region, customer_total, region_avg
FROM (
	SELECT customer_id, customer_name, region,
		SUM(total_amount) OVER(PARTITION BY customer_id) AS customer_total,
		AVG(total_amount) OVER(PARTITION BY region) AS region_avg
	FROM sales_data
) AS t
WHERE customer_total>region_avg

--22.17 Rank customers based on their total spending (total_amount) within each region. 
--If multiple customers have the same spending, they should receive the same rank (dense ranking).
SELECT DISTINCT customer_id, customer_name, region, customer_total,
	DENSE_RANK() OVER(PARTITION BY region ORDER BY customer_total DESC) AS rank
FROM (
	SELECT customer_id, customer_name, region,
		SUM(total_amount) OVER(PARTITION BY customer_id) AS customer_total
	FROM sales_data
) AS t

--22.18 Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date.
SELECT 
	customer_id,
	customer_name,
	order_date,
	total_amount,
	SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS cumm_sales
FROM sales_data

--22.19 Calculate the sales growth rate (growth_rate) for each month compared to the previous month.
;WITH monthly_sales AS (
    SELECT month(order_date) AS month,
           SUM(total_amount) AS total_sales
    FROM sales_data
    GROUP BY month(order_date)
)
SELECT month, total_sales,
       ROUND((total_sales - LAG(total_sales) OVER (ORDER BY month)) / 
             NULLIF(LAG(total_sales) OVER (ORDER BY month), 0) * 100, 2) AS growth_rate
FROM monthly_sales

--22.20 Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data)
SELECT 
	customer_id,
	customer_name,
	total_amount,
	previous_amount
FROM (
    SELECT *,
           LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_amount
    FROM sales_data
) AS sub
WHERE total_amount > previous_amount

--22.21 Identify Products that prices are above the average product price
SELECT DISTINCT product_name, unit_price, avg_price
FROM (
    SELECT product_name, unit_price,
           AVG(unit_price) OVER () AS avg_price
    FROM sales_data
) AS t
WHERE unit_price > avg_price

--22.22 In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column. 
--The challenge here is to do this in a single select.
SELECT 
    Id, 
    Grp, 
    Val1, 
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL 
    END AS Tot
FROM MyData;

--22.23	Here you have to sum up the value of the cost column based on the values of Id. For Quantity if values are different then we have to add those values.
SELECT 
    Id,
    SUM(Cost) AS Cost,
    SUM(Quantity) AS Quantity
FROM (
    SELECT DISTINCT Id, Cost, Quantity
    FROM TheSumPuzzle
) AS distinct_rows
GROUP BY Id;

--22.24
WITH base AS (
    SELECT *,
        SUM(CASE WHEN Result = 'Z' THEN 1 ELSE 0 END) 
            OVER (ORDER BY Level, TyZe ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
        AS z_group
    FROM testSuXVI
),
agg AS (
    SELECT *,
        SUM(CASE WHEN Result = 'X' THEN TyZe ELSE 0 END)
            OVER (PARTITION BY z_group ORDER BY Level, TyZe 
                  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS x_sum_in_group
    FROM base
)
SELECT 
    Level, 
    TyZe, 
    Result,
    CASE 
        WHEN Result = 'Z' THEN x_sum_in_group + TyZe
        ELSE 0 
    END AS Results
FROM agg
ORDER BY Level, TyZe;

