USE `stc`;

DROP FUNCTION IF EXISTS `udf_courses_by_client`;

DELIMITER $$
CREATE FUNCTION `udf_courses_by_client`(phone_num VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE courses_count INT;
    SET courses_count := (
		SELECT COUNT(c.`id`)
        FROM `courses` AS c
        JOIN `clients` AS cl ON cl.`id` = c.`client_id`
        WHERE phone_num = `phone_number`);
	RETURN courses_count;
END$$
DELIMITER ;

SELECT udf_courses_by_client ('(831) 1391236') as `count`;