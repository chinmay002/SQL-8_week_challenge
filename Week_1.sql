/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?

SELECT
  	s.customer_id,
    sum(m.price)
  
FROM dannys_diner.sales s
inner join  dannys_diner.menu m
on s.product_id = m.product_id
group by s.customer_id


----------------------------------------------------------------------
-- 2. How many days has each customer visited the restaurant?

select customer_id,count(distinct(order_date)) from dannys_diner.sales
group by 1
order by 2 desc

----------------------------------------------------------------------
-- 3. What was the first item from the menu purchased by each customer?

with cte as(
SELECT
  	s.customer_id,
  	s.order_date,
    m.product_name,
    row_number() over (partition by s.customer_id order by s.order_date,m.product_id asc)as rnk
  
FROM dannys_diner.sales s
inner join  dannys_diner.menu m


on s.product_id = m.product_id)

select customer_id,product_name from cte
where cte.rnk=1

----------------------------------------------------------------------
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?


select customer_id,count(*) from dannys_diner.sales
where product_id=(
select top_id.product_id from(SELECT
  	m.product_id,
    count(m.product_id) 
FROM dannys_diner.sales s
inner join  dannys_diner.menu m
on s.product_id = m.product_id
group by 1
order by 2 desc
limit 1) top_id
)
group by 1
