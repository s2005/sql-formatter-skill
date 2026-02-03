# SQL Formatter Examples

This directory contains example SQL files demonstrating the formatting capabilities of the SQL Formatter skill.

## Files

### unformatted.sql

Contains unformatted SQL examples showing typical "raw" SQL code:
- Simple SELECT statements
- JOIN queries
- INSERT statements
- UPDATE statements
- CASE expressions
- Common Table Expressions (CTEs)

These examples show SQL as it might be written quickly or copied from various sources.

### formatted.sql

Contains the same SQL from `unformatted.sql` but properly formatted according to the skill's formatting rules:
- UPPERCASE keywords
- lowercase identifiers
- Proper indentation (4 spaces)
- Vertical alignment of columns and conditions
- Consistent spacing and line breaks

Use this to compare before/after formatting and understand the formatting rules.

### complex-query.sql

A comprehensive example demonstrating all formatting rules in a single query:
- Multiple CTEs with complex logic
- Multiple JOIN types (INNER JOIN, LEFT JOIN)
- Complex WHERE clauses with grouped conditions
- Multiple CASE expressions
- Window functions (RANK() OVER)
- Aggregate functions
- ORDER BY with multiple expressions

This example shows how the formatting rules apply to real-world, production-quality queries.

## Using These Examples

### Learning the Formatting Style

1. Open `unformatted.sql` to see "before" examples
2. Open `formatted.sql` to see "after" examples
3. Compare line-by-line to understand the transformations
4. Study `complex-query.sql` to see all rules applied together

### Testing the Skill

1. Copy content from `unformatted.sql`
2. Ask Claude Code to format it using this skill
3. Compare the result with `formatted.sql`
4. Verify all formatting rules are applied correctly

### Creating Your Own Examples

Use these files as templates for:
- Testing new formatting scenarios
- Reporting formatting issues
- Contributing improvements to the skill
- Training team members on SQL formatting standards

## Formatting Rules Demonstrated

These examples demonstrate all 13 formatting rules:

1. **Keywords** - All SQL keywords in UPPERCASE
2. **Indentation** - Consistent 4-space indentation
3. **Whitespace** - Single space around operators and after commas
4. **Aliasing** - AS keyword with proper spacing
5. **Single Line Initial** - First column/condition on same line as clause
6. **Line Breaks** - New line for each clause and item
7. **Vertical Alignment** - Columns and conditions aligned
8. **CTEs** - Proper WITH clause structure
9. **Joins** - Explicit JOIN types with aligned ON clauses
10. **Comments** - Standard comment styles
11. **Grouping** - Parentheses for related conditions
12. **Ordering** - Logical column and sort order
13. **CASE Expressions** - Aligned WHEN/THEN/ELSE/END

## Notes

- All examples use Oracle Database 19 syntax
- Examples focus on formatting, not query optimization
- Formatted queries preserve the original logic and functionality
- Use these as reference when formatting your own SQL code
