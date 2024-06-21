--1. Số lượng đơn hàng và số lượng khách hàng mỗi tháng
select  
FORMAT_DATE('%Y-%m', created_at) as date,
count(distinct user_id) as total_user,
sum(case when status like 'Complete'then 1 else 0 end)as total_orde
from bigquery-public-data.thelook_ecommerce.orders
where FORMAT_DATE('%Y-%m', created_at) between '2019-01'and'2022-04'
group by FORMAT_DATE('%Y-%m', created_at)
order by date

--2. Giá trị đơn hàng trung bình (AOV) và số lượng khách hàng mỗi tháng
select  
FORMAT_DATE('%Y-%m', created_at) as date,
count(distinct user_id) as distinct_users,
sum(sale_price)/count(order_id) as average_order_value
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
select FORMAT_DATE('%Y-%m', created_at) as date, product_id,name, sale_price, cost,
sum(sale_price)over(partition by product_id)-sum(cost)over(partition by product_id) as profit,
from bigquery-public-data.thelook_ecommerce.order_items as a
inner join bigquery-public-data.thelook_ecommerce.products as b
on a.id=b.id
where status like 'Complete') as a)
select * from cte
where rnk between 1 and 5
--5.
select DATE(created_at) as date,category,
sum(sale_price)over(partition by category) as revenue
from bigquery-public-data.thelook_ecommerce.order_items as a
inner join bigquery-public-data.thelook_ecommerce.products as b
on a.id=b.id
where DATE(created_at) between '2022-01-01'and'2022-04-15'
order by date


