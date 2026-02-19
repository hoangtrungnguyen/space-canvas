# Installed Claude Tools

The following tools have been installed via `claude-code-templates`.

## Agents

### Flutter Expert (`flutter-expert`)
**Description:** Senior Flutter expert specializing in Flutter 3+, cross-platform development, architecture patterns, state management, and performance optimization.
**Use Cases:**
- Building feature-rich apps with high performance.
- Migrating legacy Flutter code.
- Optimizing performance (jank, memory).
**Model:** sonnet

### Flutter/Go Reviewer (`flutter-go-reviewer`)
**Description:** Expert code reviewer for backend (Golang/Protobuf/Postgres) and frontend (Flutter/Riverpod/GetX).
**Use Cases:**
- Reviewing PRs or new code.
- Checking database schema changes.
- Validating refactoring.
**Model:** opus

## MCP Servers

### Chrome DevTools (`devtools/chrome-devtools`)
**Configured in:** `.mcp.json`
**Command:** `npx -y chrome-devtools-mcp@latest`
**Function:** Provides tools to interact with Chrome DevTools, useful for web debugging and inspection.

## Skills

### MCP Builder (`development/mcp-builder`)
**Location:** `.claude/skills/mcp-builder`
**Description:** Guide for creating high-quality MCP servers (Python/Node) to enable LLMs to interact with external services.
**Resources:** Includes templates, scripts, and best practices in the skill directory.
