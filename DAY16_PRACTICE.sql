--ex1 
with t1 as(
select delivery_id,customer_id, customer_pref_delivery_date,
min(order_date) as mdate
from Delivery
group by customer_id)
select 
(sum(case when mdate=customer_pref_delivery_date then 1 else 0 end)/count(mdate))*100 as immediate_percentage
from t1
--ex2
with t1 as(
select  player_id,
min(event_date) as st_date
from activity
group by player_id)
select 
round(sum(case when st_date+1=event_date then 1 else 0 end)/count(distinct a.player_id),2) as fraction
from activity as a join t1 as b on a.player_id=b.player_id 
--ex3
select 
case 
when id=(select max(id) from seat) and id%2=1 then id
when id%2=1 then id+1
else id-1
end as id, student
from seat 
order by id
--ex5
select sum(tiv_2016) as tiv_2016
from Insurance
where tiv_2015 in (select tiv_2015 from Insurance group by tiv_2015 having count(*)>1 )
and 
(lat,lon) in (select lat, lon from insurance group by lat,lon having count(*)=1)
--ex6



