-- Subquery to find employees with above average salary
SELECT first_name, last_name, salary 
FROM employee_salary 
WHERE salary > (SELECT AVG(salary) FROM employee_salary);

-- Window function to calculate the running total of salaries
SELECT first_name, last_name, salary,
       SUM(salary) OVER (ORDER BY salary) AS running_total
FROM employee_salary;

-- Common Table Expression (CTE) to find the average salary by department
WITH AvgSalaryByDept AS (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employee_salary
    GROUP BY dept_id
)
SELECT e.first_name, e.last_name, e.salary, a.avg_salary
FROM employee_salary e
JOIN AvgSalaryByDept a ON e.dept_id = a.dept_id;

-- Stored Procedure to give a raise to employees in a specific department
DELIMITER //
CREATE PROCEDURE GiveRaise(IN dept INT, IN raise_amount DECIMAL(10,2))
BEGIN
    UPDATE employee_salary
    SET salary = salary + raise_amount
    WHERE dept_id = dept;
END //
DELIMITER ;

-- Trigger to log changes to employee salaries
CREATE TRIGGER LogSalaryChange
AFTER UPDATE ON employee_salary
FOR EACH ROW
BEGIN
    INSERT INTO salary_log (employee_id, old_salary, new_salary, change_date)
    VALUES (OLD.employee_id, OLD.salary, NEW.salary, NOW());
END;

-- Event to archive old employee records
CREATE EVENT ArchiveOldEmployees
ON SCHEDULE EVERY 1 YEAR
DO
BEGIN
    INSERT INTO employee_archive
    SELECT * FROM employee_demographics
    WHERE birth_date < DATE_SUB(NOW(), INTERVAL 60 YEAR);
    DELETE FROM employee_demographics
    WHERE birth_date < DATE_SUB(NOW(), INTERVAL 60 YEAR);
END;
