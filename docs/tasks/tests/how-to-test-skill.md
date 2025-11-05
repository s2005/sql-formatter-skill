# Testing the SQL Formatter Skill

This guide explains how to test the SQL Formatter skill to ensure it correctly formats SQL code according to Oracle Database 19 best practices.

## Overview

Testing focuses on verifying that Claude Code:
1. Correctly activates the SQL formatter skill
2. Applies all 13 formatting rules consistently
3. Handles different SQL statement types (SELECT, INSERT, UPDATE, DELETE, CREATE)
4. Preserves SQL logic while improving readability

## Prerequisites

- [ ] Skill installed in `~/.claude/skills/sql-formatter/`
- [ ] Claude Code is configured and running
- [ ] Access to example SQL files in `examples/` directory

## Installation for Testing

### Install Skill Locally

```bash
# Windows (Git Bash)
cp -r . "$USERPROFILE/.claude/skills/sql-formatter"

# Unix/Mac
cp -r . ~/.claude/skills/sql-formatter
```

### Verify Installation

```bash
# Check skill directory
ls -la ~/.claude/skills/sql-formatter/

# Verify SKILL.md exists with frontmatter
head -10 ~/.claude/skills/sql-formatter/SKILL.md
```

Expected output should show:
```yaml
---
name: sql-formatter
description: This skill should be used when the user asks to format SQL code...
---
```

## Test Scenarios

### Test Case 1: Basic SELECT Statement Formatting

**User Request:**

```text
Format this SQL:
select employee_id,first_name,last_name,email,salary from employees where department_id=10 and status='ACTIVE' order by last_name;
```

**Alternative Variations:**

- "Polish this SQL query"
- "Make this SQL more readable"
- "Format this database query"

**Expected Behavior:**

1. Skill should activate automatically
2. SQL keywords converted to UPPERCASE
3. Identifiers remain lowercase
4. Proper indentation applied (4 spaces)
5. Vertical alignment of columns and conditions

**Expected Output:**

```sql
SELECT employee_id,
       first_name,
       last_name,
       email,
       salary
  FROM employees
 WHERE department_id = 10
   AND status = 'ACTIVE'
 ORDER BY last_name;
```

**Validation:**

- [ ] Keywords are UPPERCASE (SELECT, FROM, WHERE, AND, ORDER BY)
- [ ] Identifiers are lowercase (employee_id, first_name, etc.)
- [ ] Columns aligned vertically starting after SELECT
- [ ] WHERE conditions aligned vertically
- [ ] Single space around operators (=)
- [ ] Semicolon at end

### Test Case 2: JOIN Query with Multiple Tables

**User Request:**

```text
Format this SQL with joins:
select e.employee_id,e.first_name,e.last_name,d.department_name,j.job_title from employees e join departments d on e.department_id=d.department_id join jobs j on e.job_id=j.job_id where e.status='ACTIVE' and e.salary>50000;
```

**Expected Behavior:**

1. Explicit JOIN types specified (INNER JOIN)
2. JOIN clauses aligned with FROM
3. ON conditions on same line as JOIN
4. Proper table aliases used

**Expected Output:**

```sql
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
```

**Validation:**

- [ ] JOIN keyword is "INNER JOIN" (explicit)
- [ ] JOIN clauses aligned with FROM
- [ ] ON conditions on same line as JOIN
- [ ] Table aliases used consistently (e, d, j)
- [ ] Spaces around comparison operators (>, =)

### Test Case 3: INSERT Statement

**User Request:**

```text
Format this INSERT statement:
insert into employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,department_id)values(1001,'John','Doe','john.doe@example.com','555-0100',sysdate,'IT_PROG',75000,60);
```

**Expected Behavior:**

1. Column list in parentheses with vertical alignment
2. VALUES clause with same alignment pattern
3. Each column/value on separate line (except first)

**Expected Output:**

```sql
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
```

**Validation:**

- [ ] INSERT INTO on first line
- [ ] Opening parenthesis on same line as INSERT INTO
- [ ] Columns aligned vertically with consistent indentation
- [ ] VALUES keyword with opening parenthesis
- [ ] Values aligned vertically matching column alignment
- [ ] Closing parentheses aligned properly

### Test Case 4: UPDATE Statement

**User Request:**

