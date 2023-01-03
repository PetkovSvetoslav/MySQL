USE `stc`;

DROP PROCEDURE IF EXISTS `udp_courses_by_address`;

DELIMITER $$
CREATE PROCEDURE `udp_courses_by_address`(address_name VARCHAR(20))
BEGIN
	SELECT a.`name`, cl.`full_name`, (
		CASE
			WHEN `bill` <= 20 THEN 'Low'
            WHEN `bill`  <= 30 THEN 'Medium'
            ELSE 'High'
		END) AS 'level_of_bill',
		`make`, `condition`, cat.`name` AS 'cat_name'
    FROM `addresses` AS a
    JOIN `courses` AS c ON a.`id` = c.`from_address_id`
    JOIN `clients` AS cl ON cl.`id` = c.`client_id`
    JOIN `cars` ON `cars`.`id` = c.`car_id`
    JOIN `categories` AS cat ON cat.`id` = `cars`.`category_id`
    WHERE address_name = a.`name`
    ORDER BY `make`, cl.`full_name`;
END$$
DELIMITER ;

CALL udp_courses_by_address('700 Monterey Avenue');