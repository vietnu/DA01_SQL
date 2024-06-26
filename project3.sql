--1
select productline,year_id,dealsize,
sum(sales) as revenue
from public.sales_dataset_rfm_prj_clean
group by productline,year_id,dealsize

--2
select month_id, revenue,ordernumber 
from (with cte as(
select productline,year_id,dealsize,month_id,ordernumber,
sum(sales) as revenue
from public.sales_dataset_rfm_prj_clean
group by productline,year_id,dealsize,month_id,ordernumber)
select year_id,month_id, revenue,ordernumber,
rank()over(partition by year_id order by revenue desc) as rnk
from cte) a
where rnk =1

--3
select * from (with cte1 as(
select productline,year_id,dealsize,month_id,ordernumber,
sum(sales) as revenue
from public.sales_dataset_rfm_prj_clean
where month_id=11
group by productline,year_id,dealsize,month_id,ordernumber)
select *,
rank()over(partition by year_id order by revenue desc)
from cte1) a
where rank =1

--4
select *,
rank ()over(order by revenue desc) 
	from(with cte2 as(
select productline,year_id,
sum(sales) as revenue,
rank()over(partition by year_id order by sum(sales) desc)
from public.sales_dataset_rfm_prj_clean
where country='UK'
group by productline,year_id)
select productline,year_id,
revenue
from cte2 
where rank=1) a

--5
with cus_rfm as(
select customername,
current_date-MAX(orderdate) as R,
count(distinct ordernumber) as F,
sum(sales) as M
from public.sales_dataset_rfm_prj_clean
group by customername),
rfm_score as(
select customername,
ntile(5)over(order by R DESC) AS r_score,
ntile(5)over(order by f) as f_score,
ntile(5)over(order by m) as m_score
from cus_rfm)
select customername,
cast(r_score as varchar)||cast(f_score as varchar)||cast(m_score as varchar) as rfm_score
from rfm_score
