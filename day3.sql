select * from customers;
select * from order_items;
select * from orders;

-- 1.Scenario:
-- Your manager wants to see which customers have made more than one completed order and what their total spending is.
-- Task:
-- Write a SQL query to:
-- Display each customer’s first_name, last_name, city,
-- Show their number of completed orders and total spent amount (sum of total_amount),
-- Only include customers with more than one “Completed” order,
-- Sort the result by total_spent DESC.


select 
c.customer_id,
c.first_name,
c.last_name,
c.city,
count(o.order_id) as num_of_completed_orders,
sum(o.total_amount) as total_spent
from customers as c
join orders as o
on c.customer_id = o.customer_id
where o.status = 'Completed'
group by
c.customer_id,
c.first_name,
c.last_name,
c.city
having num_of_completed_orders > 1
order by total_spent desc;

-- 2.The marketing team wants to target high-value customers — those whose total spending is above the average total spending across all customers.
-- Task:
-- Write a SQL query to:
-- Find each customer’s total spending (sum of total_amount for completed orders only).
-- Compare that total to the average total spending of all customers.
-- Return only those customers whose total spending is greater than the overall average.

select 
	c.customer_id,
	c.first_name,
	c.last_name,
	sum(total_amount) as total_spending
from customers as c
join orders as o
	on c.customer_id = o.customer_id
	where o.status = 'Completed'
group by c.customer_id,
	c.first_name,
	c.last_name
having sum(total_amount) > (	
	select avg(total_customer) from (
		select sum(total_amount) as total_customer
		from orders 
		where status = 'Completed'
		group by customer_id
        ) as sub
		)
        order by total_spending desc;
        
-- 3.Your e-commerce manager wants to rank customers based on their total spending (considering only Completed orders).
-- They want to identify top spenders per city — for example, “Top 3 customers in each city.”
-- Task
-- Write a SQL query to:
-- Calculate each customer’s total spending from Completed orders.
-- Assign a rank within their city based on spending (highest spender = rank 1).
-- Return only the top 3 customers per city.
select 
*
from (
	select 
		c.city,
		c.customer_id,
		c.first_name,
		c.last_name,
	sum(total_amount) as total_spending,
	dense_rank() over(partition by city order by sum(total_amount) desc) ranks
	from customers as c
	join orders as o
	on c.customer_id = o.customer_id
    where o.status = 'Completed'
	group by c.city,c.customer_id,
	c.first_name,
	c.last_name
) as rank_city
where ranks <=3 
order by total_spending desc;

-- 4.Task
-- Write a SQL query to:
-- Calculate each customer’s total spending (from completed orders).
-- Assign a customer_tier using CASE WHEN.
-- Order results by total_spending DESC. 

select
c.customer_id,
c.first_name,
c.last_name,
sum(o.total_amount) as total_spending,
case 
when sum(o.total_amount) >=800 then 'Platinum'
when sum(o.total_amount) between 500 and 799 then 'Gold'
when sum(o.total_amount) between  200 and 499 then 'Silver'
else 'Bronze' end as Customer_Tier_Classification
from customers as c
join orders as o 
on c.customer_id = o.customer_id
where o.status = 'Completed'
group by 
c.customer_id,
c.first_name,
c.last_name
order by total_spending desc
;

-- Your manager wants a report that shows monthly revenue trends and identifies customer performance tiers each month.
-- Specifically, for every month:
-- Calculate total revenue from Completed orders.
-- Calculate each customer’s total spending for that month.
-- Classify customers as:
-- 🏆 Top → top 10% of spenders in that month
-- 💎 Medium → middle 40%
-- 🥉 Low → bottom 50%

select * 
,
case 
when spend_tier = 1 then 'TOP'
when spend_tier = 2 then 'Medium'
else 'Low' end as performance_tier
from (
select 
month(o.order_date) as month_num,
c.customer_id,
first_name,
sum(total_amount) as total_spending,
ntile(3) over(partition by month(o.order_date) order by sum(total_amount) desc) as spend_tier 
from customers as c
join orders as o
on c.customer_id = o.customer_id
where o.status = 'Completed'
group by month_num,
c.customer_id,
first_name
) as ranked
order by month_num;




