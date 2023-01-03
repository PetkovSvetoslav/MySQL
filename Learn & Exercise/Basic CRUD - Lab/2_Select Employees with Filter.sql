USE hotel;

SELECT `id`, CONCAT(`first_name`," ",`last_name`) AS "Full Name",`job_title`,`salary` FROM `employees`
WHERE `salary`> 1000.00
ORDER BY `id`;