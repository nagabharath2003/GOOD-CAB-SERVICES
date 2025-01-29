with monthly_repeat_passenger_rate_city as (
SELECT 
       city_name,
       month_name,
       sum(total_passengers) as total_passengers,
       sum(repeat_passengers) as repeat_passengers
FROM trips_db.fact_passenger_summary fps
join dim_city dc
using (city_id)
join dim_date dd
on dd.start_of_month = fps.month
group by city_name,month_name
)
select
	   city_name,
       month_name,
	   total_passengers,
	   repeat_passengers,
       concat(round(repeat_passengers*100/total_passengers,2),'%') as monthly_repeat_passenger_rate_pct,
       concat(round(sum(repeat_passengers) over(partition by city_name)*100/
                                                             sum(total_passengers) over(partition by city_name),2),'%') as city_wise_repeat_passenger_rate
from monthly_repeat_passenger_rate_city