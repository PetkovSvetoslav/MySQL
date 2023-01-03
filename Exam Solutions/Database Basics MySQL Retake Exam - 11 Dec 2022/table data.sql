CREATE DATABASE `EXAM_db`;
USE `EXAM_db`;
CREATE TABLE `countries`
(
    `id`        INT PRIMARY KEY AUTO_INCREMENT,
    `name`      VARCHAR(30) NOT NULL UNIQUE ,
    `description` TEXT,
    `currency`  VARCHAR(5) NOT NULL
);
CREATE TABLE `airplanes`
(
    `id`           INT PRIMARY KEY AUTO_INCREMENT,
    `model`      VARCHAR(50) NOT NULL UNIQUE ,
	`passengers_capacity`      INT NOT NULL,
    `tank_capacity`       DECIMAL(19, 2) NOT NULL,
    `cost`       DECIMAL(19, 2)  NOT NULL
);
CREATE TABLE `passengers`
(
    `id`         INT PRIMARY KEY AUTO_INCREMENT,
    `first_name`       VARCHAR(30) NOT NULL,
    `last_name`       VARCHAR(30) NOT NULL,
    `country_id` INT  NOT NULL,
    CONSTRAINT `fk_people_countries`
        FOREIGN KEY (`country_id`) REFERENCES countries (`id`)
);
CREATE TABLE `flights` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `flight_code`  VARCHAR(30) NOT NULL UNIQUE ,
    `has_delay` TINYINT(1),
    `departure`  DATETIME,
    `departure_country` INT NOT NULL,
     CONSTRAINT `fk_departure_countries`
        FOREIGN KEY (`departure_country`) REFERENCES countries (`id`),
    `destination_country` INT NOT NULL,
     CONSTRAINT `fk_destination_country_countries`
        FOREIGN KEY (`destination_country`) REFERENCES countries (`id`),
    `airplane_id` INT NOT NULL,
     CONSTRAINT `fk_people_airplane`
        FOREIGN KEY (`airplane_id`) REFERENCES airplanes (`id`)
);
CREATE TABLE `flights_passengers`
(
    `flight_id` INT,
    `passenger_id` INT,
    KEY `pk_flights_passengers` (`flight_id`, `passenger_id`),
    CONSTRAINT `fk_flights`
        FOREIGN KEY (`flight_id`) REFERENCES flights (id),
    CONSTRAINT `fk_passengers`
        FOREIGN KEY (`passenger_id`) REFERENCES passengers (id)
);


INSERT INTO airplanes (model, passengers_capacity, tank_capacity, cost)
SELECT CONCAT(REVERSE(p.first_name), '797'), length(p.last_name)*17,
 p.id*790, length(p.first_name)*50.6
FROM passengers AS p
WHERE p.id <= 5;

# UPDATE NOT WORK
UPDATE `flights` AS f
SET f.`airplane_id` = f.`airplane_id` + 1
WHERE f.destination_country IN
(SELECT s.id FROM countries AS s
 WHERE s.name = 'Armenia');

DELETE m FROM flights AS m
	LEFT JOIN flights_passengers AS m2 on m.id = m2.flight_id
 WHERE m2.passenger_id IS NULL;
 

#5
SELECT 
	a.`id`,
	a.`model`,
    a.`passengers_capacity`,
    a.`tank_capacity`,
    a.`cost`
FROM `airplanes` AS a
ORDER BY a.`cost` DESC, a.`id` DESC;

#6

SELECT  f.flight_code, f.departure_country, f.airplane_id, f.departure
FROM flights AS f
WHERE year(departure) = 2022
ORDER BY f.airplane_id, f.flight_code LIMIT 20;

#7 NOT WORK
USE `EXAM_db`;

SELECT concat(upper(SUBSTRING(p.last_name, 1, 3)) + p.country_id) as flight_code,
CONCAT(p.first_name + ' ' + p.last_name) as full_name,
 p.country_id AS country_id 
 FROM `passengers` AS p
 GROUP BY p.id
 ORDER BY country_id;
--  LEFT JOIN `countries` AS c ON c.id = p.country_id
-- GROUP BY p.id
--  ORDER BY country_id;
 
 #8 NOT WORK
 SELECT c.name, c.currency, COUNT(f.destination_country) AS booked_tickets
FROM countries AS c
         JOIN passengers AS p on c.id = p.country_id
         JOIN flights as f ON f.destination_country= c.id
GROUP BY p.id
HAVING booked_tickets >= 20
ORDER BY booked_tickets desc;


#10

DELIMITER $$
CREATE FUNCTION udf_count_flights_from_country(country VARCHAR(50)) 
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE flights_count  INT;
    SET flights_count := (
        SELECT count(c.id)
        FROM countries c
                 JOIN flights f on f.departure_country = c.id
 WHERE c.name = country );
RETURN flights_count;
end $$
DELIMITER ;
#9
SELECT m.flight_code,
m.departure,
       (CASE
            WHEN HOUR(m.departure) >= 5 AND HOUR(m.departure)< 12  THEN 'Morning'
            WHEN HOUR(m.departure) >= 12 AND HOUR(m.departure) < 17 THEN 'Afternoon'
            WHEN HOUR(m.departure) >= 17 AND HOUR(m.departure) < 21 THEN 'Evening'
            ELSE 'Night '
           END) AS day_part
FROM flights AS m
ORDER BY m.flight_code desc;

#11 NOT WORK

DELIMITER $$
CREATE PROCEDURE `udp_delay_flight`(`code` VARCHAR(50))
BEGIN
    UPDATE `flights` AS f
      
    SET f.has_delay = TRUE
    and  HOUR(f.departure) = HOUR(f.departure) + 30
    WHERE f.flight_code = code;
END $$
DELIMITER ;















