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
    wiki_url varchar(100),
    primary key (circuits_id)
);

load data local infile './archive/circuits.csv'
into table circuits
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- constructor_results
create table constructor_results(
    constructor_result_id int default 0 NOT NULL,
    race_id int default 0,
    constructor_id int default 0,
    points int,
    status_of_result varchar(2),
    primary key (constructor_Result_id, race_id)
);

load data local infile './archive/constructor_results.csv'
into table constructor_results
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

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

load data local infile './archive/constructor_standings.csv'
into table constructor_standings
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- constructors
create table constructors(
    constructor_id int default 0 NOT NULL,
    constructor_ref varchar(50),
    constructor_name varchar(50),
    nationality varchar(50),
    primary key (constructor_id)
);

load data local infile './archive/constructors.csv'
into table constructors
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

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

load data local infile './archive/driver_standings.csv'
into table driver_standings
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

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
    wiki_url varchar(100),
    primary key (driver_id)
);

load data local infile './archive/drivers.csv'
into table drivers
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

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

load data local infile './archive/lap_times.csv'
into table lap_times
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- pit_stops
create table pit_stops(
    race_id int NOT NULL,
    driver_id int default 0,
    stop_num int,
    lap_num int,
    time_of_pit_stop datetime,
    duration time,
    duration_in_milliseconds int,
    primary key (race_id, driver_id, lap_num)
);

load data local infile './archive/pit_stops.csv'
into table pit_stops
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

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

load data local infile './archive/qualifying.csv'
into table qualifying
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- races
create table races(
    race_id int NOT NULL,
    year_of_race int,
    circuits_id int,
    circuit_name varchar(50),
    race_date date,
    race_time time,
    wiki_url varchar(100),
    fp1_date date,
    fp1_time time,
    primary key (race_id)
);

load data local infile './archive/races.csv'
into table races
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

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
    primary key (result_id)
);

load data local infile './archive/results.csv'
into table results
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- seasons
create table seasons(
    year_of_race int,
    wiki_url varchar(100),
    primary key (year_of_race)
);

load data local infile './archive/seasons.csv'
into table seasons
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

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
    primary key (result_id)
);

load data local infile './archive/sprint_results.csv'
into table sprint_results
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- status
create table status(
    status_id int,
    status_name varchar(50),
    primary key (status_id)
);

load data local infile './archive/status.csv'
into table status -- it's work on my wsl, but still need to check this will work or not
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
