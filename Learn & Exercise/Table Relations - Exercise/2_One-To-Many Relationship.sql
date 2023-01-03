USE geography;

CREATE TABLE `manufacturers`(
`manufacturer_id` INT PRIMARY KEY AUTO_INCREMENT, 
`name` VARCHAR(20) UNIQUE,
`established_on` DATE 
);

INSERT INTO `manufacturers` (`manufacturer_id`,`name`,`established_on`)
VALUE 
(1,"BMW","1916/03/01"),
(2,"Tesla","2003/01/01"),
(3,"Lada","1966/05/01");

CREATE TABLE `models` (
`model_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL,
`manufacturer_id` INT NOT NULL
);

INSERT INTO `models` (`model_id`,`name`,`manufacturer_id`)
VALUE
(101,"X1",1),
(102,"i6",1),
(103,"Model S",2),
(104,"Model X",2),
(105,"Model 3",2),
(106,"Nova",3);

ALTER TABLE `models`
ADD
CONSTRAINT `fk_model_manufacturer`
FOREIGN KEY (`manufacturer_id`)
REFERENCES `manufacturers`(`manufacturer_id`);


