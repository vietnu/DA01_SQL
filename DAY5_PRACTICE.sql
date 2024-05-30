--EX 1
Select distinct city from station 
where id%2=0
--EX 2
SELECT (COUNT(city) - COUNT(DISTINCT city)) FROM station
--EX 4
SELECT ROUND(CAST(SUM(item_count*order_occurrences)/SUM(order_occurrences)AS DECIMAL),1) AS mean
FROM items_per_order
--ex 5
SELECT candidate_id from candidates
WHERE skill in ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill)=3
--ex 6
SELECT user_id,
DATE(MAX(post_date))- DATE(MIN(post_date)) AS days_between
from posts
WHERE post_date BETWEEN '01/01/2021' AND '01/01/2022'
GROUP BY user_id 
HAVING COUNT(post_id)>1
--EX 7
SELECT card_name,
MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY (MAX(issued_amount) - MIN(issued_amount)) DESC
--ex 8
SELECT manufacturer,
COUNT (drug) AS drug_count,
ABS (SUM(total_sales-cogs)) AS total_loss
FROM pharmacy_sales
where total_sales-cogs <0
GROUP BY manufacturer
ORDER BY total_loss DESC
-- EX 9
select * from cinema
where id%2=1
and description not like 'boring' 
order by rating desc
--ex 10
Select teacher_id,
count(distinct(subject_id)) as cnt
from Teacher
group by teacher_id
--EX 11
SELECT user_id,
  COUNT(follower_id) AS followers_count
from Followers
group by user_id
--ex 12
select class from Courses
group by class
 having count(student) >=5
