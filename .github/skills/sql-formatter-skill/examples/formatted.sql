-- Example 1: Simple SELECT (formatted)
SELECT employee_id,
       first_name,
       last_name,
       email,
       salary
  FROM employees
 WHERE department_id = 10
   AND status = 'ACTIVE'
 ORDER BY last_name;

-- Example 2: JOIN query (formatted)
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name,
       j.job_title
  FROM employees e
 INNER JOIN departments d ON e.department_id = d.department_id
 INNER JOIN jobs j ON e.job_id = j.job_id
 WHERE e.status = 'ACTIVE'
   AND e.salary > 50000;

-- Example 3: INSERT (formatted)
INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            department_id
) VALUES (
            1001,
            'John',
            'Doe',
            'john.doe@example.com',
            '555-0100',
            SYSDATE,
            'IT_PROG',
            75000,
            60
);

-- Example 4: UPDATE (formatted)
UPDATE employees
   SET salary = salary * 1.1,
       last_modified = SYSDATE
 WHERE department_id = 10
   AND performance_rating >= 4
   AND hire_date < ADD_MONTHS(SYSDATE, -12);

-- Example 5: CASE expression (formatted)
SELECT employee_id,
       first_name,
       last_name,
       salary,
       CASE WHEN salary < 50000
            THEN 'Low'
            WHEN salary BETWEEN 50000 AND 100000
            THEN 'Medium'
            WHEN salary > 100000
            THEN 'High'
            ELSE 'Unknown'
       END AS salary_grade
  FROM employees;

-- Example 6: CTE (formatted)
WITH dept_avg AS (
    SELECT department_id,
           AVG(salary) AS avg_salary
      FROM employees
     WHERE status = 'ACTIVE'
     GROUP BY department_id
)
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.salary,
       d.avg_salary
  FROM employees e
 INNER JOIN dept_avg d ON e.department_id = d.department_id
 WHERE e.salary > d.avg_salary;
