# SQL Formatting Rules - Complete Reference

This document provides the complete specification for SQL code formatting following Oracle Database 19 best practices.

## Rule 1: Keywords

- Write SQL keywords in uppercase (e.g., SELECT, FROM, WHERE, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, etc.)
- Columns, conditions, table names should be in lowercase (e.g., column1, column2*column3, mytable, etc.)
- Apply consistently throughout all SQL code

## Rule 2: Indentation

- Use a consistent indentation of 4 spaces to differentiate between clauses, sub-queries, and different levels within a query
- Do not use tabs, only spaces
- Each nested level adds 4 spaces of indentation

## Rule 3: Whitespace

- Include a single space on either side of operators
- Include a single space after commas
- Maintain consistent spacing throughout

## Rule 4: Aliasing

- When aliasing, use the AS keyword
- Ensure there is a space on either side of the AS keyword
- Example: `table_name AS tn` or `column_name AS alias`

## Rule 5: Single Line Initial Column/Condition

- The first column or condition should start on the same line as the clause keyword
- This applies to: SELECT, FROM, WHERE, UPDATE, DELETE, INSERT, and other clauses
- Subsequent items go on new lines

**Example:**
```sql
SELECT first_column,
       second_column
  FROM table_name
 WHERE first_condition
   AND second_condition;
```

## Rule 6: Line Breaks

- Start a new line for each clause (e.g., SELECT, FROM, WHERE, JOIN, GROUP BY, ORDER BY, SET, HAVING)
- Start a new line for each column or expression in the SELECT clause, except the first column/expression
- Start a new line for each column in the SET clause, except the first column
- Start a new line for each condition in the WHERE clause, except the first condition
- Start a new line for each JOIN clause, and indent it to align with the FROM clause

## Rule 7: New Line for Subsequent Columns/Conditions

- Each subsequent column, condition, table name should be listed on a new line
- The first character of each column or condition should be aligned vertically with the first character of the initial column or condition

**Example 1: Basic SELECT**
```sql
SELECT first_column,
       second_column,
       third_column
  FROM table_name
 WHERE first_condition
   AND second_condition
   AND third_condition;
```

**Example 2: UPDATE with Hint**
```sql
UPDATE /*+ ENABLE_PARALLEL_DML */
       table_name
   SET first_column = expression(1)
 WHERE first_condition
   AND second_condition;
```

**Example 3: INSERT Statement**
```sql
INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            department_id
) VALUES (
            1,
            'John',
            'Doe',
            4
);
```

**Example 4: CREATE TABLE**
```sql
-- Create a test table
CREATE TABLE test_table (
    id       NUMBER           PRIMARY KEY,
    name VARCHAR2(50)
);
```

## Rule 8: Common Table Expressions (CTEs)

- Begin the CTE with the WITH keyword followed by the CTE name
- Follow with AS (
- Place the CTE query content with proper indentation
- Close the CTE with a closing parenthesis ) on a new line, aligned with the WITH keyword
- Separate multiple CTEs with a comma and a space, followed by a line break

**Example:**
```sql
WITH active_employees AS (
    SELECT employee_id,
           first_name,
           last_name,
           department_id
      FROM employees
     WHERE status = 'ACTIVE'
),
department_counts AS (
    SELECT department_id,
           COUNT(*) AS employee_count
      FROM active_employees
     GROUP BY department_id
)
SELECT d.department_name,
       dc.employee_count
  FROM department_counts dc
 INNER JOIN departments d ON dc.department_id = d.department_id
 ORDER BY dc.employee_count DESC;
```

## Rule 9: Joins

- Explicitly specify the type of JOIN (e.g., INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN, CROSS JOIN)
- Always place the JOIN and ON clauses on the same line, separated by a space
- The INNER JOIN or LEFT JOIN keyword should be indented to align with the preceding FROM clause
- The first ON keyword should follow immediately after the table name, separated by a single space
- Second and rest of other ON keywords (with AND conditions) need to be put below using 1 line per 1 AND condition
- Align additional ON conditions vertically

