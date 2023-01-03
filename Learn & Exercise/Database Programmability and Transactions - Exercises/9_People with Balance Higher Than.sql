USE soft_uni;

DELIMITER $$

CREATE PROCEDURE usp_get_holders_with_balance_higher_than(number INT)
BEGIN

SELECT a.`first_name`, a.`last_name` FROM `account_holders` AS a
JOIN `accounts` AS ac ON ac.account_holder_id=a.id
GROUP BY `account_holder_id`
HAVING number<SUM(`balance`)
ORDER BY a.id;

END