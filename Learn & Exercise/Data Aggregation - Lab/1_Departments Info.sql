USE restaurant;

SELECT `department_id`, COUNT(`id`) AS "Number of Employees" FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;