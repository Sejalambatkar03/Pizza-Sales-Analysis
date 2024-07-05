SELECT * FROM pizza_sales;
----KPI CALCULATIONS----
SELECT * FROM pizza_sales;
--1. Calculate the Total Revenue
SELECT SUM(total_price) as Total_Revenue from pizza_sales;

--2. Calculate the Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) as Average_Order_Value from pizza_sales;

--3. Calculate the Total Pizza Sold 
SELECT SUM(quantity) as Total_Pizza_Sold  from pizza_sales;

--4. Calculate the Total Orders Placed
SELECT COUNT(DISTINCT order_id ) as Total_Orders from pizza_sales;

--5. Calculate the Average Pizza Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id)  AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
AS Average_Pizza_Per_Order
from pizza_sales;

SELECT * FROM pizza_sales;

---DAILY TREND FOR TOTAL ORDER---
SELECT DATENAME(DW, order_date) as Order_day , COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales
group by DATENAME(DW,order_date);

---HOURLY TREND FOR ORDERS ---
SELECT DATEPART(HOUR,order_time) as Order_Hour ,COUNT(DISTINCT order_id) as Total_order from pizza_sales
group by DATEPART(HOUR,order_time)
order by DATEPART(HOUR,order_time);

---% of Sale By Pizza Category ---
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Revenue,
CAST(SUM(total_price) *100 / (SELECT SUM(total_price) from pizza_sales) 
AS DECIMAL(10,2)) AS Percentage_Pizza_Category
from pizza_sales
group by pizza_category;

---% of Sale By Pizza Size ---
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Revenue,
CAST(SUM(total_price) *100 / (SELECT SUM(total_price) from pizza_sales) 
AS DECIMAL(10,2)) AS Percentage_Pizza_Size
from pizza_sales
group by pizza_size
order by pizza_size;

---Total Pizza Sold By Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Pizza_Sold
from pizza_sales 
--where MONTH(order_date) = 5      ---To Calculate the month  wise pizza sold add this where condition
group by pizza_category 
order by Total_Pizza_Sold desc;

--- Top 5 Best Seller By Total Pizza Sold
SELECT * FROM pizza_sales;
SELECT top 5 pizza_name , SUM(quantity) as Total_Pizza_Sold 
from pizza_sales 
--where MONTH(order_id) = 8
Group by pizza_name 
order by SUM(quantity) desc;

--- Bottom 5 Worst Seller By Total Pizza Sold
SELECT top 5 pizza_name , SUM(quantity) as Total_Pizza_Sold 
from pizza_sales 
Group by pizza_name 
order by SUM(quantity) asc;

--- Total Pizza Sold by Pizza Category Quaterly 
SELECT pizza_category,SUM(quantity) as Total_Pizza_Sold_Quaterly
from pizza_sales 
where DATEPART(QUARTER,order_date) = 3
group by pizza_category
order by Total_Pizza_Sold_Quaterly desc;
