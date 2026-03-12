-- DROP TABLE IF EXISTS AND CREATE NEW TABLE
drop table if exists `CASE_STUDY1`.`CLEANED_DATA`;

-- CREATING A NEW TABLE 
CREATE TABLE CLEANED_DATA AS
SELECT *, TIMESTAMPDIFF(SECOND, started_at, ended_at)/60 AS ride_length
FROM `CASE_STUDY1`.`COMBINED_DATA`
WHERE started_at IS NOT NULL
AND ended_at IS NOT NULL;

-- CHECK IF NEW DATA SET IS CREATED OR NOT 
select * from `CASE_STUDY1`.`CLEANED_DATA`;
select count(*) from `CASE_STUDY1`.`CLEANED_DATA`;


-- CLEANING DATA
-- TRIP DURATION >= 1440 
SELECT *, 
CASE
    WHEN DAYOFWEEK(started_at)=1 THEN 'SUN'
    WHEN DAYOFWEEK(started_at)=2 THEN 'MON'
    WHEN DAYOFWEEK(started_at)=3 THEN 'TUE'
    WHEN DAYOFWEEK(started_at)=4 THEN 'WED'
    WHEN DAYOFWEEK(started_at)=5 THEN 'THU'
    WHEN DAYOFWEEK(started_at)=6 THEN 'FRI'
    WHEN DAYOFWEEK(started_at)=7 THEN 'SAT'
END AS day_of_week,

CASE 
    WHEN MONTH(started_at)=1 THEN 'Jan'
    WHEN MONTH(started_at)=2 THEN 'Feb'
    WHEN MONTH(started_at)=3 THEN 'Mar'
    WHEN MONTH(started_at)=4 THEN 'Apr'
    WHEN MONTH(started_at)=5 THEN 'May'
    WHEN MONTH(started_at)=6 THEN 'Jun'
    WHEN MONTH(started_at)=7 THEN 'Jul'
    WHEN MONTH(started_at)=8 THEN 'Aug'
    WHEN MONTH(started_at)=9 THEN 'Sep'
    WHEN MONTH(started_at)=10 THEN 'Oct'
    WHEN MONTH(started_at)=11 THEN 'Nov'
    WHEN MONTH(started_at)=12 THEN 'Dec'
END AS month

FROM CASE_STUDY1.CLEANED_DATA
WHERE
start_station_name IS NOT NULL
AND end_station_name IS NOT NULL
AND end_lat IS NOT NULL
AND ride_length > 1440
ORDER BY ride_length DESC;


-- TRIP DURATION >1 AND <=1440 
SELECT *, 
CASE
    WHEN DAYOFWEEK(started_at)=1 THEN 'SUN'
    WHEN DAYOFWEEK(started_at)=2 THEN 'MON'
    WHEN DAYOFWEEK(started_at)=3 THEN 'TUE'
    WHEN DAYOFWEEK(started_at)=4 THEN 'WED'
    WHEN DAYOFWEEK(started_at)=5 THEN 'THU'
    WHEN DAYOFWEEK(started_at)=6 THEN 'FRI'
    WHEN DAYOFWEEK(started_at)=7 THEN 'SAT'
END AS day_of_week,

CASE 
    WHEN MONTH(started_at)=1 THEN 'Jan'
    WHEN MONTH(started_at)=2 THEN 'Feb'
    WHEN MONTH(started_at)=3 THEN 'Mar'
    WHEN MONTH(started_at)=4 THEN 'Apr'
    WHEN MONTH(started_at)=5 THEN 'May'
    WHEN MONTH(started_at)=6 THEN 'Jun'
    WHEN MONTH(started_at)=7 THEN 'Jul'
    WHEN MONTH(started_at)=8 THEN 'Aug'
    WHEN MONTH(started_at)=9 THEN 'Sep'
    WHEN MONTH(started_at)=10 THEN 'Oct'
    WHEN MONTH(started_at)=11 THEN 'Nov'
    WHEN MONTH(started_at)=12 THEN 'Dec'
END AS month

FROM CASE_STUDY1.CLEANED_DATA
WHERE
start_station_name IS NOT NULL
AND end_station_name IS NOT NULL
AND end_lat IS NOT NULL
AND ride_length > 1 
AND ride_length < 1440
ORDER BY ride_length DESC;