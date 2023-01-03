USE geography;

SELECT c.continent_code, c.currency_code, COUNT(currency_code) AS "currency_usage" FROM countries AS c
GROUP BY c.continent_code,c.currency_code
HAVING currency_usage =
(SELECT COUNT(currency_code) AS count FROM countries AS c2
WHERE c2.continent_code=c.continent_code
GROUP BY c2.currency_code
ORDER BY count DESC
LIMIT 1)
AND currency_usage>1
ORDER BY continent_code,currency_code;