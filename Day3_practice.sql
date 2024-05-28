-- Bài tập 1
Select name From city
where countrycode = "USA"
And population >120000
  --Bài tập 2
Select * From city
Where countrycode = "JPN"
--Bài tập 3
select city, state from station
--Bài tập 4
select distinct city from station
where city like 'a%' or city like 'e%' or city like 'i%' or city like 'o%' or city like 'u%'  
  --Bài tập 5
select distinct city from station
where city like "%a" or city like '%e' or city like '%i' or city like'%o' or city like '%u'
--Bài tập 6
select distinct city from station
where city not like 'a%' and city not like 'e%' and city not like 'i%' and city not like 'o%' and city not like 'u%'  
--Bài tập 7
select name from employee order by name
--Bài tập 8
select name from employee 
where salary >2000
and (months <10)
order by employee_id
--Bài tập 9
select product_id from products
where low_fats = 'Y'
and recyclable = 'Y'
--Bài tập 10
select name from customer 
where referee_id <> 2 or referee_id is null
--Bài tập 11
select name, population, area from world
where area >= 3000000 or population >= 25000000
--Bài tập 12
select distinct author_id as 'id' from views
where author_id = viewer_id
order by author_id
--Bài tập 13
SELECT part, assembly_step from parts_assembly
where finish_date is NULL
--Bài tập 14
select * from lyft_drivers
where yearly_salary <=30000
or yearly_salary >=70000
--Bài tập 15
select * from uber_advertising
where money_spent >100000
and year = 2019
