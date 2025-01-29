with repeat_trips as (
SELECT city_name,
       trip_count,
       sum(repeat_passenger_count) as total_passengers
FROM trips_db.dim_repeat_trip_distribution
join trips_db.dim_city
using (city_id)
group by trip_count,city_name  ),
trip_count_by_city as(
select 
      city_name,
      sum(case when trip_count = "10-trips" then total_passengers else 0 end) as "10-trips",
      sum(case when trip_count = "9-trips" then total_passengers else 0 end )as "9-trips",
      sum(case when trip_count = "8-trips" then total_passengers else 0 end) as "8-trips",
      sum(case when trip_count = "7-trips" then total_passengers else 0 end) as "7-trips",
      sum(case when trip_count = "6-trips" then total_passengers else 0 end) as "6-trips",
      sum(case when trip_count = "5-trips" then total_passengers else 0 end) as "5-trips",
      sum(case when trip_count = "4-trips" then total_passengers else 0 end) as "4-trips",
      sum(case when trip_count = "3-trips" then total_passengers else 0 end) as "3-trips",
      sum(case when trip_count = "2-trips" then total_passengers else 0 end )as "2-trips"
from repeat_trips
group by city_name