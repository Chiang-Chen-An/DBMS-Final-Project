CREATE TABLE `circuits` (
	`circuits_id` INTEGER NOT NULL,
	`circuit_ref` VARCHAR(50),
	`circuit_name` VARCHAR(50),
	`city` VARCHAR(50),
	`country` VARCHAR(50),
	`lat` DOUBLE,
	`lng` DOUBLE,
	`alt` DOUBLE,
	`wiki_url` VARCHAR(100),
	PRIMARY KEY(`circuits_id`)
);


CREATE TABLE `constructor_results` (
	`constructor_result_id` INTEGER NOT NULL DEFAULT 0,
	`race_id` INTEGER DEFAULT 0,
	`constructor_id` INTEGER DEFAULT 0,
	`points` INTEGER,
	`status_of_result` VARCHAR(2),
	PRIMARY KEY(`race_id`)
) COMMENT='status of result almost null
';


CREATE TABLE `constructor_standings` (
	`constructor_standings_id` INTEGER NOT NULL,
	`race_id` INTEGER DEFAULT 0,
	`constructor_id` INTEGER DEFAULT 0,
	`points` INTEGER,
	`position` INTEGER,
	`position_text` VARCHAR(5),
	`wins` INTEGER,
	PRIMARY KEY(`constructor_standings_id`)
);


CREATE TABLE `constructors` (
	`constructor_id` INTEGER NOT NULL DEFAULT 0,
	`constructor_ref` VARCHAR(50),
	`constructor_name` VARCHAR(50),
	`nationality` VARCHAR(50),
	PRIMARY KEY(`constructor_id`)
);


CREATE TABLE `driver_standings` (
	`driver_standings_id` INTEGER NOT NULL DEFAULT 0,
	`race_id` INTEGER DEFAULT 0,
	`driver_id` INTEGER DEFAULT 0,
	`points` INTEGER,
	`position` INTEGER,
	`position_text` VARCHAR(5),
	`wins` INTEGER,
	PRIMARY KEY(`driver_standings_id`)
);


CREATE TABLE `drivers` (
	`driver_id` INTEGER DEFAULT 0,
	`driver_ref` VARCHAR(50),
	`driver_number` INTEGER,
	`code` VARCHAR(3),
	`f_name` VARCHAR(50),
	`l_name` VARCHAR(50),
	`date_of_birth` DATETIME,
	`nationality` VARCHAR(50),
	`wiki_url` VARCHAR(100),
	PRIMARY KEY(`driver_id`)
);


CREATE TABLE `lap_times` (
	`race_id` INTEGER NOT NULL,
	`driver_id` INTEGER DEFAULT 0,
	`lap_num` INTEGER,
	`position` INTEGER,
	`finish_time` TIME,
	`finish_time_in_milliseconds` INTEGER,
	PRIMARY KEY(`race_id`, `driver_id`, `lap_num`)
);


CREATE TABLE `pit_stops` (
	`race_id` INTEGER NOT NULL,
	`driver_id` INTEGER DEFAULT 0,
	`stop_num` INTEGER,
	`lap_num` INTEGER,
	`time_of_pit_stop` DATETIME,
	`duration` TIME,
	`duration_in_milliseconds` INTEGER,
	PRIMARY KEY(`race_id`, `driver_id`, `lap_num`)
);


CREATE TABLE `qualifying` (
	`qualify_id` INTEGER NOT NULL,
	`race_id` INTEGER NOT NULL,
	`driver_id` INTEGER DEFAULT 0,
	`constructor_id` INTEGER DEFAULT 0,
	`car_num` INTEGER DEFAULT 0,
	`position` INTEGER,
	`q1` TIME,
	`q2` TIME,
	`q3` TIME,
	PRIMARY KEY(`qualify_id`, `race_id`, `driver_id`, `constructor_id`)
);