**Example:**
```sql
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name,
       j.job_title
  FROM employees e
 INNER JOIN departments d ON e.department_id = d.department_id
        AND d.status = 'ACTIVE'
  LEFT JOIN jobs j ON e.job_id = j.job_id
        AND j.is_current = 'Y'
 WHERE e.status = 'ACTIVE'
   AND e.hire_date >= DATE '2020-01-01';
```

## Rule 10: Commentaries

- If explicitly requested, include comments to explain complex logic
- Use `--` for single-line comments
- Use `/* comment */` for multi-line comments
- Place comments above the code they describe

**Example:**
```sql
-- Retrieve active employees hired in the last year
SELECT employee_id,
       first_name,
       last_name
  FROM employees
 WHERE status = 'ACTIVE'
   AND hire_date >= ADD_MONTHS(SYSDATE, -12);

/*
 * Complex calculation for bonus eligibility
 * Considers tenure, performance rating, and department budget
 */
SELECT employee_id,
       CASE WHEN tenure_years > 5 AND performance_rating >= 4
            THEN base_salary * 0.15
            WHEN tenure_years > 2 AND performance_rating >= 3
            THEN base_salary * 0.10
            ELSE base_salary * 0.05
       END AS bonus_amount
  FROM employee_metrics;
```

## Rule 11: Grouping

- Group related conditions together using parentheses
- Start a new line for each grouped condition
- Indent to align with the preceding clause
- Use parentheses to clarify operator precedence

**Example:**
```sql
SELECT employee_id,
       first_name,
       last_name,
       salary
  FROM employees
 WHERE (department_id = 10 AND status = 'ACTIVE')
    OR (department_id = 20 AND status = 'ACTIVE')
    OR (salary > 100000 AND job_level >= 5);
```

## Rule 12: Ordering

- List SELECT columns and ORDER BY expressions in a logical order
- Preferred orders:
  - Order they appear in the source table
  - Ascending order by importance
  - Grouped by related fields
- Consistent ordering improves readability and maintainability

**Example:**
```sql
SELECT employee_id,
       first_name,
       last_name,
       email,
       phone_number,
       hire_date,
       job_id,
       salary,
       department_id
  FROM employees
 ORDER BY department_id,
          last_name,
          first_name;
```

## Rule 13: CASE Expressions

- Start the CASE keyword on a new line, followed by the first WHEN clause on the same line
- Each subsequent WHEN, all THEN, and ELSE clauses should be on separate lines
- Indent one level from the CASE keyword
- Align all subsequent WHEN, THEN, and ELSE keywords vertically
- Place the END keyword on a new line, aligned with the CASE keyword
- If the CASE expression is part of a SELECT statement, place the column alias (if any) on the same line as the END keyword

**Example:**
```sql
SELECT CASE WHEN condition1
            THEN result1
            WHEN condition2
            THEN result2
            ELSE result3
       END AS column_alias
  FROM table_name;
```

**Complex Example:**
```sql
SELECT employee_id,
       first_name,
       last_name,
       CASE WHEN salary < 50000
            THEN 'Entry Level'
            WHEN salary BETWEEN 50000 AND 80000
            THEN 'Mid Level'
            WHEN salary BETWEEN 80000 AND 120000
            THEN 'Senior Level'
            WHEN salary > 120000
            THEN 'Executive Level'
            ELSE 'Unclassified'
       END AS salary_grade,
       CASE WHEN department_id IN (10, 20, 30)
            THEN 'Core Operations'
            WHEN department_id IN (40, 50)
            THEN 'Support'
            ELSE 'Other'
       END AS department_category
  FROM employees
 WHERE status = 'ACTIVE'
 ORDER BY salary DESC;
```

## Complete Example: Complex Query

This example demonstrates all formatting rules applied together:

