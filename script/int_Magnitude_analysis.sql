-- Magnitude Analysis it is use to compare measures values by categories and dimensions to generate insights

-- 1) Find the total customers by countries

Select country, COUNT(customer_id) AS Total_customers
From gold.dim_customers
Group by country
order by Total_customers desc

--2) Find the total customer by gender

Select gender, COUNT(customer_id) AS Total_customer
	From gold.dim_customers
	group by gender
	order by Total_customer desc

--3) Total product by category

select category, COUNT(Product_Id) As total_product
From gold.dim_products
Group by category
order by total_product desc

--4) Find the average cost in each category

Select category, Avg(cost) AS Avg_cost
From gold.dim_products
Group by category
order by Avg_cost desc

--5) Find the total revenue generated for each category

Select p.category, sum(f.sales_amount) as Total_revenue
FROM gold.fact_sales AS f 
Left JOIN gold.dim_products AS P 
ON P.product_key = f.product_key
Group by p.category
Order by Total_revenue desc

-- 6) find the total revenue genrated by each customer

Select c.customer_id, c.first_name as Customer_first_name, c.last_name as Customer_last_name, Sum(f.sales_amount) as total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON c.customer_key = f.customer_key
Group by c.customer_id,first_name, last_name
Order by total_revenue desc

-- 7) what is the distribution of sold items across countries?

Select c.country, SUM(f.quantity) as total_sold_items
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers as c
ON c.customer_key = f.customer_key
Group by country
order by total_sold_items desc
-- it help us to know which country is generating more buiness for us.

-- the low cardinality dimensions are dimensions with few unique values like category gender,country etc
-- high cardinality dimensions are dimensions with large unique Values like products, customers, address etc
-- number of rows as results depends on the cardinality of the dimensions


--- Rnaking Analysis
-- 1) which 5 products generate the highest revenue (The best performing products)

Select TOP 5
p.Product_name, SUM(f.sales_amount) As Revenue
FROM gold.fact_sales AS f
LEFT JOIN GOLD.dim_products AS p
ON p.product_key = f.product_key
Group by product_name
order by Revenue desc

-- 2) What are the 5 worst performing products in trems of sales?

Select Top 5
p.Product_name, SUM(f.sales_amount) As Revenue
FROM gold.fact_sales AS f
LEFT JOIN GOLD.dim_products AS p
ON p.product_key = f.product_key
Group by product_name
order by Revenue 

-- using window function to solve the rank analysis

Select *
FROM
	(
Select 
p.Product_name, SUM(f.sales_amount) As Revenue,
row_number () OVER (Order by SUM(f.sales_amount) DESC) as rank_product
FROM gold.fact_sales AS f
LEFT JOIN GOLD.dim_products AS p
ON p.product_key = f.product_key
Group by product_name)t
where rank_product <=5

-- find the top 10 customers who have generated the highest revenue 

Select TOP 10
 c.customer_id, c.first_name as Customer_first_name, c.last_name as Customer_last_name, Sum(f.sales_amount) as total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON c.customer_key = f.customer_key
Group by c.customer_id,first_name, last_name
Order by total_revenue desc

-- and 3 customers with the fewerest orders placed
Select TOP 3
 c.customer_id, c.first_name as Customer_first_name, c.last_name as Customer_last_name, count(distinct order_number) as total_order_placed
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON c.customer_key = f.customer_key
Group by c.customer_id,first_name, last_name
Order by total_order_placed 
