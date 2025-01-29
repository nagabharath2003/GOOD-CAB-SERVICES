with monthly_revenue_anlysis as (
select 
      dc.city_name,
      dd.month_name,
      sum(fare_amount) as monthly_revenue
from fact_trips ft
join dim_city dc
using (city_id)
join dim_date dd
using (date)
group by city_name,month_name
),
city_total_revenue as (
select 
      city_name,
      sum(monthly_revenue) as total_city_revenue
from monthly_revenue_anlysis
group by city_name
),
highest_revenue_month as (
select 
      mcr.city_name,
      mcr.month_name as highest_revenue_month,
      mcr.monthly_revenue as monthly_revenue,
      concat(round((mcr.monthly_revenue*100/ctr.total_city_revenue),2),"%") as percentage_contribution
from monthly_revenue_anlysis mcr
join city_total_revenue ctr
on mcr.city_name= ctr.city_name
                   where monthly_revenue = (
				   select max(monthly_revenue)
                   from  monthly_revenue_anlysis sub_mcr
                   where sub_mcr.city_name = mcr.city_name
))
select 
      city_name,
      highest_revenue_month,
      monthly_revenue,
      percentage_contribution
 from highest_revenue_month