```text
Format this UPDATE:
update employees set salary=salary*1.1,last_modified=sysdate where department_id=10 and performance_rating>=4 and hire_date<add_months(sysdate,-12);
```

**Expected Output:**

```sql
UPDATE employees
   SET salary = salary * 1.1,
       last_modified = SYSDATE
 WHERE department_id = 10
   AND performance_rating >= 4
   AND hire_date < ADD_MONTHS(SYSDATE, -12);
```

**Validation:**

- [ ] UPDATE and table name on first line
- [ ] SET clause on new line with proper indentation
- [ ] Multiple SET assignments vertically aligned
- [ ] WHERE conditions properly aligned
- [ ] Spaces around operators (=, *, <, >=)

### Test Case 5: CASE Expression

**User Request:**

```text
Format this query with a CASE expression:
select employee_id,first_name,last_name,salary,case when salary<50000 then 'Low' when salary between 50000 and 100000 then 'Medium' when salary>100000 then 'High' else 'Unknown' end as salary_grade from employees;
```

**Expected Output:**

```sql
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
```

**Validation:**

- [ ] CASE and first WHEN on same line
- [ ] THEN clauses on separate lines
- [ ] WHEN/THEN/ELSE vertically aligned
- [ ] END aligned with CASE
- [ ] Column alias (AS salary_grade) on same line as END

### Test Case 6: Common Table Expression (CTE)

**User Request:**

```text
Format this CTE query:
with dept_avg as(select department_id,avg(salary)as avg_salary from employees where status='ACTIVE' group by department_id)select e.employee_id,e.first_name,e.last_name,e.salary,d.avg_salary from employees e join dept_avg d on e.department_id=d.department_id where e.salary>d.avg_salary;
```

**Expected Output:**

```sql
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
```

**Validation:**

- [ ] WITH keyword followed by CTE name and AS (
- [ ] CTE query properly indented (one level deeper)
- [ ] Closing ) on new line aligned with WITH
- [ ] Main query follows standard formatting rules
- [ ] All formatting rules applied within CTE

### Test Case 7: File-Based Formatting

**User Request:**

```text
Format the SQL file at examples/unformatted.sql
```

**Expected Behavior:**

1. Claude reads the file
2. Applies formatting to all queries in the file
3. Preserves comments
4. Returns formatted SQL or writes to file

**Validation:**

- [ ] All queries in file are formatted
- [ ] Comments are preserved
- [ ] Each query follows formatting rules
- [ ] File structure maintained

### Test Case 8: Skill Activation Triggers

Test that the skill activates with various phrasings:

**Test Phrases:**

- "Format this SQL code"
- "Polish this SQL query"
- "Beautify this database query"
- "Make this SQL more readable"
- "Clean up this SQL"
- "Improve SQL formatting"
- "Format my .sql file"

**Validation:**

- [ ] Skill activates automatically for each phrase
- [ ] No need to explicitly mention "sql-formatter skill"
- [ ] Consistent behavior across all activation phrases

## Troubleshooting

### Skill Doesn't Activate

**Symptoms:**
- Claude doesn't format SQL as expected
- Claude doesn't recognize SQL formatting request

**Checks:**

1. **Verify installation:**
   ```bash
   ls ~/.claude/skills/sql-formatter/SKILL.md
   ```

2. **Check SKILL.md frontmatter:**
   ```bash
   head -10 ~/.claude/skills/sql-formatter/SKILL.md
   ```
   Should show valid YAML with name and description.

3. **Try explicit activation:**
   "Use the sql-formatter skill to format this SQL: [your sql]"

4. **Restart Claude Code:**
   Skills are loaded on startup, restart may be needed.

### Formatting Doesn't Match Expected Output

**Symptoms:**
- Formatting is applied but differs from examples
- Some rules not applied consistently

**Checks:**

1. **Compare with reference files:**
   - Check `examples/formatted.sql` for correct formatting
   - Review `references/sql-formatting-rules.md` for detailed rules

2. **Test with simple examples first:**
   - Start with basic SELECT
   - Gradually test more complex queries

3. **Check for SQL syntax errors:**
   - Ensure input SQL is syntactically valid
   - Fix any missing parentheses, quotes, etc.

### Rules Not Applied Correctly

**Common Issues:**

