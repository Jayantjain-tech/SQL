-- Calculate the total number of Orders placed 
select count(order_id) from orders

-- Calculate the total revemnue from the pizza sales
select sum(order_details.quantity * pizzas.price) as Revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id

-- Identify the highest priced pizza
select name, price
from pizza_types join pizzas 
on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by price desc limit 1
 
-- Identify the most common pizza size ordered

select size,
count(order_details_id) as Size_Ordered
from pizzas join order_details
on order_details.pizza_id = pizzas.pizza_id 
group by  size 

-- Join the top 5 most ordered pizza types along with their quantities

select pizza_types.name, sum(order_details.quantity) as Quantity from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by name order by Quantity desc limit 5

--  Join the relevant  tables to find the total quantity of each pizza category ordered

select pizza_types.category, sum(order_details.quantity) as quantity
from pizza_types 
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by category order by quantity desc

-- Determine the top 3 most ordered pizza types based on revenue

select pizza_types.name, sum(order_details.quantity * pizzas.price) as revenue 
from pizza_types 
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by name order by revenue desc limit 3 

--  Determine the top 3 most ordered pizza types based on revenue for each pizza category

select pizza_types.name as pizza_Types, category, sum(order_details.quantity * pizzas.price) as revenue
from pizza_types 
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by name, category order by revenue desc limit 3

-- 	Find the average price of all pizzas

select pizza_types.name, round(avg(pizzas.price),2) as Average_Sales from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by name  order by Average_Sales desc

-- 	Calculate the total revenue from pizza sales.

select round(sum(pizzas.price * order_details.quantity),2) as Revenue
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id

-- Find the maximum price among all pizza sizes.

select min(price) as Lowest_price, max(price) as Highest_price from pizzas

-- 	Count the total number of orders in the dataset.

select count(order_id) from order_details 

-- Find the minimum quantity ordered in any order.
select order_details.order_id, sum(quantity) as Orders from order_details
group by order_id order by orders asc 

-- Calculate the difference between the highest and lowest pizza prices

select round(max(price) - min(price),2) as Pricedifference from pizzas 

-- Find the sum of all quantities sold for each pizza type.

select pizza_types.pizza_type_id, sum(order_details.quantity) as Quantity_Sold
from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.pizza_type_id order by Quantity_sold asc
 
-- Get the distinct count of customers who placed orders.

select count(distinct order_id) from order_details

-- Calculate the average order value.

select pizza_id, avg(quantity) from order_details
group by pizza_id 

-- 	Find the total revenue by each branch

select pizza_types.category, round(sum(order_details.quantity * pizzas.price),2) as Total_revenue
from pizza_types
join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by category order by Total_revenue asc

-- -- 	List all orders where the quantity is greater than 3 

select order_details.order_id, sum(order_details.quantity)  from order_details
group by order_details.order_id  
having sum(order_details.quantity) > 3
order by sum(order_details.quantity) asc;

-- Show all orders where the total price is between $10 and $15.

   SELECT order_details.order_id, (order_details.quantity * pizzas.price) AS Price
    FROM order_details
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    WHERE price BETWEEN 10 AND 15
    
-- 	Find all orders where the pizza name contains "Cheese" 

	SELECT order_details.order_id, pizza_types.name from pizzas
	join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
	join order_details on pizzas.pizza_id = order_details.pizza_id
	WHERE pizza_types.name LIKE  '%Cheese%' 
    
    -- List all orders with quantities more than or equal to 2.

select order_details.order_id, quantity from order_details
where quantity >= 2

-- List all orders with pizza name and quantities more than or equal to 2.

select pizza_types.name,order_details.order_id, quantity from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
where quantity >= 2

-- Find orders with a quantity greater than the average order quantity.

SELECT * FROM order_details
WHERE quantity > (SELECT AVG(quantity) FROM order_details);

 -- String Operations --
 
 -- Retrieve all pizza names in uppercase.

Select upper(name) from pizza_types

-- Replace "Cheese" with "Vegan Cheese" in all pizza names.

select Replace(name, "Cheese", "Vegan Cheese") from Pizza_types

-- Flag orders as "Bulk" if the quantity is greater than 5, else "Single".
SELECT order_id, quantity,
    CASE 
        WHEN quantity > 5 THEN 'Bulk' ELSE 'Single'
    END AS order_type
FROM order_details;

-- Add a new column indicating whether the order total exceeds 15 (Yes/No).

Select order_id, (quantity * price),
case
 when (quantity * price) > 15 then 'Yes' Else 'No' End as New
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id

-- Add a column that shows "Weekend" or "Weekday" based on the order date

select order_id, date,
CASE WHEN DAYOFWEEK(date) IN (1, 7) THEN 'Weekend' ELSE 'Weekday'
END AS Day from orders

-- Assign ratings to orders: "High" for totals > $50, "Medium" for $30-$50, "Low" for <$30.

Select order_id, (quantity*price),
case when (quantity*price) > 20 then 'high'
when (quantity*price) < 10 then 'low'
else 'medium'
end as Ratings
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id

-- 	Calculate the total revenue for each pizza name. 

select name, round(sum(Quantity*price),2) as Revenue from pizzas
join order_details on order_details.pizza_id = pizzas.pizza_id
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by name

-- Find the most frequently ordered pizza type

select pizza_type_id, count(order_id) as Order_count from pizzas
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_type_id order by order_count desc

-- Find the least popular pizza size.


select size, count(order_id) as Order_count from pizzas
join order_details on order_details.pizza_id = pizzas.pizza_id
group by size order by order_count desc

--	Get the total quantity sold for each pizza type and size combination. 

select pizza_type_id, size, sum(order_details.quantity) from pizzas
join order_details on pizzas.pizza_id = order_details.pizza_id 
group by pizza_type_id, size

-- Compute the cumulative growth rate in sales.

select date, sum(revenue) 
over(order by date) as Monthly_Revenue from
(select date, round(sum(quantity*price),0) as Revenue from orders
join order_details 
on orders.order_id = order_details.order_id
join pizzas 
on order_details.pizza_id = pizzas.pizza_id
group by date) as sales;

-- Find the most popular order time (hour of the day)


select hour(time), count(quantity) as OrderPerHour from orders
join order_details on order_details.order_id = orders.order_id
group by hour(time) order by Orderperhour desc limit 1

-- Calculate the total revenue for each pizza Category.

select category, sum(quantity*price) as Revenue from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id 
group by category

