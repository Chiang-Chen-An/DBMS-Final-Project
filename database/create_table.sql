-- \N means no data in csv
-- use drop table when necessary
-- DROP TABLE circuits, constructors, constructor_results, constructor_standings, drivers, driver_standings, lap_times, pit_stops, qualifying, races, results, seaons, sprint_results, status;

-- circuits
create table circuits(
    circuits_id int NOT NULL,
    circuit_ref varchar(50),
    circuit_name varchar(50),
    city varchar(50),
    country varchar(50),
    lat double,
    lng double,
    alt double,
    wiki_url varchar(500),
    primary key (circuits_id)
);

-- constructor_results
create table constructor_results(
    constructor_result_id int default 0 NOT NULL,
    race_id int default 0,
    constructor_id int default 0,
    points int,
    status_of_result varchar(2),
    primary key (constructor_Result_id, race_id)
);


-- constructor_standings
create table constructor_standings(
    constructor_standings_id int NOT NULL,
    race_id int default 0,
    constructor_id int default 0,
    points int,
    position int,
    position_text varchar(5),
    wins int,
    primary key (constructor_standings_id)
);


-- constructors
create table constructors(
    constructor_id int default 0 NOT NULL,
    constructor_ref varchar(50),
    constructor_name varchar(50),
    nationality varchar(50),
    wiki_url varchar(500),
    primary key (constructor_id)
);


-- driver_standings
create table driver_standings(
    driver_standings_id int default 0 NOT NULL,
    race_id int default 0,
    driver_id int default 0,
    points int,
    position int,
    position_text varchar(5),
    wins int,
    primary key (driver_standings_id)
);

-- drivers
create table drivers(
    driver_id int default 0,
    driver_ref varchar(50),
    driver_number int,
    code varchar(3),
    f_name varchar(50),
    l_name varchar(50),
    date_of_birth datetime,
    nationality varchar(50),
    wiki_url varchar(500),
    primary key (driver_id)
);


-- lap_times
create table lap_times(
    race_id int NOT NULL,
    driver_id int default 0,
    lap_num int,
    position int,
    finish_time time,
    finish_time_in_milliseconds int,
    primary key (race_id, driver_id, lap_num)
);

-- pit_stops
create table pit_stops(
    race_id int NOT NULL,
    driver_id int default 0,
    stop_num int,
    lap_num int,
    time_of_pit_stop time,
    duration float,
    duration_in_milliseconds int,
    primary key (race_id, driver_id, lap_num)
);

-- qualifying
create table qualifying(
    qualify_id int NOT NULL,
    race_id int NOT NULL,
    driver_id int default 0,
    constructor_id int default 0,
    car_num int default 0,
    position int,
    q1 time,
    q2 time,
    q3 time,
    primary key (qualify_id, race_id, driver_id, constructor_id)
);

-- races
create table races(
    race_id int NOT NULL,
    year_of_race int,
    round int,
    circuits_id int,
    circuit_name varchar(50),
    race_date date,
    race_time time,
    wiki_url varchar(500),
    fp1_date date,
    fp1_time time,
    fp2_date date,
    fp2_time time,
    fp3_date date,
    fp3_time time,
    quali_date date,
    quali_time time,
    sprint_date date,
    sprint_time time,
    primary key (race_id)
);

-- results
create table results(
    result_id int NOT NULL,
    race_id int,
    driver_id int,
    constructor_id int,
    car_num int,
    position_grid int,
    position int,
    position_text varchar(5),
    position_order int,
    points int,
    laps int,
    `Time` time,
    time_in_milliseconds int,
    fastest_lap int,
    rank_of_fastest_lap int,
    fastest_lap_time time,
    fastest_lap_speed float,
    status_id int,
    primary key (result_id)
);

-- seasons
create table seasons(
    year_of_race int,
    wiki_url varchar(500),
    primary key (year_of_race)
);


-- sprint_results
create table sprint_results(
    result_id int NOT NULL,
    race_id int,
    driver_id int,
    constructor_id int,
    car_num int,
    position_grid int,
    position int,
    position_text varchar(5),
    position_order int,
    points int,
    laps int,
    `time` time,
    time_in_milliseconds int,
    fastest_lap int,
    fastest_lap_time time,
    status_id int,
    primary key (result_id)
);

-- status
create table status(
    status_id int,
    status_name varchar(50),
    primary key (status_id)
);

-- user
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL
);

-- comments
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
