-- Invalid Tweets

SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;

-- -----

-- Fix Names in a Table

SELECT user_id , CONCAT(UPPER(LEFT(name, 1)), LOWER(RIGHT(name, LENGTH(name) - 1))) as name FROM Users
ORDER BY user_id ASC;

-- -----

-- Calculate Special Bonus

SELECT employee_id,
CASE
    WHEN employee_id % 2 = 1 AND name NOT LIKE 'M%' THEN salary
    ELSE 0
END AS bonus
FROM Employees
ORDER BY employee_id ASC;

-- -----

-- Patients With a Condition

SELECT patient_id, patient_name, conditions FROM Patients
WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%'
ORDER BY patient_id ASC;

-- -----

-- Find Total Time Spent by Each Employee

SELECT event_day AS day, emp_id, SUM(out_time - in_time) AS total_time FROM Employees
GROUP BY event_day, emp_id;

-- -----

-- Find Followers Count

SELECT user_id, COUNT(follower_id) AS followers_count FROM Followers
GROUP BY user_id
ORDER BY user_id ASC;

-- -----

-- Daily Leads and Partners

SELECT date_id, make_name, COUNT(DISTINCT(lead_id)) AS unique_leads, COUNT(DISTINCT(partner_id)) AS unique_partners FROM DailySales
GROUP BY date_id, make_name;

-- -----

-- Actors and Directors Who Cooperated At Least Three Times

SELECT actor_id, director_id FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(timestamp) >= 3;

-- -----

-- Classes With at Least 5 Students

SELECT class FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;

-- -----

-- Game Play Analysis I

SELECT DISTINCT(player_id), MIN(event_date) AS first_login FROM Activity
GROUP BY player_id;

-- -----

-- Capital Gain/Loss

SELECT stock_name, SUM(
    CASE
        WHEN operation = 'Buy' THEN -price
        ELSE price
    END
) AS capital_gain_loss FROM Stocks
GROUP BY stock_name;

-- -----

-- Second Highest Salary

SELECT (
    SELECT DISTINCT salary FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
 ) AS SecondHighestSalary;
