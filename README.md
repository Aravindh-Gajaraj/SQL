# SQL Query Collection - Analyst Builder SQL Questions



Overview
This repository contains a collection of SQL queries designed to solve various real-world business problems. Each query is carefully crafted to address specific scenarios ranging from identifying social media addiction to calculating salary increases, analyzing sales performance, and much more. The goal is to showcase efficient SQL solutions for common data analysis tasks, utilizing features like joins, Common Table Expressions (CTEs), window functions, and conditional logic.

Query Descriptions

1. Identifying Social Media Addiction

Objective: Find users who spend a higher than average amount of time on social media.
Key Concepts: Aggregation, Subqueries, Filtering
The query calculates the average time spent on social media across all users and then filters out users who spend above the average. The results are ordered alphabetically by first name for easy outreach.

2. Salary Increases by Employee Level

Objective: Calculate salary increases based on employee levels.
Key Concepts: CASE statements, Conditional Logic
This query assigns different salary increase percentages based on the employee’s level in the company (10% for Level 1, 15% for Level 2, and 200% for Level 3). The new salary is included in the result set.

3. Manager Direct Reports
   
Objective: Determine how many direct reports each manager has.
Key Concepts: Joins, Aggregation
This query identifies managers (identified by “Manager” in their job title) and counts their direct reports. It groups the data by manager ID and job title to return a comprehensive report on management hierarchy.

4. Dessert Sales Contest: Cakes vs. Pies
   
Objective: Compare the sales of cakes and pies and determine which sold more.
Key Concepts: Conditional Logic, Subqueries, Aggregation
This query calculates the daily difference in sales between cakes and pies. It also uses a CASE statement to determine whether more cakes or pies were sold on each day, displaying the result in a positive number for easy interpretation.

5. Kelly's Ice Cream Shop - 3rd Purchase Discount
   
Objective: Find the 3rd purchase for each customer and apply a 33% discount.
Key Concepts: Window Functions, Partitioning, Ranking
Using the DENSE_RANK() function, the query identifies the 3rd transaction for each customer and applies a 33% discount. It returns the customer ID, transaction details, and the discounted amount.

6. Shrinkflation Detection
   
Objective: Identify products that have undergone shrinkflation (reduced size but increased or same price).
Key Concepts: Calculations, Conditional Logic
This query compares the changes in product size and price to determine if shrinkflation occurred. It outputs a flag (True/False) to indicate whether a product has undergone shrinkflation, along with the percentage changes in size and price.

7. High Earners in Each Department
   
Objective: Find the top three highest earners in each department.
Key Concepts: Window Functions, Ranking
This query uses the DENSE_RANK() function to rank employees based on their salaries within each department and filters the result to show only the top three highest earners per department.

8. User Confirmation Rate
   
Objective: Calculate the confirmation rate for each user based on confirmation messages received.
Key Concepts: Joins, Conditional Aggregation, Rounding
This query calculates the confirmation rate by dividing the number of confirmed messages by the total number of requested confirmation messages. Users with no requested confirmation messages have a default confirmation rate of 0. The result is rounded to two decimal places.

Key Concepts Demonstrated
CTEs (Common Table Expressions): Many queries use CTEs to improve readability and break down complex calculations.
Joins: Various types of joins (INNER, LEFT) are used to combine data from multiple tables.
Aggregation: Functions like SUM(), COUNT(), and AVG() are used extensively for data summarization.
Window Functions: The use of DENSE_RANK() for ranking results within specific partitions.
Conditional Logic: CASE statements are utilized for dynamic calculations based on specific conditions.
Subqueries: Employed to perform calculations on aggregated data and use the result in further operations.
