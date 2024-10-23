# DBMS-Final-Project

Here's an introduction to each column in the 14 CSV files:

1. **circuits.csv**:
   - `circuitId`: Unique ID for each circuit.
   - `circuitRef`: Circuit reference name.
   - `name`: Circuit name.
   - `location`: City or location of the circuit.
   - `country`: Country where the circuit is located.
   - `lat`, `lng`: Latitude and longitude of the circuit.
   - `alt`: Altitude of the circuit (in meters).
   - `url`: Official URL of the circuit.

2. **constructor_results.csv**:
   - `constructorResultsId`: Unique ID for constructor results.
   - `raceId`: Refers to the specific race.
   - `constructorId`: Constructor's unique identifier.
   - `points`: Points scored by the constructor in that race.
   - `status`: Performance status (e.g., finished, retired).

3. **constructor_standings.csv**:
   - `constructorStandingsId`: Unique ID for standings.
   - `raceId`: Refers to a particular race.
   - `constructorId`: Constructor's unique identifier.
   - `points`: Total points the constructor earned.
   - `position`: Constructor’s position in the standings.
   - `positionText`: Text representation of position.
   - `wins`: Number of race wins by the constructor.

4. **constructors.csv**:
   - `constructorId`: Unique ID for the constructor.
   - `constructorRef`: Reference name for constructor.
   - `name`: Constructor name.
   - `nationality`: Constructor's nationality.
   - `url`: Official URL of the constructor.

5. **driver_standings.csv**:
   - `driverStandingsId`: Unique ID for the driver standings.
   - `raceId`: Refers to a specific race.
   - `driverId`: Driver’s unique identifier.
   - `points`: Total points the driver earned.
   - `position`: Driver’s position in the standings.
   - `positionText`: Text representation of position.
   - `wins`: Number of race wins by the driver.

6. **drivers.csv**:
   - `driverId`: Unique ID for the driver.
   - `driverRef`: Reference name for the driver.
   - `number`: Driver’s car number.
   - `code`: Driver’s code (short form).
   - `forename`, `surname`: Driver’s first and last names.
   - `dob`: Date of birth.
   - `nationality`: Driver’s nationality.
   - `url`: Official URL for more details on the driver.

7. **lap_times.csv**:
   - `raceId`: Refers to a specific race.
   - `driverId`: Driver’s unique identifier.
   - `lap`: Lap number.
   - `position`: Driver's position for the lap.
   - `time`: Lap time.
   - `milliseconds`: Lap time in milliseconds.

8. **pit_stops.csv**:
   - `raceId`: Refers to a specific race.
   - `driverId`: Driver’s unique identifier.
   - `stop`: Number of the pit stop.
   - `lap`: Lap during which the pit stop occurred.
   - `time`: Pit stop time.
   - `duration`: Duration of the pit stop.
   - `milliseconds`: Duration in milliseconds.

9. **qualifying.csv**:
   - `qualifyId`: Unique ID for qualifying data.
   - `raceId`: Refers to a specific race.
   - `driverId`: Driver’s unique identifier.
   - `constructorId`: Constructor’s unique identifier.
   - `number`: Driver’s car number.
   - `position`: Qualifying position.
   - `q1`, `q2`, `q3`: Times for qualifying sessions 1, 2, and 3.

10. **races.csv**:
    - `raceId`: Unique ID for the race.
    - `year`: Year the race was held.
    - `round`: Round number in the season.
    - `circuitId`: Refers to the circuit.
    - `name`: Name of the race.
    - `date`: Date of the race.
    - `time`: Time the race started.
    - `url`: Official race URL.
    - `fp1_date`, `fp1_time`: Date and time of Free Practice 1.
    - `fp2_date`, `fp2_time`: Date and time of Free Practice 2.
    - `fp3_date`, `fp3_time`: Date and time of Free Practice 3.
    - `quali_date`, `quali_time`: Date and time of qualifying.
    - `sprint_date`, `sprint_time`: Date and time of sprint race.

11. **results.csv**:
    - `resultId`: Unique ID for the result.
    - `raceId`: Refers to a specific race.
    - `driverId`: Driver’s unique identifier.
    - `constructorId`: Constructor’s unique identifier.
    - `number`: Driver’s car number.
    - `grid`: Starting grid position.
    - `position`: Finishing position.
    - `positionText`: Text for the position.
    - `positionOrder`: Order of position (numerical).
    - `points`: Points scored in the race.
    - `laps`: Number of laps completed.
    - `time`: Finishing time.
    - `milliseconds`: Time in milliseconds.
    - `fastestLap`: Number of the fastest lap.
    - `rank`: Rank for fastest lap.
    - `fastestLapTime`: Time for the fastest lap.
    - `fastestLapSpeed`: Speed during the fastest lap.
    - `statusId`: Status of the driver (finished, retired, etc.).

12. **seasons.csv**:
    - `year`: Season year.
    - `url`: Official URL for the season overview.

13. **sprint_results.csv**:
    - `resultId`: Unique ID for the sprint result.
    - `raceId`: Refers to a specific sprint race.
    - `driverId`: Driver’s unique identifier.
    - `constructorId`: Constructor’s unique identifier.
    - `number`: Driver’s car number.
    - `grid`: Starting grid position for the sprint.
    - `position`: Final position.
    - `positionText`: Text for the position.
    - `positionOrder`: Order of position.
    - `points`: Points scored in the sprint.
    - `laps`: Number of laps completed in the sprint.
    - `time`: Finishing time.
    - `milliseconds`: Time in milliseconds.
    - `fastestLap`: Number of the fastest lap.
    - `fastestLapTime`: Time for the fastest lap.
    - `statusId`: Status of the driver.

14. **status.csv**:
    - `statusId`: Unique ID for the status.
    - `status`: Status description (e.g., "Finished," "Retired," etc.). 

Each CSV file covers a different aspect of Formula 1, from circuits and drivers to race results and standings.
