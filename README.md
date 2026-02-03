# SQL Formatter

A Claude Agent Skill that formats SQL code following Oracle Database 19 best practices with consistent style, UPPERCASE keywords, lowercase identifiers, and proper indentation.

## Overview

This skill provides Claude with comprehensive SQL code formatting rules for Oracle Database 19. It transforms unformatted SQL queries into well-structured, properly indented, and professionally styled code that improves readability and maintainability.

**Available for multiple platforms:**

- **Claude Code**: Install as a skill via marketplace
- **VS Code**: Install as a custom chat mode for GitHub Copilot

## What This Skill Does

The SQL Formatter skill enables Claude to:

- **Apply 13 formatting rules** consistently across all SQL code
- **Format keywords** as UPPERCASE and identifiers as lowercase
- **Align columns and conditions** vertically for readability
- **Structure CTEs, joins, and CASE expressions** correctly
- **Handle DDL and DML statements** (SELECT, INSERT, UPDATE, DELETE, CREATE, etc.)
- **Preserve Oracle SQL syntax** while improving presentation

## Key Formatting Conventions

- **Keywords**: UPPERCASE (SELECT, FROM, WHERE, etc.)
- **Identifiers**: lowercase (column names, table names, aliases)
- **Indentation**: 4 spaces (no tabs)
- **First item on clause line**: First column/condition starts on same line as clause keyword
- **Vertical alignment**: Subsequent items align vertically below

## Installation

### For VS Code Users (GitHub Copilot Chat)

Click the button below to install the custom chat mode in VS Code:

[![Install in VS Code](https://img.shields.io/badge/VS_Code-Install-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://aka.ms/awesome-copilot/install/chatmode?url=vscode%3Achat-mode%2Finstall%3Furl%3Dhttps%3A%2F%2Fraw.githubusercontent.com%2Fs2005%2Fsql-formatter-skill%2Fmain%2F.github%2Fchatmodes%2Fsql-formatter.chatmode.md) [![Install in VS Code Insiders](https://img.shields.io/badge/VS_Code_Insiders-Install-24bfa5?style=flat-square&logo=visualstudiocode&logoColor=white)](https://aka.ms/awesome-copilot/install/chatmode?url=vscode-insiders%3Achat-mode%2Finstall%3Furl%3Dhttps%3A%2F%2Fraw.githubusercontent.com%2Fs2005%2Fsql-formatter-skill%2Fmain%2F.github%2Fchatmodes%2Fsql-formatter.chatmode.md)

> **Requirements:** GitHub Copilot subscription and VS Code version 1.96 or higher (custom chat modes available from v1.101+)

**To use after installation:**

1. Open GitHub Copilot Chat in VS Code
2. Select "sql-formatter" mode
3. Ask to format SQL code or .sql files
4. Follow the guided formatting

### For Claude Code Users

**Quick start for Claude Code:**

```bash
# Add the marketplace
/plugin marketplace add https://github.com/s2005/sql-formatter-skill

# Install the skill
/skill install sql-formatter

# Restart Claude Code
```

## Usage

Once installed, Claude automatically activates this skill when you:

- Ask to "format SQL"
- Request to "polish SQL queries"
- Mention "improve SQL readability"
- Say "format this .sql file"
- Ask to "clean up this query"

### Example Requests

**Simple formatting:**

```text
Format this SQL query

select employee_id,first_name,last_name from employees where department_id=10 and status='ACTIVE' order by last_name;
```

**Complex query:**

```text
Format this SQL with CTEs and joins

with dept_avg as(select department_id,avg(salary)as avg_salary from employees where status='ACTIVE' group by department_id)select e.employee_id,e.first_name,e.salary,d.avg_salary from employees e join dept_avg d on e.department_id=d.department_id where e.salary>d.avg_salary;
```

**File formatting:**

```text
Format the SQL in queries/report.sql
```

## Repository Structure

```
.github/
├── skills/
│   └── sql-formatter-skill/
│       ├── SKILL.md                # Main skill definition
│       ├── examples/
│       │   ├── README.md           # Examples documentation
│       │   ├── unformatted.sql     # Before formatting
│       │   ├── formatted.sql       # After formatting
│       │   └── complex-query.sql   # Comprehensive example
│       └── references/
│           └── sql-formatting-rules.md  # Complete 13-rule specification
└── chatmodes/
    └── sql-formatter.chatmode.md   # VS Code chat mode definition
```

## 13 Formatting Rules

1. **Keywords** - UPPERCASE (SELECT, FROM, WHERE, etc.)
2. **Indentation** - 4 spaces (no tabs)
3. **Whitespace** - Single space around operators and after commas
4. **Aliasing** - Use AS keyword with proper spacing
5. **Single Line Initial** - First column/condition on same line as clause
6. **Line Breaks** - New line for each clause and item
7. **Vertical Alignment** - Columns and conditions aligned
8. **CTEs** - Proper WITH clause structure
9. **Joins** - Explicit JOIN types with aligned ON clauses
10. **Comments** - Standard comment styles
11. **Grouping** - Parentheses for related conditions
12. **Ordering** - Logical column and sort order
13. **CASE Expressions** - Aligned WHEN/THEN/ELSE/END

## Before & After Examples

### Simple SELECT

**Before:**
```sql
select employee_id,first_name,last_name,email,salary from employees where department_id=10 and status='ACTIVE' order by last_name;
```

**After:**
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

### JOIN Query

**Before:**
```sql
select e.employee_id,e.first_name,e.last_name,d.department_name,j.job_title from employees e join departments d on e.department_id=d.department_id join jobs j on e.job_id=j.job_id where e.status='ACTIVE' and e.salary>50000;
```

**After:**
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

### CTE with CASE

**Before:**
```sql
with dept_stats as(select department_id,avg(salary)as avg_sal,count(*)as cnt from employees group by department_id)select d.department_name,ds.avg_sal,case when ds.avg_sal<50000 then 'Low' when ds.avg_sal<100000 then 'Medium' else 'High' end as pay_level from dept_stats ds join departments d on ds.department_id=d.department_id;
```

**After:**
```sql
WITH dept_stats AS (
    SELECT department_id,
           AVG(salary) AS avg_sal,
           COUNT(*) AS cnt
      FROM employees
     GROUP BY department_id
)
SELECT d.department_name,
       ds.avg_sal,
       CASE WHEN ds.avg_sal < 50000
            THEN 'Low'
            WHEN ds.avg_sal < 100000
            THEN 'Medium'
            ELSE 'High'
       END AS pay_level
  FROM dept_stats ds
 INNER JOIN departments d ON ds.department_id = d.department_id;
```

## Critical Syntax Rule

**Inline comments after Oracle SQL commands will cause syntax errors.** Avoid adding comments on the same line after commands such as:

- `VARIABLE` declarations: `VARIABLE b6 VARCHAR2(2)`
- `EXEC` statements: `EXEC :b101 := 'IE';`

Always place comments on separate lines before the command instead.

## Best Practices

- Apply formatting consistently across all SQL files in a project
- Format SQL before committing to version control
- Use vertical alignment to improve readability
- Keep related conditions grouped with parentheses
- Test formatted SQL to ensure functionality is preserved
- Preserve the logical structure and query optimization

## License

MIT License

## Resources

- [Claude Skills Documentation](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview)
- [VS Code Custom Chat Modes](https://code.visualstudio.com/docs/copilot/customization/custom-chat-modes)
- [Oracle Database 19 Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/19/)
