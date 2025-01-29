with monthly_revenue as (
SELECT 
    month_name,city_name, 
    SUM(fare_amount)/1000000 AS total_revenue_mln
FROM fact_trips
join dim_city
using (city_id)
join dim_date
using (date)
GROUP BY 
     city_name,month_name
),
city_wise_monthly_revenue  as (
select 
	  city_name,
	  sum(case when month_name = "january" then total_revenue_mln else 0 end) as januavry_revenue,
	  sum(case when month_name = "february" then total_revenue_mln else 0 end) as february_revenue,
      SUM(CASE WHEN month_name = 'march' THEN total_revenue_mln ELSE 0 END) AS march_revenue,
	  SUM(CASE WHEN month_name = 'april' THEN total_revenue_mln ELSE 0 END) AS april_revenue,
	  SUM(CASE WHEN month_name = 'may' THEN total_revenue_mln ELSE 0 END) AS may_revenue,
	  SUM(CASE WHEN month_name = 'june' THEN total_revenue_mln ELSE 0 END) AS june_revenue
from monthly_revenue 
group by city_name)
select * from city_wise_monthly_revenue  

