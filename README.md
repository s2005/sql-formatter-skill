# SQL Formatter Skill

A Claude Code skill for formatting, polishing, and documenting SQL code following Oracle Database 19 best practices.

## Overview

The SQL Formatter skill helps you write clean, consistent, and readable SQL code by applying comprehensive formatting rules and conventions. It transforms unformatted SQL queries into well-structured, properly indented, and professionally styled code.

## Features

- **Automatic SQL Formatting** - Format SQL queries with consistent style
- **Oracle Database 19 Optimized** - Best practices for Oracle SQL
- **Comprehensive Rules** - 13 detailed formatting rules covering all SQL constructs
- **Multiple Statement Types** - Supports SELECT, INSERT, UPDATE, DELETE, CREATE, and more
- **Complex Query Support** - Handles CTEs, joins, subqueries, and CASE expressions
- **Vertical Alignment** - Proper indentation and column alignment
- **Case Conventions** - UPPERCASE keywords, lowercase identifiers

## Installation

### Option 1: Manual Installation

1. Clone or download this repository
2. Copy the skill to your Claude Code skills directory:

**Windows (Git Bash/PowerShell):**
```bash
cp -r . "$USERPROFILE/.claude/skills/sql-formatter"
```

**Unix/Mac/Linux:**
```bash
cp -r . ~/.claude/skills/sql-formatter
```

3. Restart Claude Code or reload skills

### Option 2: Install from Release

1. Download the latest release ZIP from GitHub releases
2. Extract to your Claude Code skills directory:
   - Windows: `%USERPROFILE%\.claude\skills\sql-formatter`
   - Unix/Mac: `~/.claude/skills/sql-formatter`
3. Restart Claude Code

## Usage

### Quick Start

Simply ask Claude Code to format your SQL:

```
Format this SQL code:
select id,name,email from users where status='active'
```

Claude will automatically apply the SQL Formatter skill and return:

```sql
SELECT id,
       name,
       email
  FROM users
 WHERE status = 'active';
```

### Working with Files

Format SQL files directly:

```
Format the SQL in database/queries/report.sql
```

### Complex Queries

The skill handles complex queries with CTEs, joins, and CASE expressions:

```
Format this complex query and make it readable
```

## Formatting Rules

The skill applies 13 comprehensive formatting rules:

1. **Keywords** - UPPERCASE for SQL keywords (SELECT, FROM, WHERE)
2. **Indentation** - 4 spaces per level, no tabs
3. **Whitespace** - Single space around operators and after commas
4. **Aliasing** - Use AS keyword with spaces
5. **Single Line Initial** - First column/condition on same line as clause
6. **Line Breaks** - New line for each clause and column
7. **Vertical Alignment** - Align columns and conditions
8. **CTEs** - Proper WITH clause formatting
9. **Joins** - Explicit JOIN types with aligned ON clauses
10. **Comments** - Standard comment styles (when requested)
11. **Grouping** - Parentheses for related conditions
12. **Ordering** - Logical column and sorting order
13. **CASE Expressions** - Aligned WHEN/THEN/ELSE/END

See `references/sql-formatting-rules.md` for complete details and examples.

## Examples

### Before Formatting

```sql
select e.employee_id,e.first_name,e.last_name,d.department_name from employees e join departments d on e.department_id=d.department_id where e.status='ACTIVE' and e.salary>50000 order by e.last_name
```

### After Formatting

```sql
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name
  FROM employees e
 INNER JOIN departments d ON e.department_id = d.department_id
 WHERE e.status = 'ACTIVE'
   AND e.salary > 50000
 ORDER BY e.last_name;
```

See the `examples/` directory for more comprehensive examples including:
- Basic SELECT statements
- Complex queries with CTEs
- INSERT/UPDATE/DELETE operations
- DDL statements (CREATE TABLE, etc.)

## Skill Structure

```
sql-formatter-skill/
├── SKILL.md                          # Main skill configuration
├── README.md                         # This file
├── VERSION                           # Skill version
├── references/
│   └── sql-formatting-rules.md       # Complete formatting specification
└── examples/
    ├── unformatted.sql              # Example: before formatting
    ├── formatted.sql                # Example: after formatting
    └── complex-query.sql            # Example: complex queries
```

## When This Skill Activates

The SQL Formatter skill automatically activates when you:

- Ask to format SQL code
- Request to polish or beautify SQL queries
- Work with `.sql` files
- Mention SQL formatting, Oracle SQL, or database query polishing
- Ask to improve SQL readability

## Configuration

The skill uses these default settings:

- **Database:** Oracle Database 19
- **Indentation:** 4 spaces
- **Keywords:** UPPERCASE
- **Identifiers:** lowercase
- **Line Length:** No strict limit (optimized for readability)

## Best Practices

- Format SQL before committing to version control
- Apply formatting consistently across your project
- Test formatted SQL to ensure functionality is preserved
- Use the skill for both new and existing code
- Review complex queries after formatting

## Troubleshooting

### Skill Not Activating

1. Verify skill is installed in correct directory
2. Restart Claude Code
3. Try explicit request: "Use the sql-formatter skill to format this SQL"
4. Check SKILL.md has valid YAML frontmatter

### Formatting Issues

1. Ensure SQL is syntactically valid before formatting
2. Check for unbalanced parentheses or quotes
3. Test the formatted SQL in your database
4. Report issues with specific examples

## Limitations

- Focuses on formatting and style, not query optimization
- Preserves original query logic and structure
- Does not validate SQL syntax
- Optimized for Oracle Database 19 (may work with other databases)
- Does not modify query performance characteristics

## Contributing

Contributions are welcome! To improve this skill:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Version History

- **1.0.0** - Initial release
  - Complete formatting rule implementation
  - Support for all major SQL statement types
  - Comprehensive documentation and examples

## License

MIT License - See LICENSE file for details

## Support

For issues, questions, or suggestions:

- [GitHub Issues](https://github.com/s2005/sql-formatter-skill/issues)
- [GitHub Discussions](https://github.com/s2005/sql-formatter-skill/discussions)

## Related Resources

- [Oracle Database SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/)
- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [Claude Code Skills Guide](https://docs.claude.com/en/docs/claude-code/skills)

## Acknowledgments

This skill is based on professional SQL formatting standards and Oracle Database best practices. It follows the Claude Code skill creation guidelines and best practices from Anthropic.

---

**Made with Claude Code** | A skill for formatting SQL with style and consistency
