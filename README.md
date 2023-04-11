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

G. Here we query a list of the minimium number of days a customer waited from the collection of repeated customers along with the number of days waited and we clubbed the first name,last name and customername altogther to define them as customer details together. 
**Functions used**:_ CTE, CONCAT, window function LAG, PARTITION BY, OVER, DATEDIFF, aggregate function MIN_.

H. Create a list of customers along with number of orders placed and sales made. We ranked them in reducing order of sales made i.e. revenue. 
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

**Key Takeaways:**
1. Approximate total sale is ten million thirty-two thousand six hundred twenty-eight.
2. The dataset contains a total of 307 separate orders.
3. We can see that no sale was made after May,2005. Highest sale was made in November,2004.
4. Comparing records of 2003 with that of 2004, we can say total number of orders as well as total sales has increased from 2003.
5. 4th quarter is most selling quarter while first quarter is the least.
6. Month of November has made highest sale while March is the least selling month. So,one should advertise before month of March to maximise sales.
7. Out of 91 different customers, Leslie Young of Boards & Toys Co. waited maximum number of days after ordering once and Diego Freyre of Euro Shopping Channel has the minimum of 1 days wait before two consecutive orders.
8. D.Freyre of Euro Shopping Channel has brought in maximum revenue of 912294.11 in a total of 26 orders made by him.
9. 11 out of 92 different customers turned out to be premium customers by making a total sale of greater than or equal to 150000.
10. Sale was made from 19 different countries.Maximum sale was made by USA.
11. Madrid of Spain had made the maximum sale amongst all the cities around all other countries.
12. Trains are the least ordered item and Classic cars are the most ordered item based on the data.
13. S18_3232 a model of Classic Cars is the most sold product around all the orders.


////////////////////////////////
The CSV data file is attached in the repository.

One can get the same data online through the link: https://www.kaggle.com/datasets/kyanyoga/sample-sales-data
The SQL file contains the code/query to carry out above tasks.
Everyone is kindly requested to share their feedbacks on the project with me. 
Thank you
