USE `stc`;

SET SQL_SAFE_UPDATES = 0;

UPDATE `cars`
SET `condition` = 'C'
WHERE `year` <= 2010
	AND `make` != 'Mercedes-Benz'
	AND (`mileage` >= 800000 OR `mileage` IS NULL)
;