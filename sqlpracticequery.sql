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


