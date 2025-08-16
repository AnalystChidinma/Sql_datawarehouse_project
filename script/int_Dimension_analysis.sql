--- Dimension Exploration

-- Identify the unique values (or categories) in each dimension.

-- recognizing how data might be grouped or segmeneted, which is useful for later analysis

-- and the prouct types we have in our database.

-- for diamension, we use distict for granuality 

-- 1) -- Explore  all countried our customers come from

select Distinct Country FROM gold.dim_customers

--2) Explore All categories "The Major Divisions"

Select Distinct category, subcategory, product_name from gold.dim_products
Order By 1,2,3
