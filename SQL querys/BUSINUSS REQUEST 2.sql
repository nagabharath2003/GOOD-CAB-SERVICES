SELECT 
       dc.city_name,
       dd.month_name,
       count(ft.trip_id) as actual_trips,
       mtt.total_target_trips as target_trips,
       case
           when  count(ft.trip_id) > mtt.total_target_trips then 'overperforming'
           else 'underperforming'
	   end as performance_status,
	   concat(
       round((count(ft.trip_id)-mtt.total_target_trips)*100/mtt.total_target_trips,2),"%") as pct_difference
FROM trips_db.fact_trips ft
join dim_city dc
         on dc.city_id=ft.city_id
join dim_date dd
	     on dd.date=ft.date
join targets_db.monthly_target_trips mtt
		 on mtt.city_id=ft.city_id
         and mtt.month=dd.start_of_month
group by  dc.city_name,dd.month_name,mtt.total_target_trips,dd.start_of_month