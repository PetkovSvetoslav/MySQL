USE `stc`;

SELECT a.`name`, (
	CASE
		WHEN HOUR(`start`) BETWEEN 6 AND 20 THEN 'Day'
		ELSE 'Night'
    END
    ) AS 'day_time', 
	`bill`, cl.`full_name`, `make`, `model`, cat.`name` AS 'category_name'
FROM `addresses` AS a
JOIN `courses` AS c ON a.`id` = c.`from_address_id`
JOIN `clients` AS cl ON cl.`id` = c.`client_id`
JOIN `cars` ON `cars`.`id` = c.`car_id`
JOIN `categories` AS cat ON cat.`id` = `cars`.`category_id`
ORDER BY c.`id`;