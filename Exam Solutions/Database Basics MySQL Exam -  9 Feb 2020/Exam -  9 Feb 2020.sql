-- SET sql_mode = 'ONLY_FULL_GROUP_BY'; 
CREATE DATABASE `fsd`;
USE fsd;
-- 1
 CREATE TABLE countries(
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(45) NOT NULL
 );
  CREATE TABLE towns(
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(45) NOT NULL,
 `country_id` INT NOT NULL,
 CONSTRAINT fk_towns_countries
 FOREIGN KEY (country_id) REFERENCES countries(id)
 );
  CREATE TABLE stadiums(
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
 `town_id` INT NOT NULL,
 CONSTRAINT fk_stadiums_towns
 FOREIGN KEY (town_id) REFERENCES towns(id)
 );
  CREATE TABLE teams(
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `name` VARCHAR(45) NOT NULL,
`established` DATE NOT NULL,
`fan_base` BIGINT NOT NULL DEFAULT 0,
 `stadium_id` INT NOT NULL,
 CONSTRAINT fk_stadiums_teams
 FOREIGN KEY (stadium_id) REFERENCES stadiums(id)
 );
 CREATE TABLE skills_data(
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `dribbling` INT DEFAULT 0,
 `pace` INT DEFAULT 0,
 `passing` INT DEFAULT 0,
 `shooting` INT DEFAULT 0,
 `speed` INT DEFAULT 0,
 `strength` INT DEFAULT 0
 );
   CREATE TABLE coaches(
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `first_name` VARCHAR(10) NOT NULL,
 `last_name` VARCHAR(20) NOT NULL,
`salary` DECIMAL(10,2) NOT NULL DEFAULT 0,
`coach_level` INT NOT NULL DEFAULT 0
 );
   CREATE TABLE players(
 `id` INT AUTO_INCREMENT PRIMARY KEY,
 `first_name` VARCHAR(10) NOT NULL,
 `last_name` VARCHAR(20) NOT NULL,
`age` INT NOT NULL DEFAULT 0,
`position` CHAR(1) NOT NULL,
`salary` DECIMAL(10,2) NOT NULL DEFAULT 0,
`hire_date` DATETIME,
`skills_data_id` INT NOT NULL,
`team_id` INT,
CONSTRAINT fk_p_teams FOREIGN KEY (team_id) REFERENCES teams(id),
CONSTRAINT fk_p_skills FOREIGN KEY (skills_data_id) REFERENCES skills_data(id)
 );
 CREATE TABLE players_coaches (
 `player_id` INT,
 `coach_id` INT,
 CONSTRAINT fk_maping_player FOREIGN KEY (player_id) REFERENCES players(id),
 CONSTRAINT fk_maping_coaches FOREIGN KEY (coach_id) REFERENCES coaches(id)
 );
 
 -- 2
 INSERT INTO coaches (first_name, last_name, salary, coach_level) 
SELECT first_name, last_name, salary*2, char_length(first_name) as coach_level FROM players WHERE age >= 45;
 
 -- 3
UPDATE coaches AS c SET coach_level = coach_level + 1 WHERE c.first_name LIKE 'A%' 
--  AND c.id IN(SELECT coach_id FROM players_coaches);
  AND (SELECT count(*) FROM players_coaches WHERE coach_id = c.id) > 0;
  
   -- 4
  DELETE FROM players WHERE age >= 45;
  
    -- 5
 SELECT first_name, age, salary from players ORDER BY salary DESC;
 
     -- 6
     SELECT p.id, concat(first_name, ' ' , last_name) as full_name, age, position, hire_date 
     from players  AS p JOIN skills_data AS sd ON p.skills_data_id = sd.id
     WHERE sd.strength > 50 AND position = 'A' AND age < 23 AND hire_date IS NULL
     ORDER BY salary, age ;
     
      -- 7
 SELECT t.`name` as team_name, t.established, t.fan_base, COUNT(p.id) AS cntp FROM teams AS t 
 LEFT JOIN players AS p ON t.id = p.team_id
 GROUP BY t.id
 ORDER BY cntp DESC , fan_base DESC;
     -- 7
--   SELECT t.`name` as team_name, t.established, t.fan_base, (SELECT COUNT(*) FROM players WHERE team_id = t.id) AS cntp 
--   FROM teams AS t ORDER BY cntp DESC , fan_base DESC;

       -- 8
       SELECT MAX(sd.speed) AS spd, t.`name`  FROM skills_data AS sd 
       RIGHT JOIN players as p ON p.skills_data_id = sd.id
       RIGHT JOIN teams as tm ON p.team_id = tm.id
       RIGHT JOIN stadiums as s ON tm.stadium_id = s.id
       RIGHT JOIN towns as t ON s.town_id = t.id
       WHERE tm.`name` != 'Devify'
       GROUP BY t.id ORDER BY spd DESC, t.`name`;
         -- 9
          SELECT c.name, COUNT(p.id) as cnp, SUM(p.salary)   FROM players as p 
       RIGHT JOIN teams as tm ON p.team_id = tm.id
       RIGHT JOIN stadiums as s ON tm.stadium_id = s.id
       RIGHT JOIN towns as t ON s.town_id = t.id
       RIGHT JOIN countries as c ON t.country_id = c.id
       GROUP BY c.name ORDER BY cnp DESC, c.`name`;
           -- 10
           DELIMITER $$
           CREATE FUNCTION udf_stadium_players_count (stadium_name VARCHAR(30))
RETURNS INTEGER DETERMINISTIC
BEGIN
   RETURN 
           (SELECT count(*) as cnt FROM players as p
 JOIN teams as tm ON p.team_id = tm.id
     LEFT JOIN stadiums as s ON tm.stadium_id = s.id
       WHERE s.name = stadium_name );
END
$$
 DELIMITER ;
            -- 11
            DELIMITER $$
           CREATE PROCEDURE udp_find_playmaker(min_dribble_points INT, team_name VARCHAR(45))
           BEGIN
 SELECT CONCAT(first_name, ' ' , last_name) as full_name, age, salary, dribbling, speed, team_name
 FROM skills_data AS sd 
	JOIN players as p ON p.skills_data_id = sd.id
       RIGHT JOIN teams as t ON p.team_id = t.id
 WHERE  t.name = team_name 
 AND speed > (SELECT  AVG(speed) FROM skills_data) 
 AND dribbling > min_dribble_points
        ORDER BY sd.speed DESC LIMIT 1;
        END
 $$
 DELIMITER ;
 
 
 
 
 
 