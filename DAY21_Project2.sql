--1. Số lượng đơn hàng và số lượng khách hàng mỗi tháng
select  
FORMAT_DATE('%Y-%m', created_at) as date,
count(distinct user_id) as total_user,
sum(case when status like 'Complete'then 1 else 0 end)as total_orde
from bigquery-public-data.thelook_ecommerce.orders
where FORMAT_DATE('%Y-%m', created_at) between '2019-01'and'2022-04'
group by FORMAT_DATE('%Y-%m', created_at)
order by date

--đúng
  select  
FORMAT_DATE('%Y-%m', t2.delivered_at) as date,
count(distinct t1.user_id) as total_user,
sum(case when t1.status like 'Complete'then 1 else 0 end)as total_orde
from bigquery-public-data.thelook_ecommerce.orders as t1
Join bigquery-public-data.thelook_ecommerce.order_items as t2 
on t1.order_id=t2.order_id
where FORMAT_DATE('%Y-%m', t2.delivered_at) between '2019-01'and'2022-04'
and t1.status='Complete'
group by FORMAT_DATE('%Y-%m', t2.delivered_at)
order by date

--2. Giá trị đơn hàng trung bình (AOV) và số lượng khách hàng mỗi tháng
select  
FORMAT_DATE('%Y-%m', created_at) as date,
count(distinct user_id) as distinct_users,
sum(sale_price)/count(distinct order_id) as average_order_value
from bigquery-public-data.thelook_ecommerce.order_items
where FORMAT_DATE('%Y-%m', created_at) between '2019-01'and'2022-04'
group by FORMAT_DATE('%Y-%m', created_at)
order by date


--3. Nhóm khách hàng theo độ tuổi
select first_name,last_name, gender, age,'youngest'as tag
from(
select first_name,last_name, gender, age,
dense_rank()over(order by age) as rnk
from bigquery-public-data.thelook_ecommerce.users)
where rnk =1
union all
select first_name,last_name, gender, age,'oldest'as tag
from(
select first_name,last_name, gender, age,
dense_rank()over(order by age desc) as rnk
from bigquery-public-data.thelook_ecommerce.users)
where rnk =1

--4.Top 5 sản phẩm mỗi tháng.
with cte as (
select*,dense_rank()over(partition by date order by profit desc) as rnk
from(
select FORMAT_DATE('%Y-%m', delivered_at) as date, product_id,name,
 sum(sale_price) as sales, sum(cost) as cost,
sum(sale_price)-sum(cost) as profit,
from bigquery-public-data.thelook_ecommerce.order_items as a
inner join bigquery-public-data.thelook_ecommerce.products as b
on a.id=b.id
where status ='Complete'
Group by date,a.product_id, b.name
order by date) as a)
select * from cte
where rnk between 1 and 5
order by date
--5.
select DATE(delivered_at ) as date,category,
  round(sum(sale_price),2) as revenue,
  from bigquery-public-data.thelook_ecommerce.order_items as a
  inner join bigquery-public-data.thelook_ecommerce.products as b
  on a.product_id=b.id
  where delivered_at BETWEEN '2022-01-15 00:00:00' AND '2022-04-16 00:00:00'
  and status='Complete' 
  group by date,category
  order by date