1. **Indentation issues** - Verify 4 spaces, not tabs
2. **Case not converted** - Check keywords are UPPERCASE
3. **Alignment off** - Ensure vertical alignment of columns/conditions
4. **Spacing problems** - Single space around operators

## Testing Checklist

### Pre-Test Setup
- [ ] Skill installed in `~/.claude/skills/sql-formatter/`
- [ ] SKILL.md has valid YAML frontmatter
- [ ] Example files available in `examples/` directory

### Core Functionality
- [ ] Test Case 1: Basic SELECT ✓
- [ ] Test Case 2: JOIN query ✓
- [ ] Test Case 3: INSERT statement ✓
- [ ] Test Case 4: UPDATE statement ✓
- [ ] Test Case 5: CASE expression ✓
- [ ] Test Case 6: CTE formatting ✓
- [ ] Test Case 7: File-based formatting ✓
- [ ] Test Case 8: Activation triggers ✓

### Documentation Quality
- [ ] SKILL.md description triggers skill correctly
- [ ] Instructions in SKILL.md are accurate
- [ ] Examples work as documented
- [ ] Reference documentation matches behavior

### Edge Cases
- [ ] Empty SQL input
- [ ] SQL with syntax errors
- [ ] Very long queries (>100 lines)
- [ ] Multiple statements in one request
- [ ] SQL with existing comments
- [ ] SQL with complex nested subqueries

## Test Results Template

```markdown
# SQL Formatter Skill Test Results

**Date:** YYYY-MM-DD
**Platform:** Windows/macOS/Linux
**Claude Code Version:** X.X.X
**Tester:** [Name]

## Environment
- OS: [OS version]
- Shell: bash/zsh/PowerShell
- Installation Path: ~/.claude/skills/sql-formatter/

## Test Results

| Test Case | Status | Notes |
|-----------|--------|-------|
| 1. Basic SELECT | ✓ PASS | All formatting rules applied correctly |
| 2. JOIN query | ✓ PASS | INNER JOIN explicit, alignment correct |
| 3. INSERT statement | ✓ PASS | Vertical alignment working |
| 4. UPDATE statement | ✓ PASS | SET clauses aligned properly |
| 5. CASE expression | ✓ PASS | WHEN/THEN/ELSE aligned |
| 6. CTE formatting | ✓ PASS | WITH clause formatted correctly |
| 7. File-based formatting | ✓ PASS | All queries in file formatted |
| 8. Activation triggers | ✓ PASS | Activates with various phrases |

## Issues Found
[List any issues discovered during testing]

## Recommendations
[Suggestions for improvements or additional test cases]

## Overall Assessment
☐ Ready for release
☐ Needs minor fixes
☐ Needs major revision
```

## Best Practices

### 1. Test Incrementally

- Test each SQL statement type separately
- Verify basic cases before complex ones
- Test file formatting after individual queries work

### 2. Use Real Examples

- Test with actual SQL from your projects
- Include edge cases from production code
- Get feedback from database developers

### 3. Cross-Platform Testing

- Test on Windows, macOS, and Linux
- Verify path handling works on each platform
- Document platform-specific behaviors (if any)

### 4. Regression Testing

- Keep test results for each version
- Re-run all tests after changes
- Track any regressions in formatting quality

### 5. Compare with Examples

- Always compare output against `examples/formatted.sql`
- Use `references/sql-formatting-rules.md` as source of truth
- Verify all 13 formatting rules are applied

## Quick Validation Script

Use this quick test to verify basic functionality:

```bash
# Navigate to skill directory
cd ~/.claude/skills/sql-formatter/

# Compare test output (if you generate formatted output to a file)
# This assumes you've asked Claude to format examples/unformatted.sql
# and saved to test-output.sql
diff examples/formatted.sql test-output.sql
```

No output from diff means perfect match!

## Resources

- **Example Files**: `examples/unformatted.sql` and `examples/formatted.sql`
- **Formatting Rules**: `references/sql-formatting-rules.md`
- **Skill Configuration**: `SKILL.md`
- **Claude Code Skills Documentation**: [https://docs.claude.com/en/docs/claude-code/skills](https://docs.claude.com/en/docs/claude-code/skills)
- **Oracle Database 19c SQL Reference**: [https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/)
