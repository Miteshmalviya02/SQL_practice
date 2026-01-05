-- 1.How do you use a CASE statement in SQL? Provide an example. 
-- it let us write logic within a query if else conditions 
select 
first_name,
last_name,
salary,
case when salary > 50000 then "High" else "Low" end as cat_salary
from 
employees
order by salary desc;


-- 2.Write a query to calculate the cumulative sum of sales. 
select 
distinct product_id,
order_date,
sum(amount) over(partition by product_id order by order_date desc)
from orders;

--  3.how CTE is used with Example

with cte_name as (
select 
product_id,
sum(amount) as total_rev
from orders
group by product_id
order by total_rev desc)
select
*
from cte_name
limit 3;

-- 4.Write a query to identify customers who have made transactions above $5,000 multiple times. 
select
account_id,
count(*) as high_value
from transactions
where amount >=5000
group by account_id
having count(*)>1;


-- 5.Write a query to find all customers who have not made any purchases in the last 6 months.

select 
*
from customers 
where  customer_id not in (
		select
		c.customer_id
		from customers as c
		left join orders as o
		on c.customer_id = o.customer_id
		where order_date <= current_date() - interval 6 month
);





