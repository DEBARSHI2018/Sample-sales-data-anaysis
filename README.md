# Sample-sales-data-anaysis 
_Analysis on SQL using Microsoft SQL Server 18_


In this project, I aimed to analyze the sample sales data using SQL to find meaningful statements that would throw some light regarding the characteristics of the dataset.

A. First, we start by getting a gross idea about total sales and total number of order placed over the whole region by all customers.
**Functions used**: _Aggregate functions SUM, COUNT_

B. We look for the number of orders placed for each month of year only to affirm the fact that the data does not exist for any sales made June,2005 onwards.
**Functions used**: _COUNT, DISTINCT, YEAR, MONTH_

C. We query appropriately to get a picture of sales and number of orders for each year. This query leads us to realize the number of orders made as well as the number of sales is increasing over the years.
**Functions used**: _COUNT, SUM, ROUND, YEAR_

D. Make a quarterly sales study for the two years to  extract that 4th quarter is the best time for sales while first quarter has the lowest sales.
**Functions used**: _YEAR, MONTH, SUM, ROUND, CASE statement, WHERE, GROUP BY, ORDER BY_

E. Query specifically to find the highest and lowest selling month, which are November and June respectively.
**Functions used**: _YEAR, MONTH, SUM, ROUND_

F. We attempt to draw a rough image of gradual increase in total sales(also known as cumulative sum)
**Functions used**: _YEAR, SUM, ROUND,CAST,JOIN(self join), CTE_

G. Here we query a list of the minimium number of days a customer waited from the collection of repeated customers along with the number of days waited and we clubbed the first name,last name and customername altogther to define them as customer details together. Out of 91 different customers, Leslie Young of Boards & Toys Co. waited maximum number of days after ordering once and Diego Freyre of Euro Shopping Channel has the minimum of 1 days wait before two consecutive orders.
**Functions used**:_ CTE, CONCAT, window function LAG, PARTITION BY, OVER, DATEDIFF, aggregate function MIN_.

H. Create a list of customers along with number of orders placed and sales made. We ranked them in reducing order of sales made i.e. revenue. D.Freyre of Euro Shopping Channel is the customer who made maximum revenue while ordering most of the times too.
**Functions used**: _CTE, CONCAT, window function RANK, PARTITION BY, OVER, NULL, ROUND, aggregate function SUM_.

I. Query made classification on data as 'PREMIUM' and 'REGULAR' customers based whther total sales made by him/her is above or below 150000.
**Functions used**: _CONCAT, CASE statement, aggregate function SUM,ROUND_.

J. Classification of data based on country over 19 different countries. USA made maximum sales and Ireland made the least.
**Functions used**: _aggregate function SUM,ROUND,GROUP BY, ORDER BY_.

K. Query the city with biggest total sales amount for each country.
**Functions used**: _CTE, ROUND, JOIN(inner join), aggregate function SUM,MAX_.

L. Query the number of orders made of each size to realize 'Large' are few in count in comparison to others.

M. Find the most  and least bought products,Classic Cars & Trains, respectively. 

N. In this last query, we will churn out which is the most sold model in each product category(i.e. productline) and arrange them in descending order of count of sales.
**Functions used**: _CTE, JOIN(inner join),AND, aggregate function SUM,MAX_.
////////////////////////////////
The CSV file is attached in the repository.
The SQL file contains the code/query to carry out above tasks.
Everyone is kindly requested to share their feedbacks on the project with me. 
Thank you
