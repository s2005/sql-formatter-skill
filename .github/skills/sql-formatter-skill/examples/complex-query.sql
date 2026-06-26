-- Complex Employee Compensation Report
-- Demonstrates all formatting rules in a single comprehensive query
-- Based on the Oracle HR sample schema (employees, departments, jobs)

WITH employee_base AS (
    SELECT e.employee_id,
           e.first_name,
           e.last_name,
           e.email,
           e.hire_date,
           e.salary,
           e.commission_pct,
           e.department_id,
           e.job_id,
           e.manager_id,
           MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12 AS tenure_years,
           NVL(e.commission_pct, 0) * e.salary AS commission_amount
      FROM employees e
     WHERE e.salary > 0
       AND e.department_id IS NOT NULL
),
department_stats AS (
    SELECT department_id,
           COUNT(*) AS employee_count,
           AVG(salary) AS avg_salary,
           MIN(salary) AS min_salary,
           MAX(salary) AS max_salary
      FROM employee_base
     GROUP BY department_id
    HAVING COUNT(*) >= 3
),
top_earners AS (
    SELECT eb.employee_id,
           eb.department_id,
           RANK() OVER (
               PARTITION BY eb.department_id
               ORDER BY eb.salary DESC,
                        eb.commission_amount DESC
           ) AS dept_rank
      FROM employee_base eb
)
SELECT eb.employee_id,
       eb.first_name || ' ' || eb.last_name AS full_name,
       eb.email,
       d.department_name,
       j.job_title,
       m.first_name || ' ' || m.last_name AS manager_name,
       eb.salary,
       eb.commission_amount,
       ds.avg_salary AS dept_avg_salary,
       ROUND(eb.tenure_years, 1) AS years_with_company,
       CASE WHEN eb.salary > ds.avg_salary * 1.2
            THEN 'Well Above Average'
            WHEN eb.salary > ds.avg_salary * 1.1
            THEN 'Above Average'
            WHEN eb.salary >= ds.avg_salary * 0.9
            THEN 'Average'
            WHEN eb.salary >= ds.avg_salary * 0.8
            THEN 'Below Average'
            ELSE 'Well Below Average'
       END AS salary_comparison,
       CASE WHEN te.dept_rank IS NOT NULL
            THEN 'Top Earner (Rank ' || te.dept_rank || ')'
            WHEN eb.salary >= 10000
            THEN 'High Earner'
            WHEN eb.salary >= 6000
            THEN 'Mid Earner'
            ELSE 'Entry Level'
       END AS earner_category,
       CASE WHEN eb.tenure_years >= 10
            THEN 'Eligible for Senior Leadership'
            WHEN eb.tenure_years >= 7
            THEN 'Eligible for Management'
            WHEN eb.tenure_years >= 5
            THEN 'Eligible for Promotion'
            WHEN eb.tenure_years >= 3
            THEN 'Mid-Career Development'
            WHEN eb.tenure_years >= 1
            THEN 'Early Career'
            ELSE 'New Hire'
       END AS career_stage,
       CASE WHEN eb.salary < ds.avg_salary
            THEN eb.salary * 0.15
            WHEN eb.tenure_years >= 5
            THEN eb.salary * 0.10
            ELSE eb.salary * 0.05
       END AS recommended_increase,
       ds.employee_count AS dept_size
  FROM employee_base eb
 INNER JOIN departments d ON eb.department_id = d.department_id
 INNER JOIN jobs j ON eb.job_id = j.job_id
  LEFT JOIN employees m ON eb.manager_id = m.employee_id
  LEFT JOIN department_stats ds ON eb.department_id = ds.department_id
  LEFT JOIN top_earners te ON eb.employee_id = te.employee_id
 WHERE eb.salary > 0
   AND (
           (eb.department_id IN (10, 20, 30) AND eb.salary >= 4000)
        OR (eb.department_id IN (50, 60, 80) AND eb.salary >= 5000)
        OR (eb.department_id NOT IN (10, 20, 30, 50, 60, 80))
       )
 ORDER BY d.department_name,
          CASE WHEN te.dept_rank IS NOT NULL THEN te.dept_rank ELSE 999 END,
          eb.salary DESC,
          eb.last_name,
          eb.first_name;
