USE soft_uni;

SELECT e.`first_name`, e.`last_name`, e.`hire_date`, d.`name` AS "dept_name" FROM `employees` AS e
JOIN `departments` AS d
ON d.`department_id`=e.`department_id`
WHERE `hire_date` > "1999-01-01" AND (d.`name`= "Sales" OR d.`name` = "Finance" ) 
ORDER BY `hire_date`;