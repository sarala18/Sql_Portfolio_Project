select * from PortfolioProject..pizza_sales

/*Question1-find the sum of total price of all ordered pizzas*/
select sum(total_price) 
As Total_Revenue 
from PortfolioProject..pizza_sales

/*Question2-find the  average amount spent for order*/
select sum(total_price) /count(Distinct order_id) 
as avg_order_value 
from PortfolioProject..pizza_sales

/*Question3-find the total number of pizzas sold*/
select sum(quantity)
AS Total_Pizza_Sold 
from PortfolioProject..pizza_sales

/*Question4-find the total number of orders placed*/
select count(distinct order_id ) 
AS Total_orders 
from PortfolioProject..pizza_sales

/*Question5-find the average number of pizzas sold per order*/
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/ 
CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL(10,2)) 
AS Avg_Pizzas_Per_order 
from PortfolioProject..pizza_sales

/*Question6- fin the Hourly Trend  of total orders throughout the day*/
select datepart(hour, order_time) as order_hours , count(distinct order_id) as Total_orders 
from PortfolioProject..pizza_sales
group by datepart(hour, order_time)
order by datepart(hour, order_time)

/*Question7- Daily Trend of total orders over a specific period of time*/
select datename(DW, order_date) as order_day , count(distinct order_id) as Total_orders
from PortfolioProject..pizza_sales
group by datename(DW, order_date)

/*Question8- find the Percentage of sales accoss different pizza categories*/
select pizza_category, sum(total_price) as Total_Sales, sum(total_price) * 100 /
(select sum(total_price) from PortfolioProject..pizza_sales where month(order_date) =1) as PCT
from PortfolioProject..pizza_sales
where month(order_date)=1
group by pizza_category

/*Question9- find the Percentage of sales attributed to different pizza sizess*/
select pizza_size, sum(total_price) as Total_Sales, sum(total_price) * 100 /
(select sum(total_price) from PortfolioProject..pizza_sales where month(order_date) =1) as PCT
from PortfolioProject..pizza_sales
where datepart(quarter, order_date)=1 
group by pizza_size
order by PCT desc

/*Question10- find out the total number of pizzas sold for each pizza category*/
select pizza_category ,sum(quantity) as Total_pizzas_sold
from PortfolioProject..pizza_sales
group by pizza_category

/*Question11-find out who are the Top 5 pizzas seller bases on the total number of pizzas sold*/
select top 5 pizza_name, sum(quantity) as Total_Pizzas_sold
from PortfolioProject..pizza_sales
where month(order_date)=8
group by pizza_name
order by sum(quantity) asc
