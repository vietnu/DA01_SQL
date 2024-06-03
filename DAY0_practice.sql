--EX1
SELECT 
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END)
AS laptop_views,
SUM(CASE WHEN device_type IN ('tablet','phone') THEN 1 ELSE 0 END)
AS mobile_views
FROM viewership
--EX 2
select x,y,z,
case when x+y>z and y+z>x and x+z>y then 'Yes' else 'No' end
as triangle
from triangle
--ex 3
SELECT 
ROUND(CAST(((SUM(case when call_category ='n/a' then 1 else 0 end)
+SUM(case when call_category is NULL then 1 else 0 end))
*100/COUNT(*)) AS DECIMAL),2)
AS uncategorised_call_pct
FROM callers
-- ex 4
select name from Customer
where referee_id  is null or referee_id  <> 2
--ex 5
select survived,
sum (case when pclass = 1 then 1 else 0 end) as first_class,
sum (case when pclass = 2 then 1 else 0 end) as second_class,
sum (case when pclass = 3 then 1 else 0 end) as third_class
from titanic
group by survived
