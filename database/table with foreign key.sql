ALTER TABLE `races`
ADD FOREIGN KEY(`circuits_id`) REFERENCES `circuits`(`circuits_id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
-- Error
-- ALTER TABLE `races`
-- ADD FOREIGN KEY(`circuit_name`) REFERENCES `circuits`(`circuit_name`)
-- ON UPDATE NO ACTION ON DELETE NO ACTION;
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
-- Error
-- ALTER TABLE `driver_standings`
-- ADD FOREIGN KEY(`race_id`) REFERENCES `results`(`race_id`)
-- ON UPDATE NO ACTION ON DELETE NO ACTION;
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