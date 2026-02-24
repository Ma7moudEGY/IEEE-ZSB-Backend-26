-- Combine Two Tables

SELECT firstName, lastName, city, state FROM Person p
LEFT JOIN Address a ON a.personID = p.personID;

-- -----

-- Replace Employee ID With The Unique Identifier

SELECT unique_id, name FROM Employees e
LEFT JOIN EmployeeUNI eu ON e.id = eu.id;

-- -----

-- Customer Who Visited but Did Not Make Any Transactions

SELECT v.customer_id, COUNT(v.customer_id) AS count_no_trans FROM Visits v
LEFT JOIN Transactions t ON t.visit_id  = v.visit_id
WHERE transaction_id IS NULL
GROUP BY v.customer_id;

-- -----

-- Project Employees I

SELECT project_id, ROUND(AVG(experience_years), 2) AS average_years FROM Project p
JOIN Employee e WHERE e.employee_id = p.employee_id
GROUP BY project_id;

-- -----

-- Sales Person

SELECT s.name FROM SalesPerson s
WHERE s.name NOT IN (
    SELECT s.name FROM SalesPerson s
    LEFT JOIN Orders o ON o.sales_id = s.sales_id
    LEFT JOIN Company c ON c.com_id = o.com_id
    WHERE c.name = 'RED');

-- -----

-- Rising Temperature

SELECT w1.id FROM Weather w1, Weather w2
WHERE w1.temperature > w2.temperature AND DATEDIFF(w1.recordDate, w2.recordDate) = 1
ORDER BY w1.id ASC;

-- Average Time of Process per Machine

SELECT a1.machine_id, ROUND(AVG(a2.timestamp - a1.timestamp), 3) AS processing_time FROM Activity a1
JOIN Activity a2 ON a2.process_id = a1.process_id AND a2.machine_id = a1.machine_id 
AND a1.activity_type='start' AND a2.activity_type='end'
GROUP BY a1.machine_id;

-- -----

-- Students and Examinations

SELECT s.student_id, s.student_name, su.subject_name, COUNT(e.student_id) AS attended_exams FROM Students S
CROSS JOIN Subjects su
LEFT JOIN Examinations e ON e.student_id = s.student_id AND e.subject_name = su.subject_name
GROUP BY s.student_id, s.student_name, su.subject_name
ORDER BY s.student_id, s.student_name, su.subject_name ASC;

-- -----

-- Managers with at Least 5 Direct Reports

SELECT e1.name FROM Employee e1
JOIN Employee e2 ON e1.id = e2.managerId
GROUP BY e2.managerId
HAVING COUNT(*) >= 5;

-- -----

-- Confirmation Rate

SELECT s.user_id, ROUND(AVG(CASE
    WHEN c.action = 'confirmed' THEN 1.0
    ELSE 0
    END), 2)
    AS confirmation_rate FROM Signups s
LEFT JOIN Confirmations c ON c.user_id = s.user_id
GROUP BY s.user_id;

-- -----

-- Product Sales Analysis III

SELECT product_id, year AS first_year, quantity, price FROM sales
WHERE (product_id, year) IN (
    SELECT product_id, MIN(year) FROM Sales
    GROUP BY product_id);

-- -----

-- Market Analysis I

SELECT u.user_id AS buyer_id, min(join_date) AS join_date, SUM(CASE
WHEN YEAR(order_date) = 2019 THEN 1
ELSE 0
END) AS orders_in_2019 FROM Users u
LEFT JOIN Orders o ON o.buyer_id = u.user_id
GROUP BY u.user_id
ORDER BY u.user_id ASC;