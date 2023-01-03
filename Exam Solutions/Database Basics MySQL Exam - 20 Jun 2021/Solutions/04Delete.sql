USE `stc`;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM `clients` AS cl
WHERE cl.`id` NOT IN (
		SELECT c.`client_id`
		FROM `courses` AS c
	) AND CHAR_LENGTH(cl.`full_name`) > 3
;