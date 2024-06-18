--1.
alter table SALES_DATASET_RFM_PRJ
alter column orderlinenumber type  integer USING (trim(orderlinenumber)::integer)

alter table SALES_DATASET_RFM_PRJ
alter column orderdate type timestamp USING (trim(orderdate)::timestamp)

alter table SALES_DATASET_RFM_PRJ
alter column status type text USING (trim(status)::text)

alter table SALES_DATASET_RFM_PRJ
alter column customername type text USING (trim(customername)::text)
--2
select * from SALES_DATASET_RFM_PRJ
where ORDERNUMBER is  null  

select * from SALES_DATASET_RFM_PRJ
where QUANTITYORDERED is  null  

select * from SALES_DATASET_RFM_PRJ
where PRICEEACH is  null  

select * from SALES_DATASET_RFM_PRJ
where ORDERLINENUMBER is  null  

select * from SALES_DATASET_RFM_PRJ
where SALES is  null  

select * from SALES_DATASET_RFM_PRJ
where ORDERDATE is  null  
--3
alter table  SALES_DATASET_RFM_PRJ
add COLUMN CONTACTLASTNAME VARCHAR(50)

alter table  SALES_DATASET_RFM_PRJ
add COLUMN CONTACTFIRSTNAME VARCHAR(50)

UPDATE SALES_DATASET_RFM_PRJ
SET CONTACTFIRSTNAME=upper(left(CONTACTFIRSTNAME,1))||substring(contactfullname,2,(position ('-'in contactfullname)-2))

UPDATE SALES_DATASET_RFM_PRJ
SET CONTACTLASTNAME=upper(substring(contactfullname,position ('-'in contactfullname)+1,1))||substring(contactfullname,position ('-'in contactfullname)+2,(length(contactfullname)-length(CONTACTFIRSTNAME)))
--4
alter table SALES_DATASET_RFM_PRJ
add column QTR_ID NUMERIC

alter table SALES_DATASET_RFM_PRJ
add column month_id NUMERIC

  alter table SALES_DATASET_RFM_PRJ
add column YEAR_ID NUMERIC

UPDATE SALES_DATASET_RFM_PRJ
SET QTR_ID=EXTRACT(QUARTER FROM ORDERDATE)

UPDATE SALES_DATASET_RFM_PRJ
SET MONTH_ID=EXTRACT(MONTH FROM ORDERDATE)

UPDATE SALES_DATASET_RFM_PRJ
SET YEAR_ID=EXTRACT(year FROM ORDERDATE)
--5
with min_max_value as(
SELECT Q1-1.5*IQR AS min_value,
Q3+1.5*IQR AS max_value from(
select 
percentile_cont(0.25) within group (order by QUANTITYORDERED) as Q1,
percentile_cont(0.75) within group (order by QUANTITYORDERED) as Q3,
percentile_cont(0.75) within group (order by QUANTITYORDERED)-percentile_cont(0.25) within group (order by QUANTITYORDERED) as IQR
from SALES_DATASET_RFM_PRJ) as a)
select * from SALES_DATASET_RFM_PRJ
where QUANTITYORDERED <(select min_value from min_max_value)
or QUANTITYORDERED >(select max_value from min_max_value)

--c2
with cte as(
select *,
(select avg(QUANTITYORDERED) from SALES_DATASET_RFM_PRJ) as avg_,
(select stddev(QUANTITYORDERED)from SALES_DATASET_RFM_PRJ)as stdev
from SALES_DATASET_RFM_PRJ)
select *,
(QUANTITYORDERED-avg_)/stdev as z_score
from cte
where abs((QUANTITYORDERED-avg_)/stdev)>3



