USE soft_uni;

CREATE TABLE notification_emails(
id INT PRIMARY KEY AUTO_INCREMENT, 
recipient INT, 
subject TEXT, 
body TEXT
);

DELIMITER $$

CREATE TRIGGER tr_email_on_change_balance
AFTER INSERT ON `logs`
FOR EACH ROW
BEGIN

INSERT INTO `notification_emails`(`recipient`,`subject`,`body`)
VALUES(NEW.`account_id`,CONCAT_WS(" ","Balance change for account:",NEW.`account_id`),CONCAT_WS(" ","On",NOW(),"your balance was changed from",NEW.`old_sum`,"to",NEW.`new_sum`,"."));

END$$