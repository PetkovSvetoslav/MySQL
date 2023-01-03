USE minions;

CREATE TABLE `people`(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(200) NOT NULL,
picture BLOB,
height DOUBLE(10,2),
weight DOUBLE(10,2),
gender CHAR(1) NOT NULL,
birthdate DATE NOT NULL,
biography TEXT
);

INSERT INTO `people` (`name`, `gender`, `birthdate`)
VALUES 
("Pesho", "m", DATE(NOW())),
("Penka", "f", DATE(NOW())),
("Petkanka", "f", DATE(NOW())),
("Pencho", "m", DATE(NOW())),
("Pegasus", "m", DATE(NOW()));