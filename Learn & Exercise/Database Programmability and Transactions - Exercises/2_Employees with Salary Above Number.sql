USE soft_uni;

DELIMITER $$

CREATE PROCEDURE usp_get_employees_salary_above(number_input DECIMAL(10,4))
BEGIN

SELECT `first_name`,`last_name` FROM `employees`
WHERE `salary`>=number_input
ORDER BY `first_name`,`last_name`,`employee_id`;

END$$