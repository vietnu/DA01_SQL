--ex 1
select name from students
where marks >75
order by right (name,3), id
--ex2
select user_id,
concat(upper(left(name,1)),
lower (right(name, length(name)-1))) as name
 from users
 order by user_id
--ex 3
SELECT manufacturer, 
'$'||ROUND((SUM(total_sales)/1000000),0)||' '||'million' 
as sale_mil
from pharmacy_sales
GROUP BY manufacturer
order by SUM(total_sales) DESC,manufacturer
--ex 4
SELECT EXTRACT(month from submit_date) as mth,
product_id,
ROUND(AVG(stars),2) as avg_stars 
from reviews
GROUP BY EXTRACT(month from submit_date),product_id
ORDER BY EXTRACT(month from submit_date), product_id
--ex 5
SELECT sender_id,
COUNT(message_id) AS message_count
FROM messages
WHERE EXTRACT(month from sent_date)=8
and EXTRACT(year from sent_date)=2022
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2
--ex 6
select tweet_id from Tweets
where length (content)>15
--ex 8
select count (id) 
from employees
where extract (month from joining_date ) between 1 and 7
and  extract (year from joining_date ) =2022
--ex 9
select 
position ('a' in first_name)
from worker
where first_name = 'Amitah' 
--ex 10
select substring (title,length(winery)+2,4)
from winemag_p2
where country='Macedonia'

