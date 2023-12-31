SELECT * FROM [Sales Data ].[dbo].[Sales Data]

-----------KPI's-------- 

-- 1. Total Revenue 
SELECT SUM(sales) AS Total_revenue 
FROM [Sales Data ].[dbo].[Sales Data]

-- 2. Average Order Value 
SELECT SUM(Sales)/COUNT(DISTINCT Order_ID) AS Average_order_value 
FROM [Sales Data ].[dbo].[Sales Data]

-- 3. Total Products Sold 
SELECT SUM(Quantity_Ordered) AS Total_products_sold 
FROM [Sales Data].[dbo].[Sales Data]

-- 4. Total Orders 
SELECT COUNT(DISTINCT ORDER_ID) 
FROM [Sales Data].[dbo].[Sales Data]

-- 5. Average Value per Order 
SELECT SUM(Quantity_Ordered)/COUNT(DISTINCT ORDER_ID) AS Avg_value_per_Order 
FROM [Sales Data].[dbo].[Sales Data]


------------ANALYSIS --------------- 
--Q1: Analysis of Products BY REVENUE 
--A: Top 5 Bestseller Products according to revenue

SELECT TOP 5 Product, ROUND(SUM(Sales),2) AS total_revenue 
FROM [Sales Data].[dbo].[Sales Data]
GROUP BY Product
ORDER BY total_revenue DESC 

--B: Bottom 5 Products according to revenue

SELECT TOP(5)Product, ROUND(SUM(Sales),2) AS total_revenue 
FROM [Sales Data].[dbo].[Sales Data]
GROUP BY  Product
ORDER BY total_revenue ASC
 
--Q2: Analysis of Products BY QUANTITY

--A: Top 5 Bestseller Products according to quantity 

SELECT TOP(5)Product, SUM(Quantity_Ordered) As Total_quantity  
FROM [Sales Data].[dbo].[Sales Data]
GROUP BY  Product
ORDER BY Total_quantity DESC 

--B: Bottom 5 Products according to quantity 

SELECT TOP(5)Product, SUM(Quantity_Ordered) As Total_quantity  
FROM [Sales Data].[dbo].[Sales Data]
GROUP BY  Product
ORDER BY Total_quantity ASC 

-- Q3: Analysis of Products BY TOTAL ORDERS  

--A: Top 5 Products according to total orders 
SELECT TOP 5 Product, COUNT(DISTINCT ORDER_ID) AS total_orders 
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY Product
ORDER BY total_orders DESC 

--B: Bottom 5 Products according to total Orders 
SELECT TOP 5 Product, COUNT(DISTINCT ORDER_ID) AS total_orders 
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY Product
ORDER BY total_orders ASC 

-- ANALYSIS OF CITIES 
--Q4: Cities based on Revenue 
-- Which city has the maximum revenue (Bestseller City Based on Revenue)

SELECT TOP 2 City, ROUND(SUM(Sales),2) AS revenue 
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY City
ORDER BY revenue DESC

-- Which city has the minimum revenue (WORSTSELLER City Based on Revenue) 

SELECT TOP 2 City, ROUND(SUM(Sales),2) AS revenue 
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY City
ORDER BY revenue ASC

--Q5: Cities based on Quantity 
-- Which city has the maximum number of quantity purchased (Bestseller City Based on Total Quantity)

SELECT City, SUM(Quantity_Ordered) As Total_quantity  
FROM [Sales Data].[dbo].[Sales Data]
GROUP BY  City
ORDER BY Total_quantity DESC 

---Q6: Cities based on Total Orders 
-- Which city has the maximum number of orders placed (Bestseller City Based on Total Order)  

SELECT  City, COUNT(ORDER_ID) AS number_of_orders
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY City 
ORDER BY number_of_orders DESC 
 
-- How many number of orders placed in each week (Daily trend for total orders) 

SELECT DATENAME(DW,Order_Date) AS Order_day, COUNT(DISTINCT ORDER_ID) AS number_of_orders
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY DATENAME(DW,Order_Date)
ORDER BY number_of_orders DESC

--How many number of orders placed in each month (Monthly trend for total orders) 

SELECT Month, COUNT(DISTINCT ORDER_ID) AS number_of_orders, SUM(Sales) AS Total_revnue
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY Month 
ORDER BY number_of_orders DESC

