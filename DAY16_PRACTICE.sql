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
--ex4
select customer_id,name,visited_on,
sum(amount) as total_amount
from customer
group by visited_on


  
--ex5
select sum(tiv_2016) as tiv_2016
from Insurance
where tiv_2015 in (select tiv_2015 from Insurance group by tiv_2015 having count(*)>1 )
and 
(lat,lon) in (select lat, lon from insurance group by lat,lon having count(*)=1)
--ex6
with t1 as(
select departmentId, a.name, salary,b.name as dep_name,
dense_rank() over(partition by departmentId order by salary desc) as rnk
from employee as a join Department as b on a.departmentId=b.id)
select dep_name as Department, name as employee,salary
from t1
where rnk in (1,2,3)
--ex7
with t1 as (
SELECT turn, person_name, weight,
SUM(weight) OVER(ORDER BY turn ASC) AS tot_weight 
FROM Queue)
SELECT person_name
FROM Queue 
WHERE turn = (SELECT MAX(turn) FROM t1 WHERE tot_weight <= 1000)
--ex8
with t1 as(
select product_id, change_date, 
rank() over(partition by product_id order by change_date desc) as rk,
new_price 
from Products 
where change_date <= "2019-08-16")
select product_id,new_price as price from t1 where rk=1
union 
select product_id, 10 as price
from products
where change_date>"2019-08-16"
and product_id not in (select product_id from products where change_date<="2019-08-16")





