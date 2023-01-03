USE soft_uni;

SELECT d.manager_id AS "employee_id",CONCAT_WS(" ",first_name,last_name) AS "full_name",d.department_id,d.name AS "department_name" FROM employees e
JOIN departments d
ON d.manager_id=e.employee_id
ORDER BY employee_id
LIMIT 5;