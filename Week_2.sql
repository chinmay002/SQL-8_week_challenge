--How many pizzas were ordered?
select count(pizza_id) from pizza_runner.customer_orders
--------------------------------------------------------------------------------------------------------------
--How many unique customer orders were made?
--select count(distinct(order_id)) from pizza_runner.customer_orders

--------------------------------------------------------------------------------------------------------------

--How many successful orders were delivered by each runner?

SELECT
	runner_id,
	COUNT(order_id) AS successful_orders
FROM pizza_runner.runner_orders
WHERE cancellation = ''
GROUP BY runner_id;
--------------------------------------------------------------------------------------------------------------

--How many of each type of pizza was delivered?
select pizza_id,count(pizza_id) from pizza_runner.customer_orders
group by pizza_id
--------------------------------------------------------------------------------------------------------------

--How many Vegetarian and Meatlovers were ordered by each customer?

select co.customer_id,pn.pizza_name,count(pn.pizza_id) from pizza_runner.customer_orders co
inner join pizza_runner.pizza_names pn
on pn.pizza_id = co.pizza_id
group by co.customer_id,pn.pizza_name
order by co.customer_id
--------------------------------------------------------------------------------------------------------------

--What was the maximum number of pizzas delivered in a single order?

with cte as (select order_id,count(*)as no_of_orders from pizza_runner.customer_orders co
inner join pizza_runner.pizza_names pn
on pn.pizza_id = co.pizza_id
group by order_id)
select max(no_of_orders) from cte
--------------------------------------------------------------------------------------------------------------

--For each customer, how many delivered pizzas had at least 1 change and how many had no changes?


SELECT 
  c.customer_id,
  SUM(
    CASE WHEN c.exclusions = ' ' OR c.extras = ' ' THEN 1
    ELSE 0
    END) AS at_least_1_change,
  SUM(
    CASE WHEN c.exclusions = ' ' AND c.extras = ' ' THEN 1 
    ELSE 0
    END) AS no_change
FROM pizza_runner.customer_orders AS c
JOIN pizza_runner.runner_orders AS r
  ON c.order_id = r.order_id
WHERE r.distance != 0
GROUP BY c.customer_id
ORDER BY c.customer_id;
--------------------------------------------------------------------------------------------------------------

--How many pizzas were delivered that had both exclusions and extras?

SELECT  
  SUM(
    CASE WHEN exclusions IS NOT NULL AND extras IS NOT NULL THEN 1
    ELSE 0
    END) AS pizza_count_w_exclusions_extras
FROM pizza_runner.customer_orders AS c
JOIN pizza_runner.runner_orders AS r
  ON c.order_id = r.order_id
WHERE r.distance >= 1 
  AND exclusions = ' ' 
  AND extras = ' ';
--------------------------------------------------------------------------------------------------------------  

--What was the total volume of pizzas ordered for each hour of the day?

select extract(hour from order_time) as hour_of_day,count(pizza_id) from pizza_runner.customer_orders
group by 1
order by 1 asc
--------------------------------------------------------------------------------------------------------------

--What was the volume of orders for each day of the week?

select extract(dow from order_time) as hour_of_day,count(pizza_id) from pizza_runner.customer_orders
group by 1
order by 1 asc
