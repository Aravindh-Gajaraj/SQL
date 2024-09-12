# SQL

# Question 1

Social Media Addiction can be a crippling disease affecting millions every year.

We need to identify people who may fall into that category.

Write a query to find the people who spent a higher than average amount of time on social media.

Provide just their first names alphabetically so we can reach out to them individually.

with CTE AS
  (SELECT FIRST_NAME, AVG(MEDIA_TIME_MINUTES) AS USER_AVG_TIME
FROM user_time UT INNER JOIN users U 
ON UT.USER_ID = U.USER_ID
GROUP BY U.USER_ID
HAVING USER_AVG_TIME > (SELECT AVG(MEDIA_TIME_MINUTES) FROM user_time)
ORDER BY first_name)

SELECT first_name from CTE;
