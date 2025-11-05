-- Complex Employee Performance Report
-- Demonstrates all formatting rules in a single comprehensive query

WITH employee_metrics AS (
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
           NVL(p.performance_rating, 0) AS performance_rating,
           NVL(p.goal_achievement_pct, 0) AS goal_achievement
      FROM employees e
      LEFT JOIN performance_reviews p ON e.employee_id = p.employee_id
        AND p.review_year = EXTRACT(YEAR FROM SYSDATE) - 1
        AND p.review_status = 'APPROVED'
     WHERE e.status = 'ACTIVE'
       AND e.hire_date IS NOT NULL
),
department_stats AS (
    SELECT department_id,
           COUNT(*) AS employee_count,
           AVG(salary) AS avg_salary,
           MIN(salary) AS min_salary,
           MAX(salary) AS max_salary,
           AVG(performance_rating) AS avg_performance
      FROM employee_metrics
     GROUP BY department_id
    HAVING COUNT(*) >= 3
),
top_performers AS (
    SELECT em.employee_id,
           em.department_id,
           RANK() OVER (
               PARTITION BY em.department_id
               ORDER BY em.performance_rating DESC,
                        em.goal_achievement DESC
           ) AS dept_rank
      FROM employee_metrics em
     WHERE em.performance_rating >= 4
)
SELECT em.employee_id,
       em.first_name || ' ' || em.last_name AS full_name,
       em.email,
       d.department_name,
       j.job_title,
       m.first_name || ' ' || m.last_name AS manager_name,
       em.salary,
       NVL(em.commission_pct, 0) * em.salary AS commission_amount,
       ds.avg_salary AS dept_avg_salary,
       ROUND(em.tenure_years, 1) AS years_with_company,
       em.performance_rating,
       em.goal_achievement,
       CASE WHEN em.salary > ds.avg_salary * 1.2
            THEN 'Well Above Average'
            WHEN em.salary > ds.avg_salary * 1.1
            THEN 'Above Average'
            WHEN em.salary >= ds.avg_salary * 0.9
            THEN 'Average'
            WHEN em.salary >= ds.avg_salary * 0.8
            THEN 'Below Average'
            ELSE 'Well Below Average'
       END AS salary_comparison,
       CASE WHEN tp.dept_rank IS NOT NULL
            THEN 'Top Performer (Rank ' || tp.dept_rank || ')'
            WHEN em.performance_rating >= 4
            THEN 'High Performer'
            WHEN em.performance_rating >= 3
            THEN 'Solid Performer'
            WHEN em.performance_rating >= 2
            THEN 'Needs Improvement'
            ELSE 'Performance Issues'
       END AS performance_category,
       CASE WHEN em.tenure_years >= 10 AND em.performance_rating >= 4
            THEN 'Eligible for Senior Leadership'
            WHEN em.tenure_years >= 7 AND em.performance_rating >= 4
            THEN 'Eligible for Management'
            WHEN em.tenure_years >= 5 AND em.performance_rating >= 3
            THEN 'Eligible for Promotion'
            WHEN em.tenure_years >= 3 AND em.performance_rating >= 3
            THEN 'Mid-Career Development'
            WHEN em.tenure_years >= 1
            THEN 'Early Career'
            ELSE 'New Hire'
       END AS career_stage,
       CASE WHEN em.performance_rating >= 4 AND em.salary < ds.avg_salary
            THEN em.salary * 0.15
            WHEN em.performance_rating >= 4
            THEN em.salary * 0.10
            WHEN em.performance_rating >= 3 AND em.tenure_years >= 5
            THEN em.salary * 0.08
            WHEN em.performance_rating >= 3
            THEN em.salary * 0.05
            ELSE 0
       END AS recommended_bonus,
       ds.employee_count AS dept_size,
       ds.avg_performance AS dept_avg_performance
  FROM employee_metrics em
 INNER JOIN departments d ON em.department_id = d.department_id
        AND d.status = 'ACTIVE'
 INNER JOIN jobs j ON em.job_id = j.job_id
  LEFT JOIN employees m ON em.manager_id = m.employee_id
  LEFT JOIN department_stats ds ON em.department_id = ds.department_id
  LEFT JOIN top_performers tp ON em.employee_id = tp.employee_id
 WHERE (em.performance_rating >= 2 OR em.tenure_years >= 5)
   AND em.salary > 0
   AND (
           (em.department_id IN (10, 20, 30) AND em.salary >= 40000)
        OR (em.department_id IN (40, 50, 60) AND em.salary >= 50000)
        OR (em.department_id NOT IN (10, 20, 30, 40, 50, 60))
       )
 ORDER BY d.department_name,
          CASE WHEN tp.dept_rank IS NOT NULL THEN tp.dept_rank ELSE 999 END,
          em.performance_rating DESC,
          em.salary DESC,
          em.last_name,
          em.first_name;
