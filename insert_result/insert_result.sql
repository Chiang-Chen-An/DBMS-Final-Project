DELIMITER $$

CREATE PROCEDURE insert_result(
    IN resultID INT,
    IN raceID INT,
    IN driverID INT,
    IN constructorID INT,
    IN num INT,
    IN pos_grid INT,
    IN pos INT,
    IN pos_txt VARCHAR(5),
    IN pos_order INT,
    IN Points INT,
    IN Laps INT,
    IN T TIME,
    IN Ms INT,
    IN Fastest_lap INT,
    IN Rank_of_fastest_lap INT,
    IN Fastest_lap_time TIME,
    IN Fastest_lap_speed FLOAT,
    IN statusID INT
)
BEGIN
    INSERT INTO results (
        result_id,
        race_id,
        driver_id,
        constructor_id,
        car_num,
        position_grid,
        position,
        position_text,
        position_order,
        points,
        laps,
        `Time`,
        time_in_milliseconds,
        fastest_lap,
        rank_of_fastest_lap,
        fastest_lap_time,
        fastest_lap_speed,
        status_id
    )
    VALUES (
        resultID,
        raceID,
        driverID,
        constructorID,
        num,
        pos_grid,
        pos,
        pos_txt,
        pos_order,
        Points,
        Laps,
        T,
        Ms,
        Fastest_lap,
        Rank_of_fastest_lap,
        Fastest_lap_time,
        Fastest_lap_speed,
        statusID
    );
END$$

DELIMITER ;

CALL insert_result(26565, 18, 1, 22, 1, 1, 1, '1', 1, 10, 58, '1:34:50.616', 5690616, 39, 2, '1:27:45', 218.300, 1);