--How many number of orders placed in each hour (Hourly trend for total orders) 
SELECT Hour, COUNT(DISTINCT ORDER_ID) AS number_of_orders
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY Hour 
ORDER BY number_of_orders DESC

-- Percentage of Sales by Products 
SELECT Product, 
       ROUND(SUM(Sales),2) AS total_sales, 
       ROUND(SUM(Sales)*100/(SELECT SUM(Sales) FROM [Sales Data ].[dbo].[Sales Data]),2) AS PCT_of_Sales 
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY Product
ORDER BY PCT_of_Sales DESC 

-- Percentage of Sales by City 
SELECT City,
       ROUND(SUM(Sales),2) AS total_sales, 
       ROUND(SUM(Sales)*100/(SELECT SUM(Sales) FROM [Sales Data ].[dbo].[Sales Data]),2) AS PCT_of_Sales 
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY City 
ORDER BY PCT_of_Sales DESC 

-- Total Products Sold by City 
SELECT SUM(Quantity_Ordered) AS Total_Products_Sold,
       City
FROM [Sales Data ].[dbo].[Sales Data]
GROUP BY City 
ORDER BY Total_Products_Sold DESC

-- AS City San Fransisco has maximum Revenue 

-- Which product contributes to maximum revenue and minimum revenue? 
SELECT City, Product, 
       ROUND(SUM(sales),2) AS revenue,
	   ROUND(SUM(Sales)*100/(SELECT SUM(Sales) FROM [Sales Data ].[dbo].[Sales Data]),2) AS PCT_of_sales
FROM [Sales Data ].[dbo].[Sales Data]
WHERE City = 'San Francisco' 
GROUP BY City, Product 
ORDER BY revenue DESC

-- In which month city San Fransisco has Maximum Revenue and Minimum Revenue?  
  
SELECT City, Month, 
       ROUND(SUM(sales),2) AS revenue,
	   ROUND(SUM(Sales)*100/(SELECT SUM(Sales) FROM [Sales Data ].[dbo].[Sales Data]),2) AS PCT_of_sales
FROM [Sales Data ].[dbo].[Sales Data]
WHERE City = 'San Francisco' 
GROUP BY City, Month 
ORDER BY revenue DESC

-- On which day city has maximum and minimum revenue in december month? 
SELECT City, Month,
       DATENAME(DW,Order_date) AS Order_day,  
       ROUND(SUM(sales),2) AS revenue,
	   ROUND(SUM(Sales)*100/(SELECT SUM(Sales) FROM [Sales Data ].[dbo].[Sales Data]),2) AS PCT_of_sales
FROM [Sales Data ].[dbo].[Sales Data]
WHERE City = 'San Francisco' AND Month = '12' 
GROUP BY City, Month, DATENAME(DW,Order_date) 
ORDER BY revenue DESC

-- AS City Austin has minimum Revenue 

-- Which product contributes to minimum revenue? 
SELECT City, Product, 
       ROUND(SUM(sales),2) AS revenue,
	   ROUND(SUM(Sales)*100/(SELECT SUM(Sales) FROM [Sales Data ].[dbo].[Sales Data]),2) AS PCT_of_sales
FROM [Sales Data ].[dbo].[Sales Data]
WHERE City = 'Austin' 
GROUP BY City, Product 
ORDER BY revenue ASC

-- In which month city Austin has Minimum Revenue?  
  
SELECT City, Month, 
       ROUND(SUM(sales),2) AS revenue,
	   ROUND(SUM(Sales)*100/(SELECT SUM(Sales) FROM [Sales Data ].[dbo].[Sales Data]),2) AS PCT_of_sales
FROM [Sales Data ].[dbo].[Sales Data]
WHERE City = 'Austin' 
GROUP BY City, Month 
ORDER BY revenue ASC

-- On which day city Austin has minimum revenue in december month? 
SELECT City, Month,
       DATENAME(DW,Order_date) AS Order_day,  
       ROUND(SUM(sales),2) AS revenue,
	   ROUND(SUM(Sales)*100/(SELECT SUM(Sales) FROM [Sales Data ].[dbo].[Sales Data]),2) AS PCT_of_sales
FROM [Sales Data ].[dbo].[Sales Data]
WHERE City = 'Austin' AND Month = '12' 
GROUP BY City, Month, DATENAME(DW,Order_date) 
ORDER BY revenue ASC
       
