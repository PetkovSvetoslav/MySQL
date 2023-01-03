USE soft_uni;

SELECT e.employee_id, CONCAT(e.first_name," ",e.last_name) AS "employee_name", CONCAT(a.first_name, " ", a.last_name) AS "manager_name" , d.name AS "department_name" FROM employees AS e
JOIN employees AS a ON a.employee_id=e.manager_id
JOIN departments AS d ON e.department_id=d.department_id
ORDER BY e.employee_id
LIMIT 5;