USE soft_uni;

DELIMITER $$

CREATE PROCEDURE usp_get_towns_starting_with(string_input VARCHAR(35))
BEGIN

SELECT `name` AS "town_name" FROM `towns`
WHERE `name` LIKE CONCAT(string_input,"%")
ORDER BY `town_name`;

END$$