with city_wise_analysis as (
SELECT 
      dc.city_name,
      sum(fps.new_passengers) as total_new_passengers
FROM trips_db.fact_passenger_summary fps
join dim_city dc
on dc.city_id=fps.city_id
group by city_name
),
ranking_analysis as (
select
   city_name,
   total_new_passengers,
   rank() over(order by total_new_passengers desc) as highest_ranking,
   rank() over(order by total_new_passengers asc) as lowest_ranking
from city_wise_analysis
),
catogory_analysis as (  
select 
       city_name,
       total_new_passengers,
       case
           when highest_ranking <=3 then "Top 3"
           when Lowest_ranking <=3 then "Bottom 3"
           else null
		end as catogory
from ranking_analysis
)
 select 
       city_name,
       total_new_passengers,
       catogory
 from catogory_analysis
 where catogory is not null
 order by total_new_passengers desc