```sql
-- Employee performance report with department and job information
WITH employee_metrics AS (
    SELECT e.employee_id,
           e.first_name,
           e.last_name,
           e.hire_date,
           e.salary,
           e.department_id,
           e.job_id,
           MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12 AS tenure_years,
           NVL(p.performance_rating, 0) AS performance_rating
      FROM employees e
      LEFT JOIN performance_reviews p ON e.employee_id = p.employee_id
        AND p.review_year = EXTRACT(YEAR FROM SYSDATE) - 1
     WHERE e.status = 'ACTIVE'
),
department_stats AS (
    SELECT department_id,
           AVG(salary) AS avg_department_salary,
           COUNT(*) AS department_employee_count
      FROM employee_metrics
     GROUP BY department_id
)
SELECT em.employee_id,
       em.first_name || ' ' || em.last_name AS full_name,
       d.department_name,
       j.job_title,
       em.salary,
       ds.avg_department_salary,
       CASE WHEN em.salary > ds.avg_department_salary * 1.2
            THEN 'Above Average'
            WHEN em.salary >= ds.avg_department_salary * 0.8
            THEN 'Average'
            ELSE 'Below Average'
       END AS salary_comparison,
       CASE WHEN em.tenure_years >= 10 AND em.performance_rating >= 4
            THEN 'Eligible for Senior Role'
            WHEN em.tenure_years >= 5 AND em.performance_rating >= 3
            THEN 'Eligible for Promotion'
            WHEN em.tenure_years >= 2
            THEN 'Mid-Career'
            ELSE 'Early Career'
       END AS career_stage,
       ROUND(em.tenure_years, 1) AS years_with_company
  FROM employee_metrics em
 INNER JOIN departments d ON em.department_id = d.department_id
        AND d.status = 'ACTIVE'
 INNER JOIN jobs j ON em.job_id = j.job_id
  LEFT JOIN department_stats ds ON em.department_id = ds.department_id
 WHERE (em.performance_rating >= 3 OR em.tenure_years >= 5)
   AND em.salary > 0
 ORDER BY d.department_name,
          em.salary DESC,
          em.last_name,
          em.first_name;
```

## Additional Guidelines

### DDL Statements

**CREATE TABLE:**
```sql
CREATE TABLE employees (
    employee_id      NUMBER(10)      PRIMARY KEY,
    first_name       VARCHAR2(50)    NOT NULL,
    last_name        VARCHAR2(50)    NOT NULL,
    email            VARCHAR2(100)   UNIQUE,
    phone_number     VARCHAR2(20),
    hire_date        DATE            DEFAULT SYSDATE,
    job_id           VARCHAR2(10)    NOT NULL,
    salary           NUMBER(10, 2),
    commission_pct   NUMBER(2, 2),
    manager_id       NUMBER(10),
    department_id    NUMBER(10),
    CONSTRAINT emp_dept_fk FOREIGN KEY (department_id)
        REFERENCES departments (department_id),
    CONSTRAINT emp_mgr_fk FOREIGN KEY (manager_id)
        REFERENCES employees (employee_id)
);
```

**CREATE INDEX:**
```sql
CREATE INDEX emp_dept_idx ON employees (department_id);

CREATE INDEX emp_name_idx ON employees (last_name, first_name);
```

### DELETE Statements

```sql
DELETE FROM employees
 WHERE employee_id = 1001;

DELETE FROM employees
 WHERE department_id = 10
   AND status = 'INACTIVE'
   AND hire_date < DATE '2010-01-01';
```

### MERGE Statements

```sql
MERGE INTO employees e
USING employee_updates u ON (e.employee_id = u.employee_id)
 WHEN MATCHED THEN
      UPDATE SET e.salary = u.new_salary,
                 e.job_id = u.new_job_id
 WHEN NOT MATCHED THEN
      INSERT (employee_id,
              first_name,
              last_name,
              salary,
              job_id)
      VALUES (u.employee_id,
              u.first_name,
              u.last_name,
              u.new_salary,
              u.new_job_id);
```

## Summary

Following these 13 formatting rules ensures:

1. **Consistency** - All SQL code follows the same style
2. **Readability** - Code structure is immediately clear
3. **Maintainability** - Changes are easier to implement and review
4. **Collaboration** - Team members can understand code quickly
5. **Quality** - Well-formatted code reduces errors

Apply these rules consistently across all SQL development for Oracle Database 19.
