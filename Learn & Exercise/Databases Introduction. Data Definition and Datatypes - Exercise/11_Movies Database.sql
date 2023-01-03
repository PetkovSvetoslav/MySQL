USE movies;

CREATE TABLE `directors`(
id INT PRIMARY KEY AUTO_INCREMENT,
director_name VARCHAR(50) NOT NULL,
notes TEXT
);

CREATE TABLE `genres`(
id INT PRIMARY KEY AUTO_INCREMENT,
genre_name VARCHAR(50) NOT NULL,
notes TEXT
);

CREATE TABLE `categories`(
id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(50) NOT NULL,
notes TEXT
);

CREATE TABLE `movies`(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
director_id INT,
copyright_year DATE,
length INT,
genre_id INT,
category_id INT,
rating DOUBLE(10,2),
notes TEXT
);

INSERT INTO `genres`(`genre_name`)
VALUES 
("horror"),
("romance"),
("drama"),
("comedy"),
("action");

INSERT INTO `directors`(`director_name`)
VALUES 
("Pesho"),
("Gosho"),
("Tosho"),
("Haralampi"),
("Pepi");

INSERT INTO `categories`(`category_name`)
VALUES 
("one"),
("two"),
("three"),
("four"),
("five");

INSERT INTO `movies`(`title`)
VALUES 
("daba"),
("gaba"),
("saba"),
("traba"),
("chaba");