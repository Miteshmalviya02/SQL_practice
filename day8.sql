-- How do you handle NULL values in SQL? Provide examples.
-- in the order table  we can see that delivery_date has null values so we can use delivery_date column
select
order_id
from orders
where delivery_date is null;

select
*,
case when delivery_date is null then "null" else delivery_date end
from orders;

-- Write a query to fetch the maximum transaction amount for each customer. 
select account_id,
max(amount) as max_amount
from transactions
group by account_id;

-- Write a query to identify the most profitable regions based on transaction data.
select
c.country,
sum(o.total_amount) as total_rev
from orders as o
join customers as c
group by cfinance_db.country
order by total_rev desc
limit 3;


-- How would you analyze customer churn using SQL 
SELECT
*
from 
accounts as a
left join customers as c
on c.customer_id = a.customer_id
left join transactions as t 
on a.account_id = t.account_id and t.transaction_date >= current_date() - interval 6 month
where t.transaction_id is null;

