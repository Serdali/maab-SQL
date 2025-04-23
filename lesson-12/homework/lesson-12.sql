--12.1 Write a solution to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.
SELECT 
	p.firstName,
	p.lastName,
	ISNULL (a.city,'NULL') AS city,
	ISNULL (a.state,'NULL') AS state
FROM Person p
LEFT JOIN Address a
ON p.personId = a.personId

--12.2 Write a solution to find the employees who earn more than their managers.
SELECT 
	e.name AS Employee
FROM Employee e
JOIN Employee m
ON e.managerId = m.id
WHERE e.salary > m.salary

--12.3 Write a solution to report all the duplicate emails. Note that it''s guaranteed that the email field is not NULL.
SELECT email 
FROM Person
GROUP BY email
HAVING COUNT(email) > 1

--12.4 Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
)
SELECT * FROM Person

--12.5 Find those parents who has only girls.
SELECT ParentName FROM girls
EXCEPT
SELECT ParentName FROM boys

--12.6 Find total Sales amount for the orders which weights more than 50 for each customer along with their least weight. (from TSQL2012 database, Sales.Orders Table)
SELECT 
	custid,
	SUM(CASE WHEN freight > 50 THEN freight ELSE 0 END) AS Total_sales,
	MIN(freight) AS least_weight
FROM TSQL2012.Sales.Orders
GROUP BY custid

--12.7 You have the tables below, write a query to get the expected output
Expected Output.
-----------------------------
| Item Cart 1 | Item Cart 2 |  
|-------------|-------------|  
| Sugar       | Sugar       |  
| Bread       | Bread       |  
| Juice       |             |  
| Soda        |             |  
| Flour       |             |  
|             | Butter      |  
|             | Cheese      |  
|             | Fruit       |  
-----------------------------
SELECT 
	COALESCE(c1.Item, '') AS 'Item Cart 1',
	COALESCE(c2.Item, '') AS 'Item Cart 2'
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2
ON c1.Item = c2.Item
ORDER BY
	CASE
		WHEN c1.Item IS NOT NULL AND c2.Item IS NOT NULL THEN 0
		WHEN c1.Item IS NULL THEN 1
		ELSE 2
	END,
COALESCE(c1.Item,c2.Item)

--12.8 Resultga yutgan jamoaning nomi chiqsin agar durrang bo''lsa 'Draw' so''zi chiqsin. (Hisob 10:11 yoki 111:99 bo''lishi ham mumkin :) )
SELECT *,
	CASE WHEN LEFT(Score,CHARINDEX(':',Score)-1) > RIGHT(Score, LEN(Score)-CHARINDEX(':',Score)) THEN LEFT(Match,CHARINDEX('-',Match)-1)
		 WHEN LEFT(Score,CHARINDEX(':',Score)-1) < RIGHT(Score, LEN(Score)-CHARINDEX(':',Score)) THEN RIGHT(Match,LEN(Match)-CHARINDEX('-',Match))
		 ELSE 'Draw'
		 END AS Result
FROM match1

--12.9 Write a solution to find all customers who never order anything.
SELECT 
	c.name AS Customers 
FROM Customers c
LEFT JOIN Orders o
ON c.id = o.customerId
WHERE o.customerId IS NULL

--12.10 Write a solution to find the number of times each student attended each exam.
SELECT 
	s.student_id,
	s.student_name,
	sub.subject_name,
	COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN
	Subjects sub
LEFT JOIN
	Examinations e
ON 
	s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY 
	s.student_id, s.student_name, sub.subject_name
ORDER BY
	s.student_id, sub.subject_name