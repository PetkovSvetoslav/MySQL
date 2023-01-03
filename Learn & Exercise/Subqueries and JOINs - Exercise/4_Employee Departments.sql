USE soft_uni;

SELECT employee_id, first_name, salary, d.name AS "department_id" FROM employees e
JOIN departments d
ON e.department_id=d.department_id
WHERE salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;