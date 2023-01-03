USE soft_uni;

SELECT employee_id, first_name, last_name , d.name AS "departmnet_name" FROM employees e
JOIN departments d
ON e.department_id=d.department_id
WHERE d.name= "Sales"
ORDER BY employee_id DESC;