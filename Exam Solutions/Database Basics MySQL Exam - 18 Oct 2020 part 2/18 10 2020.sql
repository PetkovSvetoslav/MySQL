CREATE SCHEMA `exam_18_10_2020`;
USE `exam_18_10_2020`;

#01. Table Design

CREATE TABLE `pictures`(
id INT PRIMARY KEY AUTO_INCREMENT,
url VARCHAR(100) NOT NULL, 
added_on DATETIME NOT NULL 
);

CREATE TABLE categories(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE towns(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE products(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE,
best_before DATE NOT NULL,
price DECIMAL(10,2) NOT NULL,
`description` TEXT,
picture_id INT NOT NULL,
CONSTRAINT fk_products_pictures
FOREIGN KEY (`picture_id`)
REFERENCES pictures(`id`),
category_id INT NOT NULL,
CONSTRAINT fk_products_categories
FOREIGN KEY (`category_id`)
REFERENCES categories(`id`)
);

CREATE TABLE addresses(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL UNIQUE,
town_id INT NOT NULL,
CONSTRAINT fk_addresses_towns
FOREIGN KEY (`town_id`)
REFERENCES towns(`id`)
-- discount_card BIT NOT NULL DEFAULT FALSE
);

CREATE TABLE `stores`(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
rating FLOAT NOT NULL,
has_parking TINYINT(1) DEFAULT FALSE,
address_id INT NOT NULL,
CONSTRAINT fk_stores_addresses
FOREIGN KEY (`address_id`)
REFERENCES addresses(`id`)
);
CREATE TABLE `products_stores`(
product_id INT NOT NULL ,
store_id INT NOT NULL,
PRIMARY KEY pk_products_stores(`product_id`,`store_id`),
CONSTRAINT fk_products_stores_products
FOREIGN KEY (`product_id`)
REFERENCES products(`id`),
CONSTRAINT fk_products_stores_stors
FOREIGN KEY (`store_id`)
REFERENCES stores(`id`) 
);

CREATE TABLE `employees`(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(15) NOT NULL,
middle_name CHAR(1),
last_name VARCHAR(20) NOT NULL,
salary DECIMAL(19,2) NOT NULL DEFAULT 0,
hire_date DATE NOT NULL,
store_id INT,
CONSTRAINT fk_employees_stors
FOREIGN KEY (`store_id`)
REFERENCES stores(`id`),
manager_id INT,
CONSTRAINT fk_employees_employees
FOREIGN KEY (`manager_id`)
REFERENCES employees(`id`)
);

#02. Insert
INSERT INTO products_stores( 
-- (SELECT products.id, 1 FROM products LEFT JOIN products_stores
-- ON products.id = products_stores.product_id WHERE products_stores.product_id IS NULL)
 SELECT p.id, 1 FROM products AS p WHERE p.id NOT IN(SELECT product_id FROM products_stores)
 );
 
#03. Update
UPDATE employees AS e
SET e.salary = e.salary - 500, e.manager_id = 3
WHERE year(e.hire_date) >= 2003 
AND e.store_id NOT IN 
(SELECT s.id FROM stores AS s WHERE s.name = 'Cardguard' OR s.name = 'Veribet' );

#04. Delete
DELETE FROM employees
WHERE salary >= 6000 AND manager_id IS NOT NULL;

#05. Employees
SELECT e.first_name , e.middle_name, e.last_name, e.salary, e.hire_date
FROM  employees AS e
ORDER BY e.hire_date DESC;

#06. Products with old pictures
SELECT p.name as product_name, p.price as price, p.best_before as best_before,
 concat(substr(p.description, 1, 10), '...' ) as short_description, url 
FROM products as p 
JOIN pictures AS ps ON p.picture_id = ps.id 
WHERE p.price > 20 AND year(ps.added_on) < 2019
AND length(p.description) > 100
ORDER BY p.price DESC;

#07. Counts of products in stores
SELECT s.name, count(p.id) as product_count, ROUND(avg(p.price),2) AS `avg`
FROM stores AS s
LEFT OUTER JOIN products_stores AS ps ON s.id = ps.store_id
LEFT OUTER JOIN products AS p ON ps.product_id = p.id 
GROUP BY s.id
ORDER BY product_count DESC, `avg` DESC, s.id;

#08. Specific employee
SELECT concat(e.first_name, ' ', e.last_name) AS Full_name,
s.name AS Store_name, a.name AS address, e.salary AS salary
 FROM employees AS e
JOIN stores AS s ON e.store_id = s.id
JOIN addresses AS a ON s.address_id = a.id
WHERE e.salary < 4000 
AND a.name LIKE '%5%' 
AND length(s.name) > 8
AND e.last_name LIKE '%n';

#09. Find all information of stores
SELECT reverse(s.name) AS reversed_name, 
concat(upper(t.name), '-', a.name) AS full_address,
 (SELECT count(e.id) FROM employees AS e WHERE e.store_id = s.id) AS employees_count
 FROM stores AS s
JOIN addresses AS a ON s.address_id = a.id
JOIN towns AS t ON t.id = a.town_id
WHERE (SELECT count(e.id) FROM employees AS e WHERE e.store_id = s.id) > 0
ORDER BY full_address;

#09. Find all information of stores
SELECT reverse(s.name) AS reversed_name, 
concat(upper(t.name), '-', a.name) AS full_address,
 count(e.id)  AS employees_count
 FROM stores AS s
JOIN addresses AS a ON s.address_id = a.id
JOIN towns AS t ON t.id = a.town_id
JOIN employees AS e ON e.store_id = s.id
GROUP BY s.id
HAVING employees_count > 0
ORDER BY full_address;

#10. Find name of top paid employee by store name
delimiter $$
CREATE FUNCTION udf_top_paid_employee_by_store(store_name VARCHAR(50))
RETURNS VARCHAR(100)
BEGIN
-- DECLARE result VARCHAR(100)
RETURN
( SELECT 
concat(e.first_name, ' ', e.middle_name, '. ',e.last_name, ' works in store for ',
 2020 - year(hire_date) , ' years')
 AS full_info 
 FROM employees AS e
JOIN stores AS s ON e.store_id = s.id
WHERE s.name = store_name
ORDER BY e.salary DESC LIMIT 1
) ;
END;$$

#11. Update product price by address
delimiter $$
CREATE PROCEDURE udp_update_product_price (address_name VARCHAR (50))
BEGIN
DECLARE increase_level INT;
IF address_name LIKE '0%' THEN SET increase_level = 100;
ELSE SET increase_level = 200;
END IF;
UPDATE products AS p SET price = price + increase_level
WHERE p.id IN (
SELECT ps.product_id FROM addresses AS a
JOIN stores AS s ON a.id = s.address_id
JOIN products_stores AS ps ON ps.store_id = s.id
WHERE a.name = address_name
);
END;$$
















