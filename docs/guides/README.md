# SQL Formatter Skill Guides

This directory contains additional documentation and guides for the SQL Formatter skill.

## Purpose

These guides provide detailed information about SQL formatting, Oracle Database 19 best practices, and how to effectively use the SQL Formatter skill with Claude Code.

## Available Guides

Currently, this skill provides comprehensive SQL formatting guidance directly in the SKILL.md file. Additional guides can be added here as the skill evolves.

## Suggested Future Guides

Potential guides that could be added:

- **Oracle-Specific SQL Features** - Oracle Database 19 specific syntax and formatting
- **Performance Considerations** - How formatting affects query performance
- **Migration Guide** - Converting from other SQL dialects to Oracle SQL format
- **Team Style Guide** - Customizing formatting rules for team standards

## Referencing Guides

When working with this skill, Claude Code will automatically reference the appropriate documentation based on your needs:

- For basic SQL formatting, the main SKILL.md provides all necessary guidelines
- For detailed formatting rules, see `references/sql-formatting-rules.md`
- For examples, see the `examples/` directory

## Using the SQL Formatter Skill

The SQL Formatter skill activates automatically when you:

- Ask to format SQL code
- Work with .sql files
- Request SQL code polishing or beautification
- Mention SQL query readability improvements

Simply describe what you need, and Claude Code will apply the formatting rules from this skill.

## Contributing Guides

To add a new guide:

1. Create a markdown file with a descriptive name (e.g., `oracle-specific-features.md`)
2. Follow the SQL formatting principles defined in SKILL.md
3. Include practical examples
4. Keep the guide focused on a single topic
5. Update this README to list the new guide

## Related Resources

- **Main Skill Documentation**: See SKILL.md in the root directory
- **Detailed Formatting Rules**: See `references/sql-formatting-rules.md`
- **Example SQL Files**: See `examples/` directory
- **Oracle Database Documentation**: [Oracle Database 19c Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/19/)