CREATE TABLE `races` (
	`race_id` INTEGER NOT NULL,
	`year_of_race` INTEGER,
	`circuits_id` INTEGER,
	`circuit_name` VARCHAR(50),
	`race_date` DATE,
	`race_time` TIME,
	`wiki_url` VARCHAR(100),
	`fp1_date` DATE,
	`fp1_time` TIME,
	PRIMARY KEY(`race_id`)
);


CREATE TABLE `results` (
	`result_id` INTEGER NOT NULL,
	`race_id` INTEGER,
	`driver_id` INTEGER,
	`constructor_id` INTEGER,
	`car_num` INTEGER,
	`position_grid` INTEGER,
	`position` INTEGER,
	`position_text` VARCHAR(5),
	`position_order` INTEGER,
	`points` INTEGER,
	PRIMARY KEY(`result_id`)
);


CREATE TABLE `seasons` (
	`year_of_race` INTEGER,
	`wiki_url` VARCHAR(100),
	PRIMARY KEY(`year_of_race`)
);


CREATE TABLE `sprint_results` (
	`result_id` INTEGER NOT NULL,
	`race_id` INTEGER,
	`driver_id` INTEGER,
	`constructor_id` INTEGER,
	`car_num` INTEGER,
	`position_grid` INTEGER,
	`position` INTEGER,
	`position_text` VARCHAR(5),
	`position_order` INTEGER,
	`points` INTEGER,
	PRIMARY KEY(`result_id`)
);


CREATE TABLE `status` (
	`status_id` INTEGER,
	`status_name` VARCHAR(50),
	PRIMARY KEY(`status_id`)
);


ALTER TABLE `races`
ADD FOREIGN KEY(`circuits_id`) REFERENCES `circuits`(`circuits_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `races`
ADD FOREIGN KEY(`circuit_name`) REFERENCES `circuits`(`circuit_name`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `constructor_standings`
ADD FOREIGN KEY(`race_id`) REFERENCES `races`(`race_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `constructor_results`
ADD FOREIGN KEY(`race_id`) REFERENCES `races`(`race_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `constructor_results`
ADD FOREIGN KEY(`constructor_id`) REFERENCES `constructors`(`constructor_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `constructor_standings`
ADD FOREIGN KEY(`constructor_id`) REFERENCES `constructors`(`constructor_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `driver_standings`
ADD FOREIGN KEY(`driver_id`) REFERENCES `drivers`(`driver_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `driver_standings`
ADD FOREIGN KEY(`race_id`) REFERENCES `results`(`race_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `sprint_results`
ADD FOREIGN KEY(`race_id`) REFERENCES `races`(`race_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `sprint_results`
ADD FOREIGN KEY(`driver_id`) REFERENCES `drivers`(`driver_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `sprint_results`
ADD FOREIGN KEY(`constructor_id`) REFERENCES `constructors`(`constructor_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `results`
ADD FOREIGN KEY(`driver_id`) REFERENCES `drivers`(`driver_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `results`
ADD FOREIGN KEY(`constructor_id`) REFERENCES `constructors`(`constructor_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `qualifying`
ADD FOREIGN KEY(`race_id`) REFERENCES `races`(`race_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `qualifying`
ADD FOREIGN KEY(`driver_id`) REFERENCES `drivers`(`driver_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `pit_stops`
ADD FOREIGN KEY(`race_id`) REFERENCES `races`(`race_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `pit_stops`
ADD FOREIGN KEY(`driver_id`) REFERENCES `drivers`(`driver_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `races`
ADD FOREIGN KEY(`year_of_race`) REFERENCES `seasons`(`year_of_race`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `qualifying`
ADD FOREIGN KEY(`constructor_id`) REFERENCES `constructors`(`constructor_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `lap_times`
ADD FOREIGN KEY(`race_id`) REFERENCES `races`(`race_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `lap_times`
ADD FOREIGN KEY(`driver_id`) REFERENCES `drivers`(`driver_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;