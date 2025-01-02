# Pizza Sales Analysis SQL Queries

## Overview
This repository contains a comprehensive set of SQL queries designed to analyze various aspects of pizza sales, orders, and customer behaviors. These queries are structured to extract insights, compute metrics, and facilitate business decisions.

## Features
The queries are categorized into different analytical objectives, covering a broad range of use cases:

### 1. Order Analysis
- **Total Orders:** Calculate the total number of orders placed.
- **Most Common Pizza Size:** Identify the most popular pizza size ordered.
- **Orders with Specific Conditions:** Find orders based on criteria like quantity, total price, and pizza name.
- **Orders Exceeding Averages:** Retrieve orders that surpass the average quantity.

### 2. Revenue Analysis
- **Total Revenue:** Calculate the total revenue generated from pizza sales.
- **Revenue by Pizza Category:** Determine revenue contributions by each pizza category.
- **Top Revenue Generating Items:** Identify the top 3 most ordered pizza types based on revenue.
- **Revenue for Each Pizza Name:** Compute total revenue for individual pizza types.

### 3. Pricing and Quantity Analysis
- **Highest and Lowest Prices:** Identify the price range of pizzas.
- **Price Differences:** Calculate the difference between the highest and lowest pizza prices.
- **Total Quantity Sold:** Find the sum of quantities sold for each pizza type and size.
- **Average Prices and Order Values:** Compute average prices and order values.

### 4. Popularity Metrics
- **Most Ordered Items:** Identify the top 5 most ordered pizza types by quantity.
- **Least Popular Items:** Determine the least popular pizza size.
- **Most Frequently Ordered Times:** Find the most popular hour of the day for orders.

### 5. String Operations
- **Modify Pizza Names:** Convert pizza names to uppercase or replace keywords like "Cheese" with "Vegan Cheese."
- **Categorization:** Flag orders as "Bulk" or "Single" and assign ratings based on order totals.

### 6. Advanced Aggregations
- **Cumulative Sales:** Compute the cumulative growth rate in sales over time.
- **Revenue Grouping:** Aggregate revenue by pizza categories and order dates.

### 7. Other Metrics
- **Distinct Customer Count:** Count the total number of unique customers.
- **Day Classification:** Classify orders based on whether they were placed on a weekday or weekend.

## Usage
1. **Database Setup:** Ensure the database contains the following tables:
   - `orders`
   - `order_details`
   - `pizzas`
   - `pizza_types`
2. **Run Queries:** Execute the queries in a SQL client connected to the database.
3. **Modify as Needed:** Customize the queries for specific business needs or additional insights.

## Examples
- **Find all orders with the pizza name containing "Cheese":**
  ```sql
  SELECT order_details.order_id, pizza_types.name 
  FROM pizzas
  JOIN pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
  JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
  WHERE pizza_types.name LIKE '%Cheese%';
  ```

- **Calculate the average order value:**
  ```sql
  SELECT pizza_id, AVG(quantity) 
  FROM order_details
  GROUP BY pizza_id;
  ```

