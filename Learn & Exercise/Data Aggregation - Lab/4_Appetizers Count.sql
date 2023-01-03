USE `restaurant`;

SELECT COUNT(`id`) AS "Count of Appetizers" FROM `products`
WHERE `price`>8
GROUP BY `category_id`
HAVING `category_id` = 2;