--ex1
select b.continent,
round (avg (a.population),0)
from city as a
join country as b
on a.countrycode=b.code
group by  b.continent
--ex 2
SELECT 
ROUND(CAST(COUNT(b.email_id)/COUNT(DISTINCT a.email_id) as decimal)) as activation_rate
FROM emails as a
LEFT JOIN texts as b
ON a.email_id=b.email_id
AND b.signup_action=	'Confirmed'
--ex3
SELECT b.age_bucket,
ROUND((SUM(CASE WHEN activity_type='send' then time_spent ELSE 0 END)/(SUM(CASE WHEN activity_type='open' then time_spent ELSE 0 END)+SUM(CASE WHEN activity_type='send' then time_spent ELSE 0 END)))*100.0,2) as send_perc,
ROUND((SUM(CASE WHEN activity_type='open' then time_spent ELSE 0 END)/(SUM(CASE WHEN activity_type='open' then time_spent ELSE 0 END)+SUM(CASE WHEN activity_type='send' then time_spent ELSE 0 END)))*100.0,2) as open_perc
FROM activities as a
JOIN age_breakdown as b
ON a.user_id=b.user_id
GROUP BY b.age_bucket
--ex 4
--ex5
select  t1.employee_id, t1.name,
 count(t2. employee_id ) as reports_count,
round(avg(t2.age)) as average_age
from Employees as t1
join Employees as t2
on t1.employee_id=t2.reports_to
group by employee_id
order by employee_id
--ex6
select a.product_name,
sum(b.unit) as unit
from Products as a
join Orders as b
on a.product_id=b.product_id
and order_date between '2020-02-01' and '2020-02-29'
group by b.product_id
having sum(b.unit) >=100
--ex7
SELECT a.page_id
FROM pages as a
full join page_likes as b
on a.page_id=b.page_id
where b.liked_date is NULL
ORDER BY a.page_id 
