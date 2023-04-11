--Querying the complete dataset
SELECT *
FROM sales_data_sample;
select  distinct STATUS 
from  sales_data_sample;
select  distinct YEAR_ID 
from  sales_data_sample;
select  distinct PRODUCTLINE 
from  sales_data_sample;
select  distinct COUNTRY 
from  sales_data_sample;
select  distinct DEALSIZE 
from  sales_data_sample;
select  distinct TERRITORY 
from  sales_data_sample;

--Total sales
SELECT SUM(SALES ) AS total_sale_made
FROM sales_data_sample;
--Approximate total sale is ten million thirty-two thousand six hundred twenty-eight

--Total number of orders made
SELECT COUNT(DISTINCT ORDERNUMBER) AS number_of_orders_made
FROM sales_data_sample;
--The dataset contains a total of 307 separate orders.

--Number of sales on each month of each year
SELECT YEAR(orderdate) AS year_, MONTH(orderdate) AS month_, COUNT(DISTINCT ORDERNUMBER ) AS total_no_of_orders_placed
FROM sales_data_sample
GROUP BY YEAR(orderdate), MONTH(orderdate)
ORDER BY YEAR(orderdate), MONTH(orderdate)
--We can see that no sale was made after May,2005. Highest sale was made in November,2004.

--Yearly sales vs. number of orders
SELECT  YEAR(ORDERDATE) AS year_ ,COUNT(distinct ORDERNUMBER) AS NO_OF_ORDERS,ROUND(SUM(SALES),2) AS YEARLY_SALES
FROM sales_data_sample
WHERE YEAR(ORDERDATE) !=2005
GROUP BY YEAR(ORDERDATE)
--Comparing records of 2003 with that of 2004, we can say total number of orders as well as total sales has increased from 2003.

--Quarterly sales distribution
SELECT quarter,SUM(monthly_sale) AS quarterly_sale
FROM (SELECT MONTH(ORderdate) AS month_, CASE WHEN MONTH(ORDERDATE) IN (1,2,3) THEN 'FIRST QUARTER'
WHEN MONTH(ORDERDATE) IN (4,5,6) THEN 'SECOND QUARTER'
WHEN MONTH(ORDERDATE) IN (7,8,9) THEN 'THIRD QUARTER'
ELSE 'FOURTH QUARTER' END AS quarter
,ROUND(SUM(SALES),2) AS monthly_sale 
FROM sales_data_sample
WHERE YEAR(ORDERDATE) !=2005
GROUP BY MONTH(ORDERDATE) )q
GROUP BY quarter
ORDER BY quarterly_sale DESC;
--4th quarter is most selling quarter while first quarter is the least.

--Highest month of sales
SELECT top 1 MONTH(ORDERDATE) AS month_ ,ROUND(SUM(SALES),2) AS monthly_sale 
FROM sales_data_sample
WHERE YEAR(ORDERDATE) !=2005
GROUP BY MONTH(ORDERDATE) 
ORDER BY SUM(SALES) DESC;
--Lowest month of sales
SELECT top 1 MONTH(ORDERDATE) AS month_ ,ROUND(SUM(SALES),2) AS monthly_sale 
FROM sales_data_sample
WHERE YEAR(ORDERDATE) !=2005
GROUP BY MONTH(ORDERDATE) 
ORDER BY SUM(SALES) ASC;
--Month of November has made highest sale while March is the least selling month. So,one should advertise before month of March to maximise sales.

--Running sum of sales with date
With sd AS(SELECT CAST(ORDERDATE as date) AS dates_,ROUND(SUM(sales),2) AS daily_sale 
FROM sales_data_sample
WHERE YEAR(ORDERDATE) !=2005
GROUP BY ORDERDATE)
SELECT a.dates_,a.daily_sale,SUM(b.daily_sale ) AS cumlative_sale
FROM sd a JOIN sd b
ON a.dates_>=b.dates_
GROUP BY a.dates_,a.daily_sale
ORDER BY a.dates_ 
--This gives an ides on visualizing how cumulative sales curve will vary over date.


--Minimum interval between two ordering for each customer
WITH consecutive_order_list AS(SELECT CONCAT( CUSTOMERNAME,'--',' ',CONTACTFIRSTNAME,' ',CONTACTLASTNAME) AS CUSTOMER_DETAILS,ORDERDATE,
LAG(ORDERDATE,1) OVER(PARTITION BY CONCAT( CUSTOMERNAME,'--',' ',CONTACTFIRSTNAME,' ',CONTACTLASTNAME) 
ORDER BY CONCAT( CUSTOMERNAME,'--',' ',CONTACTFIRSTNAME,' ',CONTACTLASTNAME),ORDERDATE) AS PREVIOUS_ORDERDATE
FROM sales_data_sample
GROUP BY CONCAT( CUSTOMERNAME,'--',' ',CONTACTFIRSTNAME,' ',CONTACTLASTNAME),ORDERDATE),
day_diff_list AS(SELECT c.CUSTOMER_DETAILS, DATEDIFF(day,C.PREVIOUS_ORDERDATE,C.ORDERDATE) AS consecutive_differences
FROM consecutive_order_list c
WHERE c.PREVIOUS_ORDERDATE IS NOT NULL)
SELECT d.CUSTOMER_DETAILS,MIN(d.consecutive_differences) AS shortest_interval_in_days
FROM day_diff_list d
GROUP BY d.CUSTOMER_DETAILS
ORDER BY shortest_interval_in_days DESC ;
--Out of 91 different customers, Leslie Young of Boards & Toys Co. waited maximum number of days after ordering once
-- and Diego Freyre of Euro Shopping Channel has the minimum of 1 days wait before two consecutive orders.

