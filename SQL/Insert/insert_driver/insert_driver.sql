DELIMITER $$

CREATE PROCEDURE InsertDriver(
    IN p_driverId INT,
    IN p_driverRef VARCHAR(50),
    IN p_number INT,
    IN p_code VARCHAR(3),
    IN p_forename VARCHAR(50),
    IN p_surname VARCHAR(50),
    IN p_dob DATETIME,
    IN p_nationality VARCHAR(50),
    IN p_url VARCHAR(100)
)
BEGIN
    INSERT INTO drivers (driver_id, driver_ref, driver_number, code, f_name, l_name, date_of_birth, nationality, wiki_url) 
    VALUES (p_driverId, p_driverRef, p_number, p_code, p_forename, p_surname, p_dob, p_nationality, p_url);
END$$

DELIMITER ;

CALL InsertDriver(
    864, 'leclerc', 16, 'LEC', 'Charles', 'Leclerc', '1997-10-16', 'Monégasque', 'https://en.wikipedia.org/wiki/Charles_Leclerc'
);

-- insert driver data into drivers table by call InsertDriver function
