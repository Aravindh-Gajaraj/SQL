## ANALYST BUILDER SQL QUESTIONS ##

## QUESTION 1 ##

## Social Media Addiction can be a crippling disease affecting millions every year ##

## We need to identify people who may fall into that category. ##

## Write a query to find the people who spent a higher than average amount of time on social media. ##

## Provide just their first names alphabetically so we can reach out to them individually. ##

with CTE AS
  (SELECT FIRST_NAME, AVG(MEDIA_TIME_MINUTES) AS USER_AVG_TIME
FROM user_time UT INNER JOIN users U 
ON UT.USER_ID = U.USER_ID
GROUP BY U.USER_ID
HAVING USER_AVG_TIME > (SELECT AVG(MEDIA_TIME_MINUTES) FROM user_time)
ORDER BY first_name)

SELECT first_name from CTE;


## QUESTION 2 ##

## If our company hits its yearly targets, every employee receives a salary increase depending on what level you are in the company. ##

## Give each Employee who is a level 1 a 10% increase, level 2 a 15% increase, and level 3 a 200% increase. ##

## Include this new column in your output as "new_salary" along with your other columns. ##

SELECT employee_id, pay_level, salary,
CASE 
  WHEN PAY_LEVEL = 1 THEN SALARY + (SALARY * 0.10) 
  WHEN PAY_LEVEL = 2 THEN SALARY + (SALARY * 0.15)
  WHEN PAY_LEVEL = 3 THEN SALARY + (SALARY * 2)
  ELSE SALARY
END AS new_salary
  FROM employees;
  
  ## QUESTION 3 ##
  
  ## Write a query to determine how many direct reports each Manager has. ##

  ## Note: Managers will have "Manager" in their title. ##

  ## Report the Manager ID, Manager Title, and the number of direct reports in your output. ##
  
  SELECT b.employee_id as manager_id, b.position, count(*) as direct_reports FROM direct_reports a 
  inner join direct_reports b on 
  a.managers_id = b.employee_id
  where b.position LIKE '%Manager'
  group by b.employee_id, b.position;
  
  ## QUESTION 4 ##
  
## Marcie's Bakery is having a contest at her store. Whichever dessert sells more each day will be on discount tomorrow. She needs to identify which dessert is selling more. ##

## Write a query to report the difference between the number of Cakes and Pies sold each day. ##

## Output should include the date sold, the difference between cakes and pies, and which one sold more (cake or pie). The difference should be a positive number. ##

## Return the result table ordered by Date_Sold. ##

## Columns in output should be date_sold, difference, and sold_more. ##

SELECT DATE_SOLD, ABS(CAKE_COUNTS - PIE_COUNTS) AS DIFFERENCE,
CASE 
  WHEN PIE_COUNTS > CAKE_COUNTS THEN 'Pie' 
  ELSE 'Cake' 
END AS SOLD_MORE
FROM

  (SELECT DATE_SOLD,
SUM(CASE WHEN PRODUCT = 'Cake' THEN AMOUNT_SOLD ELSE 0 END) AS CAKE_COUNTS,
SUM(CASE WHEN PRODUCT = 'Pie' THEN AMOUNT_SOLD ELSE 0 END) AS PIE_COUNTS
FROM desserts
GROUP BY DATE_SOLD) AS SUB_Q;

## QUESTION 5 ##

## At Kelly's Ice Cream Shop, Kelly gives a 33% discount on each customer's 3rd purchase.

## Write a query to select the 3rd transaction for each customer that received that discount. Output the customer id, transaction id, amount, 
## and the amount after the discount as "discounted_amount". ##

## Order output on customer ID in ascending order. ##

## Note: Transaction IDs occur sequentially. The lowest transaction ID is the earliest ID. ##

WITH CTE AS


(SELECT customer_id, transaction_id, amount,
dense_rank() OVER(PARTITION BY CUSTOMER_ID ORDER BY TRANSACTION_ID) AS CUS_RANK
FROM purchases)

SELECT customer_id, transaction_id, amount,
amount - (amount * 33 / 100) AS discounted_amount
FROM CTE WHERE CUS_RANK = 3;

## QUESTION 6 ##

## Write a query to identify products that have undergone shrink-flation over the last year. Shrink-flation is 
## defined as a reduction in product size while maintaining or increasing the price. ##

## Include a flag for Shrinkflation. This should be a boolean value (True or False) indicating whether the product has undergone shrink-flation ##

## The output should have the columns Product_Name, Size_Change_Percentage, Price_Change_Percentage, and Shrinkflation_Flag. ##

## Round percentages to the nearest whole number and order the output on the product names alphabetically. ##

SELECT PRODUCT_NAME,
ROUND((NEW_SIZE - ORIGINAL_SIZE) / ORIGINAL_SIZE * 100) AS size_change_percentage,
ROUND((NEW_PRICE - ORIGINAL_PRICE) / ORIGINAL_PRICE * 100) AS price_change_percentage,
CASE
  WHEN new_size IS NOT NULL THEN 'True'
  ELSE 'False'
END AS shrinkation_flag
from products
order by product_name;

## QUESTION 7 ##

## A company's executives are interested in seeing who earns the most money in each of the company's departments. ##
## A high earner in a department is an employee who has a salary in the top three unique salaries for that department.##

## Write a solution to find the employees who are high earners in each of the departments. ##

## Return the result table in any order. ##

## The result format is in the following example. ##

WITH CTE AS(

SELECT D.NAME AS DEPARTMENT, E.NAME AS EMPLOYEE, E.SALARY, 
DENSE_RANK() 
OVER(PARTITION BY D.NAME ORDER BY E.SALARY DESC) AS SALARY_RANK 
FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON E.DEPARTMENTID = D.ID
)


SELECT DEPARTMENT,EMPLOYEE,SALARY FROM CTE WHERE SALARY_RANK BETWEEN 1 AND 3;

## QUESTION 8 ##

## The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. ##
## The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places. ##

## Write a solution to find the confirmation rate of each user. ## 

## Return the result table in any order. ##

WITH CTE AS

(SELECT S.USER_ID,
SUM(CASE WHEN ACTION = 'confirmed' THEN 1 ELSE 0 END) AS CONFIRMED_COUNTS,
COUNT(ACTION) AS TOTAL_COUNTS 
FROM SIGNUPS S LEFT JOIN CONFIRMATIONS C ON 
S.USER_ID = C.USER_ID
GROUP BY USER_ID)

SELECT USER_ID, IFNULL(ROUND((CONFIRMED_COUNTS/TOTAL_COUNTS), 2), 0.0) AS CONFIRMATION_RATE FROM CTE
ORDER BY CONFIRMATION_RATE ASC;
  
  