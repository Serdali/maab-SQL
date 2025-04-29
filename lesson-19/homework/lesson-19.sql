--19.1 Retrieve employees who earn the minimum salary in the company. Tables: employees (columns: id, name, salary)
SELECT
	id,
	name,
	salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees)

--19.2 Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)
SELECT 
	id, product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products)

--19.3 Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. 
--Tables: employees (columns: id, name, department_id), departments (columns: id, department_name)
SELECT 
	e.name,
	d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.department_id = (SELECT d.id FROM departments d WHERE d.department_name = 'Sales')

--19.4 Retrieve customers who have not placed any orders. Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
SELECT 
	name
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders)

--19.5 Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
SELECT
	p.id,
	p.product_name,
	p.price,
	p.category_id
FROM products p
WHERE p.price = (SELECT MAX(price) FROM products WHERE category_id = p.category_id)

--19.6 Retrieve employees working in the department with the highest average salary. 
SELECT 
	e.name,
	d.department_name,
	e.salary
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.department_id = (SELECT TOP 1 department_id FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC)

--19.7 Retrieve employees earning more than the average salary in their department. Tables: employees (columns: id, name, salary, department_id)
SELECT 
	e.name,
	e.department_id,
	e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id)

--19.8 Retrieve students who received the highest grade in each course. Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
SELECT 
	s.name,
	g.course_id,
	g.grade
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.grade = (SELECT MAX(grade) FROM grades WHERE course_id = g.course_id)

--19.9 Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
;WITH cte AS(
SELECT *,
	DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS price_rank
FROM products
)
SELECT id, product_name, price, category_id FROM cte
WHERE price_rank = 3

--19.10 Retrieve employees with salaries above the company average but below the maximum in their department. 
SELECT
	e.name,
	e.department_id,
	e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees) AND e.salary < (SELECT MAX(salary) FROM employees WHERE department_id = e.department_id)
