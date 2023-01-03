USE soft_uni;

SELECT e.`employee_id`,e.`first_name`,e.`manager_id`,a.`first_name` AS "manager_name" FROM `employees` AS e
JOIN `employees` AS a ON a.`employee_id`=e.`manager_id`
WHERE e.`manager_id` IN (3,7)
ORDER BY e.`first_name`;
