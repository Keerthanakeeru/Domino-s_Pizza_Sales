use dominos;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));

create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id));
select * from orders;
select * from pizza_types;
select * from order_details;
select * from pizzas;

-- Retrieve the total number of orders placed.
select count(order_id) as Total_orders from orders;
-- Output : 21350

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Total_Sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
-- Output :817860.05
    
-- Identify the highest-priced pizza
select pizza_types.name , pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc
limit 1;
-- Output :The Greek Pizza	35.95

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS ordercount
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
LIMIT 1;
-- Output :M	15385

-- List the top 5 most ordered pizza types along with their quantities.
SELECT pizza_types.name,
       SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;
-- Output :The Classic Deluxe Pizza	    2453
        -- The Barbecue Chicken Pizza	2432
        -- The Hawaiian Pizza	        2422
        -- The Pepperoni Pizza	        2418
        -- The Thai Chicken Pizza	    2371

-- Find the total quantity of each pizza category ordered.
select pizza_types.category,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;
-- Output : Classic 	14888
          -- Supreme	11987
          -- Veggie 	11649
          -- Chicken	11050

-- Determine the distribution of orders by hour of the day.
select hour(order_time), count(order_id) from orders
group by hour(order_time);
-- Output :   11	1231
           -- 12	2520
           -- 13	2455
           -- 14	1472
           -- 15	1468
           -- 16	1920
           -- 17	2336
           -- 18	2399
           -- 19	2009
           -- 20	1642
           -- 21	1198
           -- 22	663
           -- l23	28
           -- 10	8
           -- 9 	1

-- To find the category-wise distribution of pizzas.
select category , count(name) from pizza_types group by category;
-- Output :  Chicken	   6
          -- Classic       8
          -- Supreme	 9
          -- Veggie	    9


-- Calculate the average number of pizzas ordered per day .
select round(avg(quantity),0)  as avg_pizza_ordered_per_day from 
(select orders.order_date, sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date) as order_quantity;
-- Output : 138

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name, 
sum(order_details.quantity *pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;
-- Output :   The Thai Chicken Pizza	      43434.25
           -- The Barbecue Chicken Pizza	  42768
           -- The California Chicken Pizza	  41409.5

-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;
-- Output :  Classic	   26.91
          -- Supreme	   25.46
          -- Chicken	   23.96
          -- Veggie	       23.68

-- Analyze the cumulative revenue generated over time .
select order_date,
sum(revenue)over(order by order_date) as cum_revenue
from
(select orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as sales;
-- Output :   2015-01-01	    2713.8500000000004
           -- 2015-01-02	    5445.75
           -- 2015-01-03	    8108.15
           -- 2015-01-04	    9863.6
           -- 2015-01-05	    11929.55
           -- 2015-01-06	    14358.5
           -- 2015-01-07	    16560.7
           -- 2015-01-08	    19399.05
           -- 2015-01-09	    21526.4
           -- 2015-01-10	    23990.350000000002
-- Over all i am getting 358 rows but i displayed here only 10 .

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name, revenue from 
(select category ,name, revenue,
rank() over(partition by category order by revenue desc) as rn
from 
(select pizza_types.category, pizza_types.name , 
sum((order_details.quantity)*pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category , pizza_types.name) as a ) as b where rn <=3;
-- Output :  The Thai Chicken Pizza	           43434.25
          -- The Barbecue Chicken Pizza	       42768
          -- The California Chicken Pizza	   41409.5
          -- The Classic Deluxe Pizza	       38180.5
          -- The Hawaiian Pizza	               32273.25
          -- The Pepperoni Pizza	           30161.75
          -- The Spicy Italian Pizza	       34831.25
          -- The Italian Supreme Pizza	       33476.75
          -- The Sicilian Pizza	               30940.5
          -- The Four Cheese Pizza	           32265.70000000065
          -- The Mexicana Pizza	               26780.75
          -- The Five Cheese Pizza	           26066.5




