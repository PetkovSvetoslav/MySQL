USE soft_uni;

DELIMITER $$

CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(20))
BEGIN

UPDATE `employees` AS e
JOIN `departments` AS d
SET `salary`=`salary`*1.05
WHERE d.`name`= department_name;

END$$