--Customer acquisition
WITH cust_sales AS(SELECT CONCAT( CUSTOMERNAME,'--',' ',substring(CONTACTFIRSTNAME,1,1),'.',CONTACTLASTNAME) AS CUSTOMER_DETAILS,count(DISTINCT ORDERNUMBER) AS NO_OF_TIMES_ORDERED,
ROUND(SUM(SALES),2) AS Revenue
FROM sales_data_sample
GROUP BY CUSTOMERNAME,CONTACTLASTNAME,CONTACTFIRSTNAME)
SELECT *,RANK() OVER(PARTITION BY (SELECT NULL) ORDER BY Revenue DESC) AS rank_of_customer
FROM cust_sales ;
--D.Freyre of Euro Shopping Channel has brought in maximum revenue of 912294.11 in a total of 26 orders made by him.


--Classification between premium and regular customers(dependeing on whether total is above or below 150000)
SELECT CONCAT( CUSTOMERNAME,'--',' ',CONTACTFIRSTNAME,' ',CONTACTLASTNAME) AS CUSTOMER_DETAILS,ROUND(SUM(SALES),2) AS TOTAL_ORDER_AMOUNT,
CASE WHEN SUM(SALES)>=150000 THEN 'PREMIUM'
ELSE 'REGULAR' END AS TYPE_OF_CUSTOMER
FROM sales_data_sample
GROUP BY CUSTOMERNAME,CONTACTLASTNAME,CONTACTFIRSTNAME
ORDER BY CUSTOMERNAME,CONTACTLASTNAME,CONTACTFIRSTNAME;
--Customers ordered over 150000 are considered as 'PREMIUM' customers while others are treated as 'REGULAR's.


--Countrywise sales
SELECT COUNTRY,ROUND(SUM(SALES),2) AS sales_countrywise
FROM sales_data_sample
GROUP BY COUNTRY
ORDER BY SUM(SALES)  ;
--Sale was made from 19 different countries.

--Which city has the highest number of sales for each country
WITH citywise_totals AS(SELECT COUNTRY,CITY, ROUND(SUM(sales),2) AS city_sales
FROM sales_data_sample
GROUP BY COUNTRY,CITY),
max_sold AS(SELECT COUNTRY,MAX( city_sales) AS max_sale
FROM citywise_totals
GROUP BY COUNTRY)
SELECT citywise_totals.COUNTRY,citywise_totals.CITY, max_sold.max_sale
FROM citywise_totals JOIN max_sold
ON citywise_totals.city_sales= max_sold.max_sale
ORDER BY max_sold.max_sale DESC;
--Outputs maximum sale made by a city and the amount of it, grouped for different countries However, Madrid of Spain had made the maximum sale.

--How many itemorders are made on a particular dealsize
SELECT DEALSIZE,count( ORDERNUMBER ) AS no_of_deals_made
FROM sales_data_sample
GROUP BY DEALSIZE;
--Very few large size deals are made compared to the other two.

--Productwise orders
select PRODUCTLINE,COUNT(*) AS no_of_items_ordered
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY no_of_items_ordered ASC
--Trains are least ordered item and Classic cars are most ordered item based on the data.

--Productline in which maximum number of a model is sold
WITH sales_per_model AS(SELECT PRODUCTLINE ,PRODUCTCODE, SUM(QUANTITYORDERED ) AS no_of_items_sold
FROM sales_data_sample
GROUP BY  PRODUCTCODE,PRODUCTLINE),
group_maxs AS(SELECT spm.PRODUCTLINE,MAX(spm.no_of_items_sold ) AS max_quantity
FROM sales_per_model spm
GROUP BY spm.PRODUCTLINE )
SELECT gm.PRODUCTLINE,sales_per_model.PRODUCTCODE AS max_selling_model ,gm.max_quantity AS max_quantity_sold
FROM sales_per_model JOIN group_maxs gm
ON sales_per_model.no_of_items_sold=gm.max_quantity
AND sales_per_model.PRODUCTLINE=gm.PRODUCTLINE
ORDER BY gm.max_quantity DESC
--This query pulls model number(i.e. PRODUCTCODE) of items sold the most for every single products(PRODUCTLINE).


