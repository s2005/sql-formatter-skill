# VS Code AI Customization Guide: Agents & Skills

## Executive Summary

VS Code (specifically GitHub Copilot) now supports two distinct customization mechanisms. It is crucial to distinguish between them as they serve different purposes and have different deployment structures.

| Feature | **Custom Agents** (formerly Chat Modes) | **Agent Skills** (New Standard) |
| :--- | :--- | :--- |
| **Purpose** | Create a specific **Persona** (e.g., `@planner`, `@security`) | Add a specific **Capability/Tool** (e.g., "run tests", "fix linter") |
| **Invocation** | Explicitly via `@agentName` in chat | **Automatic** / Dynamic based on prompt context |
| **File Format** | `.agent.md` (Flat file) | `SKILL.md` (Inside a folder) |
| **Location** | `.github/agents/*.agent.md` | `.github/skills/<skill-name>/SKILL.md` |
| **State** | Generally Available (v1.106+) | Preview (Requires `chat.useAgentSkills: true`) |

---

## 1. Agent Skills (The "New" Way)

Agent Skills follow the open standard from [agentskills.io](https://agentskills.io). They are designed for adding specific capabilities or tools.

### How it works (Progressive Disclosure)

Unlike agents, you do **not** invoke skills manually.

1. **Discovery:** Copilot scans all `SKILL.md` files and indexes their `description`.
2. **activation:** When a user asks a question (e.g., "fix linter errors"), Copilot matches the intent to the skill's description.
3. **Execution:** Copilot loads the full `SKILL.md` instructions and any referenced scripts/files only when needed.

### Deployment Locations

#### A. Project-Specific (Repository)

Place skills in your repo to share with the team.

```text
.github/
└── skills/
    └── my-skill-name/       # Must be a folder
        ├── SKILL.md         # Definition file
        └── verify.js        # Optional support scripts
```

#### B. User-Specific (Global)

Place skills in your home directory to use across all projects.

* **Linux/Mac:** `~/.copilot/skills/`
* **Windows:** `%USERPROFILE%\.copilot\skills\`

*(Legacy locations `.claude/skills/` are also supported for backward compatibility)*

### File Structure (`SKILL.md`)

```markdown
---
name: markdown-linter-fixer
description: Fixes markdown linting issues using markdownlint-cli2. Use when asked to "fix markdown" or "check docs".
---

# Instructions

1. Run `markdownlint-cli2 "**/*.md"` to scan.
2. If errors are found, run with `--fix`.
3. ...
```

### Enabling in VS Code

Since this is a preview feature, you must enable it in settings:

* **Setting:** `chat.useAgentSkills`
* **Value:** `true`

---

## 2. Custom Agents (Formerly Chat Modes)

Custom Agents are the evolution of the `.github/chatmode` feature.

### Deployment

* **Location:** `.github/agents/`
* **File:** `my-agent.agent.md`
* **Migration:** VS Code provides a "Quick Fix" to move old `.chatmode.md` files to the new folder.

### When to use

Use Agents when you want a **persistent conversation partner** with a specific mindset (e.g., a "Code Reviewer" that always critiques PRs, or a "Tutor" that explains concepts simply).

---

## Summary of Migration

* If you have **chat modes** (`.chatmode.md`): Rename to `.agent.md` and move to `.github/agents/`.
* If you have **skills** (from Claude Desktop or OpenClaw): Move the folder to `.github/skills/` or `~/.copilot/skills/`.

## References

* **Official Docs:** [Use Agent Skills in VS Code](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
* **Agents vs Skills:** [Comparison Table](https://code.visualstudio.com/docs/copilot/customization/agent-skills#_agent-skills-vs-custom-instructions)
* **Open Standard:** [agentskills.io](https://agentskills.io)
