USE minions;

CREATE TABLE `users`(
id INT PRIMARY KEY AUTO_INCREMENT,
username VARCHAR(30) NOT NULL,
password VARCHAR(26) NOT NULL,
profile_picture BLOB,
last_login_time TIME,
is_deleted BOOLEAN
);

INSERT INTO `users`(`username`, `password`)
VALUES
("Gosho", "goshkohubaveca"),
("Marto", "12413"),
("Niki", "aeqweq32"),
("Kote", "asdaw43234"),
("Prascho", "asd3214");