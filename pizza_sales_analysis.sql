-- A. Key Performance Indicators (KPIs)

-- 1. Total Revenue
-- Calculates the sum of total_price to get the total revenue from pizza sales
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- 2. Average Order Value
-- Divides total revenue by the number of unique orders to find the average order value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sales;

-- 3. Total Pizzas Sold
-- Sums the quantity column to get the total number of pizzas sold
SELECT SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales;

-- 4. Total Orders
-- Counts distinct order_id values to get the total number of orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;

-- 5. Average Pizzas Per Order
-- Calculates the average number of pizzas per order, rounded to 2 decimal places
SELECT ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 2) AS Avg_Pizzas_per_order 
FROM pizza_sales;

-- B. Daily Trend for Total Orders
-- Groups orders by the day of the week and counts distinct orders for each day
SELECT DAYNAME(order_date) AS order_day, 
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY DAYNAME(order_date);

-- C. Hourly Trend for Orders
-- Groups orders by the hour of the day and counts distinct orders for each hour
SELECT HOUR(order_time) AS order_hours, 
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY HOUR(order_time) 
ORDER BY HOUR(order_time);

-- D. Percentage of Sales by Pizza Category
-- Calculates total revenue and percentage of total sales for each pizza category
SELECT pizza_category, 
       ROUND(SUM(total_price), 2) AS total_revenue, 
       ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS PCT 
FROM pizza_sales 
GROUP BY pizza_category;

-- E. Percentage of Sales by Pizza Size
-- Calculates total revenue and percentage of total sales for each pizza size
SELECT pizza_size, 
       ROUND(SUM(total_price), 2) AS total_revenue, 
       ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS PCT 
FROM pizza_sales 
GROUP BY pizza_size 
ORDER BY pizza_size;

-- F. Total Pizzas Sold by Pizza Category (February Only)
-- Sums the quantity of pizzas sold in February, grouped by pizza category
SELECT pizza_category, 
       SUM(quantity) AS Total_Quantity_Sold 
FROM pizza_sales 
WHERE MONTH(order_date) = 2 
GROUP BY pizza_category 
ORDER BY Total_Quantity_Sold DESC;

-- G. Top 5 Best Sellers by Total Pizzas Sold
-- Selects the top 5 pizza names by total quantity sold, ordered descending
SELECT pizza_name, 
       SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Total_Pizza_Sold DESC 
LIMIT 5;

-- H. Bottom 5 Sellers by Total Pizzas Sold
-- Selects the bottom 5 pizza names by total quantity sold, ordered ascending
SELECT pizza_name, 
       SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY Total_Pizza_Sold ASC 
LIMIT 5;