CREATE DATABASE erp;
USE erp;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES
(101,'IT'),
(102,'HR'),
(103,'Finance');

INSERT INTO employees VALUES
(1,'Rahul',50000,101),
(2,'Amit',40000,102),
(3,'Priya',60000,101),
(4,'Neha',55000,103),
(5,'Arjun',45000,102),
(6,'Sneha',70000,101),
(7,'Rohit',48000,103),
(8,'Karan',52000,101),
(9,'Pooja',43000,102),
(10,'Vikas',65000,103),
(11,'Anjali',58000,101),
(12,'Deepak',39000,102),
(13,'Meera',62000,103),
(14,'Nitin',47000,101),
(15,'Riya',54000,102),
(16,'Suresh',72000,103),
(17,'Kavita',51000,101),
(18,'Manoj',44000,102),
(19,'Aisha',68000,103),
(20,'Varun',49000,101);

SELECT * FROM employees;

SELECT * FROM departments;

SELECT emp_name FROM employees;

SELECT * FROM employees
WHERE salary > 50000;

SELECT * FROM employees
WHERE dept_id = 101;

SELECT * FROM employees
ORDER BY salary DESC;

SELECT * FROM employees
ORDER BY salary DESC
LIMIT 5;

SELECT COUNT(*) AS TotalEmployees
FROM employees;

SELECT AVG(salary) AS AverageSalary
FROM employees;

SELECT MAX(salary) AS HighestSalary
FROM employees;

SELECT MIN(salary) AS LowestSalary
FROM employees;

SELECT SUM(salary) AS TotalSalary
FROM employees;

ALTER TABLE employees
ADD email VARCHAR(100);

UPDATE employees
SET salary = 60000,
    dept_id = 103
WHERE emp_id = 5;

ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE(email);

ALTER TABLE employees
DROP COLUMN email;

 SELECT *
FROM employees
WHERE emp_name LIKE '%a'; 

SELECT *
FROM employees
WHERE emp_name LIKE 'A%';

SELECT *
FROM employees
WHERE emp_name LIKE '_____';

SELECT *
FROM employees
WHERE emp_name LIKE 'P%a';

use erp;
SELECT dept_id,
       COUNT(*) AS EmployeeCount
FROM employees
GROUP BY dept_id;

SELECT dept_id,
       AVG(salary) AS AvgSalary
FROM employees
GROUP BY dept_id;

SELECT dept_id,
       SUM(salary) AS TotalSalary
FROM employees
GROUP BY dept_id;

SELECT dept_id,
       AVG(salary) AS AvgSalary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 55000;

SELECT dept_id,
       SUM(salary) AS TotalSalary
FROM employees
GROUP BY dept_id
HAVING SUM(salary) > 300000;

SELECT d.dept_name,
       COUNT(*) AS EmployeeCount
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;


SELECT d.dept_name,
       AVG(e.salary) AS AvgSalary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

SELECT d.dept_name,
       AVG(e.salary) AS AvgSalary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

SELECT d.dept_name,
       MAX(e.salary) AS HighestSalary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

SELECT MAX(salary) AS SecondHighestSalary
FROM employees
WHERE salary <
(
    SELECT MAX(salary)
    FROM employees
);

SELECT MAX(salary) - MIN(salary) AS SalaryDifference
FROM employees;
SELECT e.emp_id,
       e.emp_name,
       e.salary,
       d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;

SELECT e.emp_name,
       d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';

SELECT e.emp_name,
       d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_name = 'HR';

SELECT e.emp_name,
       e.salary,
       d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.salary > 60000;

SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);

SELECT *
FROM employees
WHERE salary =
(
    SELECT MAX(salary)
    FROM employees
);

SELECT MAX(salary) AS SecondHighestSalary
FROM employees
WHERE salary <
(
    SELECT MAX(salary)
    FROM employees
);

SELECT *
FROM employees e
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
    WHERE dept_id = e.dept_id
);

SELECT e.emp_name,
       e.salary,
       d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.salary =
(
    SELECT MAX(salary)
    FROM employees
);

SELECT e.emp_name,
       e.salary,
       d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE (e.dept_id, e.salary) IN
(
    SELECT dept_id,
           MAX(salary)
    FROM employees
    GROUP BY dept_id
);

SELECT emp_name
FROM employees
WHERE dept_id = 101

UNION

SELECT emp_name
FROM employees
WHERE salary > 60000;

SELECT emp_name
FROM employees
WHERE dept_id = 101

UNION ALL

SELECT emp_name
FROM employees
WHERE salary > 60000;

SELECT *
FROM employees
WHERE dept_id = 101
AND salary > 60000;

SELECT e.*
FROM employees e
INNER JOIN
(
    SELECT emp_id
    FROM employees
    WHERE dept_id = 101
) a
ON e.emp_id = a.emp_id
INNER JOIN
(
    SELECT emp_id
    FROM employees
    WHERE salary > 60000
) b
ON e.emp_id = b.emp_id;

SELECT emp_name, dept_id
FROM employees
WHERE dept_id = 101

UNION

SELECT emp_name, dept_id
FROM employees
WHERE dept_id = 102;

CREATE VIEW employee_details AS
SELECT e.emp_id,
       e.emp_name,
       e.salary,
       d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;

SELECT * FROM employee_details;

DROP VIEW employee_details;

CREATE INDEX idx_salary
ON employees(salary);

SHOW INDEX FROM employees;

DROP INDEX idx_salary
ON employees;

DELIMITER //

CREATE PROCEDURE ShowEmployees()
BEGIN
    SELECT * FROM employees;
END //

DELIMITER ;

CALL ShowEmployees();

CREATE TABLE employee_log(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50),
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_log(emp_name)
    VALUES(NEW.emp_name);
END //

DELIMITER ;

SELECT emp_name,
       salary,
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS RowNum
FROM employees;

SELECT emp_name,
       salary,
       DENSE_RANK() OVER(ORDER BY salary DESC) AS DenseRank
FROM employees;

SELECT emp_name,
       salary,
       CASE
           WHEN salary >= 60000 THEN 'High'
           WHEN salary >= 50000 THEN 'Medium'
           ELSE 'Low'
       END AS SalaryCategory
FROM employees;

SELECT *
FROM departments d
WHERE EXISTS
(
    SELECT *
    FROM employees e
    WHERE e.dept_id = d.dept_id
);

START TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE emp_id = 1;

COMMIT;

ROLLBACK;