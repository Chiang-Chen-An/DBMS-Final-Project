-- circuits
load data local infile './archive/circuits.csv'
into table circuits
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- constructor_results
load data local infile './archive/constructor_results.csv'
into table constructor_results
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- constructor_standings

load data local infile './archive/constructor_standings.csv'
into table constructor_standings
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- constructors

load data local infile './archive/constructors.csv'
into table constructors
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- driver_standings

load data local infile './archive/driver_standings.csv'
into table driver_standings
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- drivers

load data local infile './archive/drivers.csv'
into table drivers
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- lap_times

load data local infile './archive/lap_times.csv'
into table lap_times
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- pit_stops

load data local infile './archive/pit_stops.csv'
into table pit_stops
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- qualifying

load data local infile './archive/qualifying.csv'
into table qualifying
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- races

load data local infile './archive/races.csv'
into table races
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- results

load data local infile './archive/results.csv'
into table results
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- seasons

load data local infile './archive/seasons.csv'
into table seasons
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- sprint_results

load data local infile './archive/sprint_results.csv'
into table sprint_results
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- status

load data local infile './archive/status.csv'
into table status -- it's work on my wsl, but still need to check this will work or not
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;