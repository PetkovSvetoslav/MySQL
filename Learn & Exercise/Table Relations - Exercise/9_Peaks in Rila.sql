USE geography;

SELECT mountain_range,peak_name,elevation AS "peak_elevation" FROM mountains m
JOIN peaks p
WHERE m.id=p.mountain_id AND mountain_range="Rila"
ORDER BY peak_elevation DESC;