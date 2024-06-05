--ex1
select distinct replacement_cost
from film
order by replacement_cost
--ex 2
select
case 
when replacement_cost between 9.99 and 19.99 then 'low'
when replacement_cost between 20.00 and 24.99 then 'medium'
when replacement_cost between 25.00 and 29.99 then 'high'
end category,
count (*) as so_luong
	from film
group by category
--ex 3
select title,length,name	
from film as a
join film_category as b on a.film_id=b.film_id
join category as c on b.category_id=c.category_id
where name like '%Drama%' or name like '%Sports%'
order by length desc
--ex 4
select name,
count (a.title) as so_luong
from film as a
join film_category as b on a.film_id=b.film_id
join category as c on b.category_id=c.category_id
group by name
order by so_luong desc
--ex 5
select distinct a.actor_id, first_name, last_name,
count ( distinct film_id) as so_luong
from actor as a
join film_actor as b 
on a.actor_id=b.actor_id
group by a.actor_id
order by so_luong desc
--ex 6
select 
count (a.address_id)
from address as a
left join customer as b
on a.address_id=b.address_id
where first_name is null
--ex 7
select city,
sum (amount) as total_amount
from city as a
join address as b on a.city_id=b.city_id
join customer as c on b.address_id=c.address_id
join payment as d on c.customer_id=d.customer_id
group by city
order by total_amount desc
--ex 8
select 
city||','|| country as thong_tin,
sum (amount) as total_amount
from city as a
join address as b on a.city_id=b.city_id
join customer as c on b.address_id=c.address_id
join payment as d on c.customer_id=d.customer_id
join country as e on a.country_id=e.country_id
group by thong_tin	
order by total_amount, thong_tin desc

