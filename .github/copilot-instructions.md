# GitHub Copilot Custom Instructions

This document defines custom behaviors and skills for GitHub Copilot when working in this workspace.

## Available Skills

### The SQL Formatter

The SQL Formatter skill helps you write clean, consistent, and readable SQL code by applying comprehensive formatting rules and conventions. It transforms unformatted SQL queries into well-structured, properly indented, and professionally styled code.

**Important:** Inline comments (comments on the same line after Oracle SQL commands) will cause syntax errors. Avoid adding comments after commands such as:

- `VARIABLE` declarations: `VARIABLE b6 VARCHAR2(2)`
- `EXEC` statements: `EXEC :b101 := 'IE';`

Always place comments on separate lines before the command instead.
