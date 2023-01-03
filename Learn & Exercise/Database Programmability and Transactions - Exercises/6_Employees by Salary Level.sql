USE soft_uni;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary(salary_parameter VARCHAR(10))
BEGIN

SELECT `first_name`,`last_name` FROM `employees` AS e
WHERE ufn_get_salary_level(e.`salary`) = salary_parameter
ORDER BY first_name DESC,last_name DESC;

END