CREATE DATABASE `restaurant_db`;
USE `restaurant_db`;

#1. Create
CREATE TABLE `products` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL UNIQUE,
    `type` VARCHAR(30) NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL
);

CREATE TABLE `clients` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `birthdate` DATE NOT NULL,
    `card` VARCHAR(50),
    `review` TEXT
);

CREATE TABLE `tables` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `floor` INT NOT NULL,
    `reserved` TINYINT(1),
    `capacity` INT NOT NULL
);

CREATE TABLE `waiters` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(50),
    `salary` DECIMAL(10, 2)
);

CREATE TABLE `orders` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `table_id` INT NOT NULL,
    CONSTRAINT `fk_table_id`
    FOREIGN KEY (`table_id`) 
    REFERENCES `tables`(`id`),
    `waiter_id` INT NOT NULL,
    CONSTRAINT `fk_waiter_id`
    FOREIGN KEY (`waiter_id`) 
    REFERENCES `waiters`(`id`),
    `order_time` TIME NOT NULL,
    `payed_status` TINYINT(1)
);

CREATE TABLE `orders_clients` (
	`order_id` INT,
    CONSTRAINT `fk_order_id`
    FOREIGN KEY (`order_id`) 
    REFERENCES `orders`(`id`),
    `client_id` INT,
    CONSTRAINT `fk_client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `clients`(`id`)
);

CREATE TABLE `orders_products` (
	`order_id` INT,
    CONSTRAINT `fk_orders_id`
    FOREIGN KEY (`order_id`) 
    REFERENCES `orders`(`id`),
    `product_id` INT,
    CONSTRAINT `fk_product_id`
    FOREIGN KEY (`product_id`) 
    REFERENCES `products`(`id`)
);

#2. Insert
INSERT INTO `products` (`name`, `type`, `price`)
	(SELECT 
    CONCAT(`w`.`last_name`, ' specialty'),
    'Cocktail',
    CEIL((`w`.`salary` * 0.01)) 
    FROM `waiters` AS `w`
    WHERE `w`.`id` > 6);

#3. Update
UPDATE `orders` AS `o`
SET `o`.`table_id` = (`o`.`table_id` - 1)
WHERE `o`.`id` >= 12 AND `o`.`id` <= 23;

#4. Delete
DELETE FROM `waiters` AS `w`
WHERE `w`.`id` NOT IN (SELECT `o`.`waiter_id` FROM `orders` AS `o`);

#5. Select
SELECT 
	`c`.`id`,
	`c`.`first_name`,
    `c`.`last_name`,
    `c`.`birthdate`,
    `c`.`card`,
    `c`.`review`
FROM `clients` AS `c`
ORDER BY `c`.`birthdate` DESC, `c`.`id` DESC;

#6. Select
SELECT 
	`c`.`first_name`,
    `c`.`last_name`,
    `c`.`birthdate`,
    `c`.`review`
FROM `clients` AS `c`
WHERE `c`.`card` IS NULL AND YEAR(`c`.`birthdate`) >= 1978 
AND YEAR(`c`.`birthdate`) <= 1993
ORDER BY `c`.`last_name` DESC, `c`.`id`
LIMIT 5;

#7. Select
SELECT 
CONCAT(`w`.`last_name`, `w`.`first_name`, CHARACTER_LENGTH(`w`.`first_name`), 'Restaurant') AS 'username',
REVERSE(SUBSTRING(`w`.`email`, 2, 12)) AS 'password'
FROM `waiters` AS `w`
WHERE `w`.`salary` IS NOT NULL
GROUP BY `w`.`id`
ORDER BY password DESC;

#8. Select
SELECT 
	`p`.`id`,
    `p`.`name`,
    COUNT(*) AS 'count'
FROM `products` AS `p`
JOIN `orders_products` AS `op` ON `p`.`id` = `op`.`product_id`
GROUP BY `p`.`id`
HAVING count >= 5
ORDER BY count DESC, `p`.`name`;

#9. Select
SELECT 
	`t`.`id` AS 'table_id',
    `t`.`capacity`,
    COUNT(`oc`.`client_id`) AS 'count_clients',
    IF (COUNT(`oc`.`client_id`) = `t`.`capacity`, 'Full', 
    IF (COUNT(`oc`.`client_id`) < `t`.`capacity`, 'Free seats', 'Extra seats')) AS 'availability'
FROM `tables` AS `t`
JOIN `orders` AS `o` ON `t`.`id` = `o`.`table_id`
JOIN `orders_clients` AS `oc` ON `o`.`id` = `oc`.`order_id`
WHERE `t`.`floor` = 1
GROUP BY `t`.`id`
ORDER BY `t`.`id` DESC;

#10. Function

DELIMITER $$

DROP FUNCTION udf_client_bill;

CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN
DECLARE result DECIMAL(19,2);
DECLARE c_id INT;
SET c_id := (SELECT
	`c`.`id`
    FROM `clients` AS `c`
    WHERE CONCAT(`c`.`first_name`, ' ', `c`.`last_name`) LIKE full_name
);
SET result := (SELECT
    SUM(`p`.`price`)
FROM 
	`products` AS `p` 
JOIN 
	`orders_products` AS `op` ON `p`.`id` = `op`.`product_id`
JOIN 
	`orders_clients` AS `oc` ON `op`.`order_id` = `oc`.`order_id`
WHERE 
	 `oc`.`client_id` = c_id);
RETURN result;
END $$

SELECT udf_client_bill('Silvio Blyth');

#11. Procedure
DELIMITER $$

DROP PROCEDURE udp_happy_hour;

CREATE PROCEDURE udp_happy_hour(type VARCHAR(50))
BEGIN
	UPDATE `products` AS `p`
    SET `p`.`price` = (`p`.`price` - (`p`.`price` * 0.20))
    WHERE
		`p`.`type` LIKE type
	AND
		`p`.`price` >= 10.00;
END $$

CALL udp_happy_hour('Cognac');