-- Duplicate Emails

SELECT DISTINCT email AS Email FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

-- -----

-- Delete Duplicate Emails

DELETE p1 FROM Person p1
JOIN Person p2 ON p1.email = p2.email AND p1.id > p2.id;

-- -----

-- Nth Highest Salary

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N = N - 1;
    RETURN (
        SELECT DISTINCT salary FROM Employee
        ORDER BY salary DESC
        LIMIT 1 OFFSET N
    );
END

-- -----

-- Rank Scores

SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank' FROM Scores
ORDER BY score DESC;

-- -----

-- Department Highest Salary

SELECT t.name AS Department, e.name AS Employee, e.salary FROM Employee e
JOIN (
    SELECT d.id, d.name, MAX(e.salary) AS max_salary FROM Department d
    JOIN Employee e ON d.id = e.departmentId
    GROUP BY d.id, d.name
) t ON e.departmentId = t.id WHERE e.salary = t.max_salary;