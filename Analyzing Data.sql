-- NUMBER OF USERS PER VEHICLE TYPE
select member_casual,rideable_type, count(*) as total_trip_rideable
from `CASE_STUDY1`.`CLEANED_DATA`
group by member_casual, rideable_type
order by member_casual, rideable_type;


-- NUMBER OF USERS TYPE PER MONTH  
select member_casual, MONTHNAME(started_at) as month,
count(*) as total_trip_month
from `CASE_STUDY1`.`CLEANED_DATA`
group by  member_casual, MONTHNAME(started_at)
order by member_casual;


-- NUMBER OF USER TYPES PER DAY
select  member_casual, dayofweek(started_at) as day_number, dayname(started_at) as day_of_week,
count(ride_id) as total_trip_day
from  `CASE_STUDY1`.`CLEANED_DATA`
group by member_casual, day_number, day_of_week
order by member_casual, day_number;


-- NUMBER OF USERS PER HOUR OF A DAY
select member_casual, dayofweek(started_at)as day_number,
extract(HOUR from started_at) as hour_of_day, count(ride_id) as total_trip_hour
from `CASE_STUDY1`.`CLEANED_DATA`
group by member_casual, day_number, hour_of_day
order by member_casual, day_number, total_trip_hour;


-- AVERAGE RIDE LENGTH PER VEHICLE
select member_casual, rideable_type, avg(ride_length) as avg_travel_duration_vehicle
from `CASE_STUDY1`.`CLEANED_DATA`
group by member_casual,rideable_type
order by member_casual, avg_travel_duration_vehicle;


-- AVERAGE RIDE LENGTH PER USER TYPE PER MONTH 
select member_casual,
MONTHNAME(started_at) as month,
avg(ride_length) as avg_travel_duration_per_month
from `CASE_STUDY1`.`CLEANED_DATA`
group by member_casual,month
order by member_casual ASC;


-- AVERAGE RIDE LENGTH PER USER TYPE PER DAY
select member_casual, 
dayofweek(started_at) as day_name,
avg(ride_length) as avg_travel_duration_per_day
from `CASE_STUDY1`.`CLEANED_DATA`
group by member_casual,day_name
order by member_casual;


-- AVERAGE RIDE LENGTH PER USER TYPE PER HOUR
select member_casual, dayofweek(started_at) as day_name,
extract(HOUR from started_at) as hour_of_day, 
avg(ride_length) as avg_travel_duration_per_hour
from  `CASE_STUDY1`.`CLEANED_DATA`
group by member_casual, day_name, hour_of_day
order by member_casual;


-- AVERAGE RIDE STARTING PLACE 
select start_station_name, member_casual, 
avg(extract(HOUR from ended_at)) as avg_started_at
from `CASE_STUDY1`.`CLEANED_DATA`
group by member_casual, start_station_name
order by start_station_name;


-- AVERAGE RIDE ENDING PLACE 
select end_station_name, member_casual, 
avg(extract(HOUR from ended_at)) as avg_ended_at
from `CASE_STUDY1`.`CLEANED_DATA`
group by member_casual, end_station_name
order by end_station_name;


-- START LOCATION PLACE
select start_station_name, member_casual, 
avg(start_lat) as start_lat,
avg(start_lng) as start_lng, 
count(ride_id) as total_trip
from `CASE_STUDY1`.`CLEANED_DATA`
group by start_station_name, member_casual;


-- END LOCATION PLACE
select end_station_name, member_casual, 
avg(end_lat) as end_lat,
avg(end_lng) as end_lng, 
count(ride_id) as total_trip
from `CASE_STUDY1`.`CLEANED_DATA`
group by end_station_name, member_casual;


-- MODE MONTH
select rnk, member_casual, month,cnt
from 
(
	select member_casual, month,cnt,
		DENSE_RANK() OVER(order by cnt desc) as rnk
	from
    (
		select member_casual,
			MONTHNAME(started_at) as month,
            count(*) as cnt
		from `CASE_STUDY1`.`CLEANED_DATA`
        group by member_casual, MONTHNAME(started_at)
	) as temp1
)as temp2
order by rnk;


-- MODE DAY OF WEEK
select rnk, member_casual, day_name, cnt
from
(
  select member_casual, day_name, cnt,
  DENSE_RANK() OVER(order by cnt DESC) as rnk
    from
    (
      select member_casual,dayofweek(started_at)as  day_name, count(*) as cnt
      from `CASE_STUDY1`.`CLEANED_DATA`
      group by day_name, member_casual
    )as temp1
)as temp2
order by member_casual, rnk;



-- MODE HOUR OF DAY
select rnk, member_casual, day_of_week, hour_of_day, cnt
from
( 
  select member_casual, day_of_week, hour_of_day, cnt,
  DENSE_RANK() OVER(order by cnt desc) as rnk
    from
    (
      select member_casual, dayofweek(started_at) as day_of_week,
      extract(HOUR from started_at) as hour_of_day, count(*) as cnt
      from `CASE_STUDY1`.`CLEANED_DATA`
      group by day_of_week, member_casual, hour_of_day
    )as temp1
)as temp2
order by rnk;


-- RANKING THE START/END LOCATIONS
-- RANKING THE STARTING LOCATION WITH LONGITUDE AND LATITUDE 
select rnk, member_casual, start_station_name, start_lat, start_lng, cnt
from
( 
  select member_casual, start_station_name, start_lat, start_lng, cnt,
  DENSE_RANK() OVER(order by cnt desc) as rnk
    from
    (
      select member_casual, start_station_name, 
      avg(start_lat) as start_lat,
      avg(start_lng) as start_lng, count(*) as cnt
      from `CASE_STUDY1`.`CLEANED_DATA`
      group by start_station_name, member_casual
    )as temp1
)as temp2
order by rnk;

-- RANKING THE ENDING LOCATION WIH LOGITUDE AND LATITUDE
select rnk, member_casual, end_station_name, end_lat, end_lng, cnt
from
( 
  select member_casual, end_station_name, end_lat, end_lng, cnt,
  DENSE_RANK() OVER(order by cnt desc) as rnk
    from
    (
      select member_casual, end_station_name, 
      avg(end_lat) as end_lat, 
      avg(end_lng) as end_lng, count(*) as cnt
      from `CASE_STUDY1`.`CLEANED_DATA`
      group by end_station_name, member_casual
    )as temp1
)as temp2
order by rnk;