DELIMITER $$
CREATE PROCEDURE raceFromYear(IN year INT)
BEGIN
SELECT circuit_name as name
FROM races
WHERE year_of_race = year
ORDER BY name;
END$$
DELIMITER ;
