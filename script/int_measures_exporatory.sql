---- EXPLORING THE MEASURES (THIS IS ALL ABOUT CALCULATING AND FINDING THE AGGREGATE OF OUR DATA.

-- FIND THE TOTAL SALES

Select sum(sales_amount) AS Total_Revenue from gold.fact_sales 

-- HOW MANY ITEMS ARE SOLD
  
Select SUM(quantity) AS Items_sold from gold.fact_sales

-- find the average selling price
  
Select Avg(price) AS Avg_Price from gold.fact_sales as Avg_price -- the buiness is selling expensive items for us to have an avg sales of 486

-- Total Number of orders
  
Select COUNT(order_number) AS Total_orders from gold.fact_sales
Select COUNT(distinct order_number) AS Total_orders from gold.fact_sales
select * from gold.fact_sales

-- (this is use to convert a text to numeric and then sum it
--- SELECT SUM(CAST(OrderAmount AS DECIMAL(10,2))) 
--- FROM Orders;)

-- total number of products
  
select COUNT(distinct product_key) from gold.dim_products

-- total number of customers
  
Select count (customer_id) from gold.dim_customers

-- total number of customer that has placed an order
  
select count(distinct customer_key) as total_customer  from gold.fact_sales

  
PROJECT
-- Generate a report that shows all key metric of our buiness

Select 'Total sales' as Measure_name, SUM(sales_amount) AS Measure_Value FROM gold.fact_sales
UNION ALL
Select 'Total Quantitites' AS Measure_name, SUM(quantity) AS Measure_Value From gold.fact_sales
UNION ALL
Select 'Avg Sales' as Measure_name, Avg(price) AS Measure_Value From gold.fact_sales
UNION ALL
Select 'Order number' as Measure_name, COUNT(distinct order_number) AS Measure_Value From gold.fact_sales
UNION ALL
select 'Total Product' as Measure_name, COUNT(distinct product_key) AS Measure_Value from gold.dim_products
UNION ALL
Select 'Total Customer' as Measure_name, count (customer_id) AS Measure_Value from gold.dim_customers
UNION ALL
select 'customer who made sales' as Measure_name, count(distinct customer_key) AS Measure_Value from gold.fact_sales

--- This give you the full big pictures of the business. put them in one query to have a big picture of your buiness. 
