USE `stc`;

SELECT `full_name`, COUNT(`car_id`) AS 'count_of_cars', SUM(`bill`) AS 'total_sum'
FROM `clients` AS cl
JOIN `courses` AS c ON cl.`id` = c.`client_id`
WHERE `full_name` LIKE '_a%'
GROUP BY cl.`id`
HAVING `count_of_cars` > 1
ORDER BY `full_name`;