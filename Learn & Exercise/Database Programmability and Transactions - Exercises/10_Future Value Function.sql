USE soft_uni;

DELIMITER $$

CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(10,4),yearly_interest_rate DOUBLE,nuber_of_years INT)
RETURNS DECIMAL(10,4)
DETERMINISTIC
BEGIN

DECLARE output_sum DECIMAL(10,4);
SET output_sum = sum * POWER((1+yearly_interest_rate),nuber_of_years);
RETURN output_sum;

END