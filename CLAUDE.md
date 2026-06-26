# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository packages a single SQL-formatting skill for two platforms: as a Claude Code plugin (installed via the bundled marketplace manifest) and as a GitHub Copilot custom chat mode for VS Code. The skill transforms unformatted SQL queries into well-structured, properly indented, and professionally styled code according to Oracle Database 19 best practices.

## Repository Structure

```
.
├── .claude-plugin/
│   ├── marketplace.json            # Claude Code marketplace manifest
│   └── plugin.json                 # Claude Code plugin manifest (reuses the skill below)
├── .github/
│   ├── skills/
│   │   └── sql-formatter-skill/
│   │       ├── SKILL.md            # Main skill definition and usage instructions
│   │       ├── examples/
│   │       │   ├── README.md       # Examples documentation
│   │       │   ├── unformatted.sql # Before formatting examples
│   │       │   ├── formatted.sql   # After formatting examples
│   │       │   └── complex-query.sql  # Comprehensive example showing all rules
│   │       └── references/
│   │           └── sql-formatting-rules.md  # Complete 13-rule specification
│   ├── chatmodes/
│   │   └── sql-formatter.chatmode.md   # VS Code chat mode definition
│   └── copilot-instructions.md     # GitHub Copilot custom instructions
├── docs/
│   └── vscode_skills.md            # VS Code agents vs. skills guide
├── CLAUDE.md
├── LICENSE
└── README.md
```

Both platforms share the same skill folder: the Claude Code plugin points its `skills` entry at `.github/skills/sql-formatter-skill` in `.claude-plugin/marketplace.json`, so there is no duplicated skill content.

## SQL Formatting Rules

The skill implements 13 core formatting rules defined in `.github/skills/sql-formatter-skill/references/sql-formatting-rules.md`:

1. **Keywords** - UPPERCASE (SELECT, FROM, WHERE, etc.)
2. **Indentation** - 4 spaces (no tabs)
3. **Whitespace** - Single space around operators and after commas
4. **Aliasing** - Use AS keyword with proper spacing
5. **Single Line Initial** - First column/condition on same line as clause keyword
6. **Line Breaks** - New line for each clause and item
7. **Vertical Alignment** - Align columns and conditions vertically
8. **CTEs** - Proper WITH clause structure with aligned closing parentheses
9. **Joins** - Explicit JOIN types with ON conditions
10. **Comments** - `--` for single-line, `/* */` for multi-line
11. **Grouping** - Parentheses for related conditions
12. **Ordering** - Logical column and sort order
13. **CASE Expressions** - Aligned WHEN/THEN/ELSE/END

## Critical Syntax Rule

**Inline comments after Oracle SQL commands will cause syntax errors.** Avoid adding comments on the same line after commands such as:
- `VARIABLE` declarations: `VARIABLE b6 VARCHAR2(2)`
- `EXEC` statements: `EXEC :b101 := 'IE';`

Always place comments on separate lines before the command instead.

## Key Formatting Conventions

- First column/condition starts on same line as clause keyword
- Subsequent columns/conditions align vertically on new lines
- Keywords are UPPERCASE, identifiers are lowercase
- CTEs use `WITH cte_name AS (` with closing `)` aligned to `WITH`
- JOINs use explicit types (INNER, LEFT, RIGHT, FULL) with ON on same line
- CASE expressions align WHEN/THEN/ELSE/END vertically

## Working with This Skill

When formatting SQL:
1. Read `references/sql-formatting-rules.md` for detailed specifications
2. Apply rules consistently - first item on clause line, rest aligned below
3. Use `examples/formatted.sql` and `examples/complex-query.sql` as references
4. For .sql files, preserve UTF-8 encoding and existing comments unless reformatting is requested
