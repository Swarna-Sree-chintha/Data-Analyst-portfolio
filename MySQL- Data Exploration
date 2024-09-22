-- Select basic employee details
SELECT employee_id, first_name, last_name, gender, hire_date
FROM employee_demographics;

-- Where clause to filter employees hired after 2020
SELECT employee_id, first_name, hire_date
FROM employee_demographics
WHERE hire_date > '2020-01-01';

-- Group by department and get the average salary, ordered by average salary
SELECT department_id, AVG(salary) AS avg_salary
FROM employee_salary
GROUP BY department_id
ORDER BY avg_salary DESC;

-- Using HAVING to filter groups where the average salary is greater than 50,000
SELECT department_id, AVG(salary) AS avg_salary
FROM employee_salary
GROUP BY department_id
HAVING avg_salary > 50000;

-- Limit and aliasing: Get top 5 departments with highest average salary
SELECT department_id AS dept, AVG(salary) AS avg_salary
FROM employee_salary
GROUP BY department_id
ORDER BY avg_salary DESC
LIMIT 5;

-- Inner Join between demographics and salary to get full details
SELECT ed.employee_id, ed.first_name, ed.last_name, es.salary
FROM employee_demographics ed
JOIN employee_salary es ON ed.employee_id = es.employee_id;

-- String function example: Concatenate first and last name as full name
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;

-- Using CASE statement to categorize salary ranges
SELECT employee_id, salary,
  CASE
    WHEN salary < 40000 THEN 'Low'
    WHEN salary BETWEEN 40000 AND 80000 THEN 'Medium'
    ELSE 'High'
  END AS salary_category
FROM employee_salary;
