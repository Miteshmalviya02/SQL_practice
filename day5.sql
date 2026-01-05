select * from accounts;
select * from customers;
select * from transactions;

-- Write a query to find each customer’s total deposited amount (sum of “Deposit” transactions only), along with their city, account count, and average account balance.
-- Show only customers who have more than one account and total deposits above 10,000.
-- Sort results by total deposits (descending).

select
	c.customer_id,
	c.city,
	round(sum(t.amount),2) as total_deposited_amount,
	count(a.account_id) as account_count,
	round(avg(a.balance),2) as avg_account_balance
from accounts as a
join transactions as t
on a.account_id = t.account_id
join customers as c
on c.customer_id = a.customer_id
where transaction_type = 'Deposit'
group by
c.customer_id
having sum(t.amount) > 10000
order by total_deposited_amount desc;

-- 2.For each customer, show their latest transaction date, total deposits, total withdrawals, and a customer activity status based on these rules:
-- 🟢 'Active' → if the latest transaction is within the last 365 days
-- 🟡 'Dormant' → if the latest transaction is older than 365 days
-- 🔴 'No Transactions' → if they have no transactions at all


select 
c.customer_id, c.full_name,
max(t.transaction_date) as latest_transaction,
round(sum(case when t.transaction_type = 'Deposit' then t.amount else 0 end),2) as total_deposits,
round(sum(case when t.transaction_type = 'Withdrawal' then t.amount else 0 end),2) as total_withdrawals,
CASE 
    WHEN MAX(t.transaction_date) IS NULL THEN 'No Transactions'
    WHEN DATEDIFF(CURDATE(), MAX(t.transaction_date)) <= 365 THEN 'Active'
    ELSE 'Dormant'
  END AS status
FROM customers c
LEFT JOIN accounts a
  ON c.customer_id = a.customer_id
LEFT JOIN transactions t
  ON a.account_id = t.account_id
GROUP BY c.customer_id, c.full_name
ORDER BY latest_transaction DESC;


-- Write a query to find the top 3 customers (by total transaction amount) in each city.

select *
from (
select
c.city,
c.full_name,
sum(amount) as total_transaction_amount,
RANK() OVER (PARTITION BY city ORDER BY SUM(t.amount) DESC) as city_rank
FROM customers c
JOIN accounts a
  ON c.customer_id = a.customer_id
JOIN transactions t
  ON a.account_id = t.account_id
  group by c.city,c.full_name ) as t
  where city_rank <=3
  order by total_transaction_amount desc;
  
  
  

  
  
 