USE soft_uni;

SELECT t.town_id,t.name AS "town_name",a.address_text FROM towns t
JOIN addresses a
ON t.town_id=a.town_id
WHERE t.name= "Sofia" OR t.name="San Francisco" OR t.name="Carnation"
ORDER BY town_id,address_id;
