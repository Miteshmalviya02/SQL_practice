-- 1. Write a query to list all customers who joined after March 2022, showing their full name, city, country, and      signup date, ordered by the most recent signup first. 
select 
	concat(first_name,' ',last_name) as full_name,
	city,
	country,
	signup_date
from customers
where signup_date >= '2022-03-01'
order by signup_date desc ;

-- 2. Find the total amount spent by each customer on completed orders.
-- Show their full name, country, total_spent, and number_of_orders — sorted by the highest spend first.

select 
	concat(first_name,' ',last_name) as full_name,
	round(sum(p.price * o.quantity), 2) AS total_spent,
   	 c.country,
	 count(order_id) as number_of_orders
from customers as c
join orders as o
	on c.customer_id = o.customer_id
join products as p
	on o.product_id = p.product_id
where o.status = "completed"
group by full_name,country
order by total_spent desc;

-- 3. Find customers who have spent more than $1500 total on completed orders, grouped by their country.
--     Show their full name, country, total_spent, and number_of_completed_orders.
--     Then, for each country, show only customers above that $1500 threshold.
select 
	concat(c.first_name,' ',c.last_name) as full_Name,
	c.country,
	round(sum(o.quantity * p.price),2) as total_Spent,
	count(o.order_id) as number_of_orders
from customers as c
join orders as o
	on c.customer_id = o.customer_id
join products as p
	on o.product_id = p.product_id
where o.status = 'Completed'
group by full_name,c.country
having total_spent > 1500
order by c.country,total_spent desc;


-- 4.Customer Order Summary (Conditional Aggregation)
-- For each customer, show:
-- •	Their full name
-- •	Their country
-- •	Total number of orders
-- •	Number of completed orders
-- •	Number of pending orders
-- •	Total amount spent on completed orders

select
	concat(c.first_name,' ',c.last_name) as full_name,
    c.country,
    count(o.order_id) as total_number_of_orders,
    count(case when o.status = 'Completed' then 1 else 0 end) as total_completed_orders,
    count(case when o.status = 'Pending' then 1 else 0 end) as total_pending_orders,
    sum(case when o.status = 'Completed' then o.quantity * p.price else 0 end) as total_spent_completed 
from customers as c
join orders as o
	on c.customer_id = o.customer_id
join products as p
	on o.product_id = p.product_id
group by full_name,c.country;

-- 5. Find the total revenue per product category per month, based on completed orders only.
-- Your output should include:
-- •	Year-Month (e.g., '2023-01')
-- •	Category
-- •	Total Sales (Rounded)
-- •	Number of Completed Orders
select 
	p.category,
	concat(month(order_date),'-',year(order_date)) as month_year,
	round(sum(p.price * o.quantity),2) as total_revenue,
	count(case when o.status = 'Completed' then 1 else 0 end) as total_completed_order
from orders as o
join products as p
	on o.product_id = p.product_id
where o.status = 'Completed'
group by p.category,month_year;



