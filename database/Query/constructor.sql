-- All the information in the table 'constructors'

DELIMITER $$

CREATE PROCEDURE GetConstructor(IN constructorID int)
BEGIN
    SELECT * 
    FROM constructors
    WHERE constructor_id = constructorID;
END$$

DELIMITER ;

CALL GetConstructor(2);

-- create a new table store all constructorID and driverID

CREATE TABLE constructorAndDriver (
    constructorID INT NOT NULL,
    driverID INT NOT NULL,
    PRIMARY KEY (constructorID, driverID)
);

INSERT IGNORE INTO constructorAndDriver (constructorID, driverID)
SELECT constructor_id, driver_id
FROM results;

-- select all drivers who is in the constructor which id is 1

SELECT *
FROM drivers d
JOIN constructorAndDriver cd ON cd.driverID = d.driver_id
WHERE cd.constructorID = 1;

-- select all drivers who is in the constructor that you input

DELIMITER $$

CREATE PROCEDURE GetDriverFromConstructor(IN constructorID int)
BEGIN
SELECT *
FROM drivers d
JOIN constructorAndDriver cd ON cd.driverID = d.driver_id
WHERE cd.constructorID = constructorID;
END$$

DELIMITER ;

CALL GetDriverFromConstructor(2);
