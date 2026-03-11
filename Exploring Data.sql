use `CASE_STUDY1`;
-- CHECKING NULL VALUES FRO EACH COLUMNS

select 
  count(*) - count(ride_id) ride_id,
  count(*) - count(rideable_type) rideable_type,
  count(*) - count(started_at) started_at,
  count(*) - count(ended_at) ended_at,
  count(*) - count(start_station_name) start_station_name,
  count(*) - count(start_station_id) start_station_id,
  count(*) - count(end_station_name) end_station_name,
  count(*) - count(end_station_id) end_station_id,
  count(*) - count(start_lat) start_lat,
  count(*) - count(start_lng) start_lng,
  count(*) - count(end_lat) end_lat,
  count(*) - count(end_lng) end_lng,
  count(*) - count(member_casual) member_casual
from `CASE_STUDY1`.`COMBINED_DATA`;


-- CHECKING FOR DUPLICATE ROWS IN DATA(no duplicates)
select count(ride_id) - count(distinct(ride_id)) as duplicate_rows
from `CASE_STUDY1`.`COMBINED_DATA`;
 
-- CHECKING FOR LENGTH OF THE ride_id - ALL VALUES CONTAINS ONLY 16 CHARCTERS
select length(ride_id) as length_ride_id
from `CASE_STUDY1`.`COMBINED_DATA`
group by length_ride_id;

-- CHECKING rideable_type - SHOULD BE ONLY 2 UNIQUE VALUES AND NUMBER OF VEHICLES 
select distinct rideable_type, count(rideable_type) as no_vehicle
from `CASE_STUDY1`.`COMBINED_DATA`
group by rideable_type;


-- STARTED/ ENDED AT PRESENT TIMESTAMP - YYYY-MM-DD HH:MM:SS UTC - MIN / MAX OF ride_length
select max(
  extract(HOUR from (ended_at - started_at)) * 60 +
  extract(MINUTE from (ended_at - started_at)) +
  extract(SECOND from (ended_at - started_at)) / 60) as longest_ride_length,
  min(extract(HOUR from (ended_at - started_at)) * 60 +
  extract(MINUTE from (ended_at - started_at)) +
  extract(SECOND from (ended_at - started_at)) / 60) as shortest_ride_length
from `CASE_STUDY1`.`COMBINED_DATA`;


-- CLACULLATE USAGE TIME OF BIKE MORE THAN A DAY
select count(*) AS longer_than_a_day
from `CASE_STUDY1`.`COMBINED_DATA`
where(
  extract(HOUR from (ended_at - started_at)) * 60 +
  extract(MINUTE from (ended_at - started_at)) +
  extract(SECOND from (ended_at - started_at)) / 60) >= 1440;   

select count(*) AS less_than_a_minute
from `CASE_STUDY1`.`COMBINED_DATA`
where(
  extract(HOUR from (ended_at - started_at)) * 60 +
  extract(MINUTE from (ended_at - started_at)) +
  extract(SECOND from (ended_at - started_at)) / 60) <= 1;  


-- EXPLORE start_stastion_name start_station_id end_station_name end_station_i  
select count(distinct start_station_name) as number_unique_station
from COMBINED_DATA; -- return = 1891

select count(distinct start_station_id) as number_unique_station_id
from COMBINED_DATA; -- return = 3360

select count(ride_id) as rows_missing_station_value
from COMBINED_DATA
where start_station_name is null or start_station_id is null;  -- return = 0 

select count(distinct end_station_name) as number_of_end_unique_station
from COMBINED_DATA; -- return = 1898

select count(distinct end_station_id) as number_end_unique_station_id
from COMBINED_DATA; -- return = 3382

select count(ride_id) as rows_missing_start_station_value
from COMBINED_DATA
where end_station_name is null or end_station_id is null;  -- return =  0


-- CHECK IF start_station_name / start_station_id / end_station_name / end_station_id IS NUL BUT HAVE VALLUE IN EACH OF THE TABLE
select distinct start_station_name,start_station_id
from `CASE_STUDY1`.`COMBINED_DATA`
where start_station_name is not null and start_station_id is null
order by start_station_id desc;

select distinct start_station_name,start_station_id
from `CASE_STUDY1`.`COMBINED_DATA`
where start_station_name is null and start_station_id is not null
order by start_station_id desc;

select distinct end_station_name,end_station_id
from `CASE_STUDY1`.`COMBINED_DATA`
where end_station_name is not null and end_station_id is null
order by end_station_id desc;

select distinct end_station_name,end_station_id
from `CASE_STUDY1`.`COMBINED_DATA`
where end_station_name is null and end_station_id is not null
order by end_station_id desc;
  
  
-- CHECK start_lat / start_lng / end_lat / end_lng
select count(ride_id) as null_lat_lng
from `CASE_STUDY1`.`COMBINED_DATA`
where start_lat is null or start_lng is null; -- return = 0

select count(ride_id) as null_lat_lng
from `CASE_STUDY1`.`COMBINED_DATA`
where start_lat is null and start_lng is null; -- return = 0

select count(ride_id) as null_lat_lng
from `CASE_STUDY1`.`COMBINED_DATA`
where end_lat is null or end_lng is null; -- return = 0

select count(ride_id) as null_lat_lng
from `CASE_STUDY1`.`COMBINED_DATA`
where end_lat is null and end_lng is null; -- return = 0


-- check member_casual - 2 unique values
select distinct member_casual, count(member_casual) as no_of_trips
from `CASE_STUDY1`.`COMBINED_DATA`
group by member_casual; -- return no_of_trips(memeber) = 3533333 return no_of_trips(casual) = 1984536
