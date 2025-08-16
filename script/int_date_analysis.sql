/*

-- Explore the date dimension in our data

-- we use the DATEDIFF function to chekc for our date difference

-- find the date of the first and last order

*/

select MIN(order_date) AS First_order_date, MAX(Order_date) AS Last_order_date,
  
datediff(Month, min(order_date), max(order_date)) AS Date 
  
From gold.fact_sales

-- find the youngest and oldest customers AND FOR US TO SEE THE AGE --
  
select MIN(birthdate) As Oldest_customer_birthday,
  
		DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
  
		 MAX(birthdate) As Youngest_customer_birthday,
  
		 Datediff (year, MAX(birthdate),GETDATE()) AS Youngest_age
  
		from gold.dim_customers
