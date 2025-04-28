--18.1 
CREATE PROCEDURE usp_empbonus
AS
BEGIN
	CREATE TABLE #EmployeeBonus (
		EmployeeID INT, 
		FullName VARCHAR(50), 
		Department VARCHAR(50), 
		Salary DECIMAL(10,2),
		BonusAmount DECIMAL (10,2)
	)
	INSERT INTO #EmployeeBonus
	SELECT
		e.EmployeeID,
		CONCAT(e.FirstName,' ', e.LastName) AS FullName,
		e.Department,
		e.Salary,
		d.BonusPercentage * e.Salary / 100 AS BonusAmount
	FROM Employees e
	JOIN DepartmentBonus d
	ON e.Department = d.Department

	SELECT * FROM #EmployeeBonus
END
EXEC usp_empbonus

--18.2 Accepts a department name and an increase percentage as parameters. Increases salary of all employees in the given department by the given percentage
--Returns updated employees from that department.
CREATE PROCEDURE usp_incresedepsal @DepartmentName VARCHAR(50), @IncreasePercentage DECIMAL (10,2)
AS
BEGIN
	UPDATE Employees
	SET Salary = Salary * (1 + @IncreasePercentage / 100)
	WHERE Department = @DepartmentName
	
	SELECT
		EmployeeID,
		CONCAT(FirstName, ' ', LastName) AS FullName,
		Department,
		Salary
	FROM Employees
	WHERE Department = @DepartmentName

END

EXEC usp_incresedepsal 'Sales', 12.00

--18.3 Perform a MERGE operation that: Updates ProductName and Price if ProductID matches, Inserts new products if ProductID does not exist
--Deletes products from Products_Current if they are missing in Products_New, Return the final state of Products_Current after the MERGE.
MERGE Products_Current AS TARGET
USING Products_New AS SOURCE
ON TARGET.ProductID = SOURCE.ProductID

WHEN MATCHED
THEN
	UPDATE
		SET TARGET.ProductName = SOURCE.ProductName,
			TARGET.Price = SOURCE.Price

WHEN NOT MATCHED BY TARGET
THEN
	INSERT(ProductID, ProductName, Price)
	VALUES(SOURCE.ProductID, SOURCE.ProductName, SOURCE.Price)

WHEN NOT MATCHED BY SOURCE
THEN 
	DELETE;

SELECT * FROM Products_Current

--18.4 
CREATE TABLE #TempTree (
	id INT,
	p_id INT,
	node_type VARCHAR(50)
)

MERGE #TempTree AS TARGET
USING (
		SELECT 
			id,
			p_id,
			CASE
				WHEN p_id IS NULL THEN 'Root'
				WHEN id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
				ELSE 'Leaf'
			END AS node_type
		FROM Tree
	) AS SOURCE
ON 1=0
WHEN NOT MATCHED
THEN
	INSERT (id, p_id, node_type)
	VALUES (SOURCE.id, SOURCE.p_id, SOURCE.node_type);

SELECT id, node_type AS type FROM #TempTree

--18.5 Find the confirmation rate for each user. If a user has no confirmation requests, the rate should be 0.
CREATE TABLE #ConfirmationRates (
    user_id INT,
    confirmation_rate DECIMAL(10,2)
)

MERGE #ConfirmationRates AS TARGET
USING (
		SELECT 
        s.user_id,
        COALESCE(
            (SELECT ROUND(
                COUNT(CASE WHEN action = 'confirmed' THEN 1 END) * 1.0 /
					NULLIF(COUNT(*), 0), 2)
				FROM Confirmations c 
				WHERE c.user_id = s.user_id),
			0.00) AS calculated_rate
		FROM Signups s
		) AS SOURCE
ON TARGET.user_id = SOURCE.user_id

WHEN MATCHED
THEN
	UPDATE SET TARGET.confirmation_rate = SOURCE.calculated_rate
WHEN NOT MATCHED
THEN
	INSERT (user_id, confirmation_rate)
	VALUES (SOURCE.user_id, SOURCE.calculated_rate);

SELECT * FROM #ConfirmationRates ORDER BY confirmation_rate

--18.6 Find employees with the lowest salary
SELECT id, name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees)

--18.7 Create a stored procedure called GetProductSalesSummary
select * from Products
select * from Sales 

CREATE PROCEDURE GetProductSalesSummary @ProductID INT
AS
BEGIN
	SELECT
		p.ProductName,
		SUM(s.Quantity) AS TotalQuantitySold,
		SUM(p.Price * s.Quantity) AS TotalSalesAmount,
		MIN(s.SaleDate) AS FirstSaleDate,
		MAX(s.SaleDate) AS LastSaleDate
	FROM
		Products p
	LEFT JOIN
		Sales s ON p.ProductID = s.ProductID
	WHERE 
		p.ProductID = @ProductID
	GROUP BY
		p.ProductName
END

EXEC dbo.GetProductSalesSummary 4