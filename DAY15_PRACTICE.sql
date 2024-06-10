--ex1
SELECT EXTRACT(year from transaction_date) as year, 
product_id,spend as curr_year_spend,
lag(spend) OVER(PARTITION BY product_id) as prev_year_spend,
ROUND(((spend-lag(spend) OVER(PARTITION BY product_id))/lag(spend) OVER(PARTITION BY product_id))*100,2) as yoy_rate
FROM user_transactions
--ex2
WITH t1 as (
select *, rank() over(partition by card_name order by issue_year, issue_month) as rnk
from monthly_cards_issued)
SELECT card_name, issued_amount
from t1
where rnk=1
ORDER BY issued_amount DESC
--ex3
WITH t1 as (
SELECT *,
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date ) as rnk
FROM transactions)
SELECT user_id,	spend,transaction_date from t1
WHERE rnk=3
--ex4
with t1 AS(
SELECT transaction_date,user_id,
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC ) AS rnk
FROM user_transactions)
SELECT transaction_date,user_id,
COUNT(*) as purchase_count
from t1
WHERE rnk=1
GROUP BY transaction_date, user_id
ORDER BY transaction_date
--ex5
  with t1 as(
SELECT user_id,tweet_date,tweet_count,
lag (tweet_count) OVER(PARTITION BY user_id ORDER BY tweet_date) as period1,
lag (tweet_count,2) OVER(PARTITION BY user_id ORDER BY tweet_date) as period2
FROM tweets)
SELECT user_id,tweet_date,
CASE
when period1 is NULL and period2 is NULL then tweet_count*1.00
when period1 is not null and period2 is NULL then ROUND((tweet_count + period1)/2.00 ,2)
ELSE ROUND((tweet_count+period1+period2)/3.00,2)
END as rolling_avg_3d
from t1
--ex 6
WITH t1 as (
SELECT *,
EXTRACT(MINUTE FROM (transaction_timestamp-
lag(transaction_timestamp)OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp))) as time_diff
FROM transactions)
select COUNT(merchant_id) as payment_count
FROM t1
where time_diff<=10
--ex7
with t1 as (
select category,product,
SUM(spend) as total_spend,
RANK()OVER(PARTITION BY category ORDER BY SUM(spend) DESC) as rnk
from product_spend
WHERE EXTRACT(year from transaction_date)='2022'
GROUP BY category,product)
SELECT category,product,total_spend
from t1 
WHERE rnk<=2
ORDER BY category, rnk
--ex8
WITH T1 AS (
SELECT 
  artists.artist_name,
  DENSE_RANK() OVER (ORDER BY COUNT(songs.song_id) DESC) AS artist_rank
FROM artists
INNER JOIN songs
  ON artists.artist_id = songs.artist_id
INNER JOIN global_song_rank AS ranking
  ON songs.song_id = ranking.song_id
WHERE ranking.rank <= 10
GROUP BY artists.artist_name)
SELECT  artist_name, artist_rank
FROM T1
WHERE  artist_rank<=5
