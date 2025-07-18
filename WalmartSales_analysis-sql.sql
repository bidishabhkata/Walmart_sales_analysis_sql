-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;
use  walmartSales;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2,1)
);

select * from sales;

----------- FEATURE ENGINEERING-------------

-- -- Add the time_of_day column--

select time, 
(case 
		when time between'00:00:00' and '12:00:00' then "MORNING"
        when time between'12:00:00' and '16:00:00' then "AFTERNOON"
        else "EVENING"
        END) as time_of_day from sales;
        
alter table sales add column  time_of_day varchar(10) ;

update sales
	set time_of_day =(case 
		when time between'00:00:00' and '12:00:00' then "MORNING"
        when time between'12:00:00' and '16:00:00' then "AFTERNOON"
        else "EVENING"
        END) ;
        
-- day name--
select date,dayname(date) from sales;

alter table sales add column day_name varchar(20);
update sales
	set day_name= dayname(date);
  
  -- month name--
  alter table sales add column month_name varchar(15);
  update sales
  set month_name= monthname(date);

----------- GENERIC-------------

-- UNIQUE CITIES

select distinct city as unique_cities from sales;

-- in which city which branch is located

select distinct city,branch from sales  ;


----------- PRODUCT-------------


----- How many unique product lines does the data have?
select count(distinct product_line) as number_of_unique_productline from sales;

----- What is the most common payment method?
SELECT payment,count(*) as most_common_method from sales group by payment order by count(*) desc limit 1 ;

----- What is the most selling product line?
select product_line, count(product_line) as most_selling_productline from sales group by product_line order by product_line desc;

----- What is the total revenue by month?
select month_name, sum(total) as total_revenue from sales group by month_name order by total_revenue desc;

----- What month had the largest cogs?
select month_name, sum(cogs) as cogs from sales group by month_name order by cogs desc limit 1;

----- What product line had the largest revenue?
select product_line, sum(total) as total_revenue from sales group by product_line order by total_revenue desc limit 1;

----- What is the city with the largest revenue?
select city, sum(total) as total_revenue from sales group by city order by total_revenue desc limit 1 ;

----- What product line had the largest VAT?
select product_line, avg(tax_pct) as largest_vat from sales group by product_line order by largest_vat desc limit 1;

------ Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select avg(quantity) from sales;
select product_line , (case when avg(quantity) > 5.4995 then "Good" else "bad" end) as remark from sales group by product_line;

-- which branch sold more product than the average product sold?

select branch, sum(quantity) as qty from sales group by branch having sum(quantity)> (select avg(quantity) from sales) ; 

-- What is the most common product line by gender?
select gender,product_line,count(product_line) as a from sales group by gender,product_line order by a desc  limit 1;

-- What is the average rating of each product line?
select product_line,round(avg(rating),2) as avg_rating from sales group by product_line order by avg_rating desc ;


----------------- sales--------------

-- Number of sales made in each time of the day per weekday
select * from sales;
select time_of_day, count(quantity) as total_sales from sales where day_name not in("Sunday","Satureday") group by time_of_day ;


-- Which of the customer types brings the most revenue?
select customer_type, sum(total) as most_rev from sales group by customer_type order by most_rev desc;


-- Which city has the largest tax percent/ VAT (Value Added Tax)?
select city, avg(tax_pct) as largest_vat from sales group by city order by largest_vat desc;

-- Which customer type pays the most in VAT?
select customer_type, avg(tax_pct) as most_paid from sales group by customer_type order by most_paid desc;


----------------- CUSTOMER --------------------

-- How many unique customer types does the data have?
SELECT  COUNT( DISTINCT CUSTOMER_TYPE) AS COUNT FROM SALES;

-- How many unique payment methods does the data have?
SELECT  COUNT( DISTINCT payment) AS COUNT FROM SALES;

-- What is the most common customer type?
SELECT customer_type, COUNT( CUSTOMER_TYPE) AS COUNT FROM SALES group by customer_type order by count desc;

-- Which customer type buys the most?
SELECT customer_type, sum(quantity) AS COUNT FROM SALES group by customer_type order by count desc;


-- What is the gender of most of the customers?
SELECT gender, COUNT( gender) AS COUNT FROM SALES group by gender order by count desc;


-- What is the gender distribution per branch?
select gender , count(case when branch="A" then 1 end ) as branch_A,
 count(case when branch="B" then 1 end ) as branch_B,
  count(case when branch="C" then 1 end ) as branch_C
  from sales group by gender ;

-- Which time of the day do customers give most ratings?
select time_of_day , avg(rating) as most_rating from sales group by time_of_day order by most_rating desc;


-- Which day of the week has the best avg ratings?
select day_name, avg(rating) as best_avg_rating from sales group by day_name order by best_avg_rating desc;


-- Which day of the week has the best average ratings per branch?
WITH avg_ratings AS (
    SELECT
        branch,
        day_name,
        AVG(rating) AS avg_rating,
        RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rating_rank
    FROM sales
    GROUP BY branch, day_name
)
SELECT branch, day_name, avg_rating
FROM avg_ratings
WHERE rating_rank = 1;


