USE `stc`;

SELECT c.`id` AS 'car_id', c.`make`, c.`mileage`,
	COUNT(`car_id`) AS 'count_of_courses', ROUND(AVG(`bill`), 2) AS 'avg_bill'
FROM `cars` AS c
LEFT JOIN `courses` ON c.`id` = `car_id`
GROUP BY c.`id`
HAVING `count_of_courses` != 2
ORDER BY `count_of_courses` DESC, c.`id`;