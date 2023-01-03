USE car_rental;

CREATE TABLE `categories`(
id INT AUTO_INCREMENT PRIMARY KEY,
category VARCHAR(50) NOT NULL,
daily_rate DOUBLE(10,2),
weekly_rate DOUBLE(10,2),
monthly_rate DOUBLE(10,2),
weekend_rate DOUBLE(10,2)
);

CREATE TABLE `cars`(
id INT AUTO_INCREMENT PRIMARY KEY,
plate_number VARCHAR(10), 
make VARCHAR(50),
model VARCHAR(50),
car_year DATE,
category_id INT,
doors INT,
picture BLOB,
car_condition VARCHAR(20),
available BOOLEAN NOT NULL
);


CREATE TABLE `employees`(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50),
title VARCHAR(50),
notes TEXT
);


CREATE TABLE `customers`(
id INT PRIMARY KEY AUTO_INCREMENT,
driver_licence INT NOT NULL,
number INT,
full_name VARCHAR(50),
address VARCHAR(50),
city VARCHAR(20),
zip_code INT,
notes TEXT
);

CREATE TABLE `rental_orders`(
id INT PRIMARY KEY AUTO_INCREMENT,
employee_id INT NOT NULL,
customer_id INT NOT NULL,
car_id INT NOT NULL,
car_condition VARCHAR(20),
tank_level DOUBLE(10,2),
kilometrage_start DOUBLE(10,2), 
kilometrage_end DOUBLE(10,2),
total_kilometrage DOUBLE(10,2), 
start_date DATE,
end_date DATE,
total_days INT,
rate_applied DOUBLE(10,2),
tax_rate DOUBLE(10,2),
order_status VARCHAR(10),
notes TEXT
);

INSERT INTO `categories` (`category`)
VALUES
("leka"),
("van"),
("pikap");

INSERT INTO `cars` (`available`)
VALUES
(TRUE),
(FALSE),
(TRUE);

INSERT INTO `employees` (`first_name`)
VALUES
("Marto"),
("Pesho"),
("Tosho");

INSERT INTO `customers` (`driver_licence`)
VALUES
("124123"),
("53453"),
("23523423");

INSERT INTO `rental_orders` (`employee_id`, `customer_id`, `car_id`)
VALUES
("32","5436", "43"),
("435","324", "23"),
("123","5364", "12");