--ex1
WITH job_count AS (
SELECT company_id,title,description,
COUNT(job_id) as count_
FROM job_listings
GROUP BY company_id, title,description)
select 
COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count 
WHERE count_ >1
--ex 2
WITH sum_amount AS(
SELECT category,product,
SUM(spend) as total_spend
from product_spend
WHERE EXTRACT(year from transaction_date)='2022'
GROUP BY category,product
),
t1 AS(
SELECT *
FROM sum_amount
ORDER BY total_spend DESC
LIMIT 4)
SELECT * FROM t1
ORDER BY category,total_spend DESC
--ex3
WITH calls_count AS (
SELECT policy_holder_id, 
COUNT(case_id) as call_count
FROM callers
GROUP BY policy_holder_id
ORDER BY call_count)
SELECT 
COUNT(DISTINCT policy_holder_id)
FROM calls_count 
WHERE call_count >=3
--ex4
SELECT a.page_id
FROM pages as a
full join page_likes as b
on a.page_id=b.page_id
where b.liked_date is NULL
ORDER BY a.page_id 
--ex5
WITH june_tb AS (
SELECT user_id, event_type
FROM user_actions
WHERE event_date BETWEEN '06/01/2022' and '06/30/2022'),
july_tb AS(
SELECT user_id, event_type
FROM user_actions
WHERE event_date BETWEEN '07/01/2022' and '07/31/2022')
SELECT 7 as mth, 
COUNT(DISTINCT a.user_id) AS monthly_active_users
FROM june_tb as a
JOIN july_tb as b
on a.user_id=b.user_id
--ex6
with total_tb as(
select 
concat(left (trans_date,7)) as month, country,
count(*) as trans_count,
sum(amount) as trans_total_amount
from Transactions
group by concat(left (trans_date,7)), country),
approved_tb as(
select 
concat(left (trans_date,7)) as month, country,
count(*) as approved_count,
sum(amount) as approved_total_amount
from Transactions
where state='approved'
group by concat(left (trans_date,7)), country)
select a.month,a.country,a.trans_count,b.approved_count,a.trans_total_amount,b.approved_total_amount
from total_tb as a
join approved_tb as b
on a.month=b.month
group by a.month, a.country
--ex7
with t1 as(
select product_id,
min(year) as min_year
from Sales
group by product_id)
select b.product_id,a.year as first_year,a.quantity,a.price
from Sales as a
join t1 as b 
on a.product_id=b.product_id
where a.year=b.min_year
--ex8
select customer_id
from customer
group by customer_id
having count(distinct(product_key)) = (select count(*) from product)
--ex9
select employee_id
from Employees
where 
salary < 30000
and 
manager_id not in (select employee_id from Employees)
--ex10
WITH job_count AS (
SELECT company_id,title,description,
COUNT(job_id) as count_
FROM job_listings
GROUP BY company_id, title,description)
select 
COUNT(DISTINCT company_id) AS duplicate_companies
FROM job_count 
WHERE count_ >1
--ex11
(select a.name as results
from users as a
join movierating as b
on a.user_id=b.user_id
group by a.user_id
order by count(b.movie_id) desc, name 
limit 1)
union all
(select c.title as results
from movierating as b
join Movies as c on b.movie_id=c.movie_id
where extract(year from created_at)='2020'
and extract(month from created_at)='02'
group by b.movie_id
order by avg(b.rating) desc, title 
limit 1)
--ex12
SELECT id, COUNT(id) AS num
FROM 
    (
    SELECT requester_id AS id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted) as total_table
GROUP BY id
ORDER BY COUNT(id) DESC    
limit 1





