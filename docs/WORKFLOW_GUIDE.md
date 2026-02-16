# Connector Enhancement Workflow Guide

This guide explains how to use the agent workflows with the connector enhancement tracker system.

---

## Quick Start

### 1. Starting a New Task

**Command:** `are-u-ready [TASK-ID]`

**Example:**
```
are-u-ready CONN-001-T01
```

**What happens:**
1. ✅ Agent loads task context from `tracker/CONN-001-T01.md`
2. ✅ Checks dependencies (blocked tasks)
3. ✅ Verifies environment (if needed)
4. ✅ Provides readiness checklist
5. ✅ Asks how to proceed (plan or code)

### 2. Working on a Task

- Agent reads relevant files
- Makes code changes
- Updates tracker file with:
  - Technical approach
  - Code changes
  - Decisions made
  - Testing results

### 3. Ending a Session

**Command:** `land-the-plane`

**What happens:**
1. 🔄 Updates tracker file status
2. 💾 Commits all changes with clear messages
3. 🧹 Cleans up temporary artifacts
4. 📝 Generates next session prompt
5. 📋 Archives session context

---

## Detailed Workflow

### Phase 1: Task Selection

#### Option A: Agent Picks Next Task
```
User: are-u-ready
Agent: Scans tracker/INDEX.md for highest priority 'readyForDev' task
Agent: "Would you like to start on CONN-001-T01: Create ConnectorHighlightBloc?"
```

#### Option B: You Specify Task
```
User: are-u-ready CONN-001-T05
Agent: Loads CONN-003-T05.md
Agent: Checks dependencies: CONN-001-T01, CONN-001-T02
```

---

### Phase 2: Readiness Check

The agent validates:

#### ✅ Task Context
- Task description loaded
- Files to modify identified
- Acceptance criteria understood

#### ✅ Dependencies
- Checks "Blocked By" section
- Verifies dependent tasks are marked "done"
- Example:
  ```
  CONN-001-T05 depends on:
  - CONN-001-T01: ✅ Done
  - CONN-001-T02: ✅ Done
  ```

#### ✅ Environment (if applicable)
- Database connections
- API keys
- External services

#### Decision Matrix

**❌ NOT READY:**
```
I am not ready to start CONN-001-T05.

Blockers:
- CONN-001-T01 is still 'inProgress'
- CONN-001-T02 is still 'readyForDev'

Recommendation: Would you like to complete CONN-001-T01 first?
```

**✅ READY:**
```
I am ready to start CONN-001-T05. All dependencies look good.

How would you like to proceed?
1. Create a Plan: I will outline implementation steps
2. Start Coding: I will begin implementation immediately
```

---

### Phase 3: Implementation

#### Starting Implementation
```
User: Start coding
Agent: Begins work on task
```

#### During Implementation
Agent updates tracker file in real-time:

```markdown
## Session Log

### Session 2 - 2026-02-16 23:00:00
- Started implementation of ConnectorHighlightBloc
- Created bloc, events, and states
- Added freezed annotations
- Generated code with build_runner

### Decisions Made
- Used freezed for immutable state
- Separate events for hover vs select
- Store hoveredConnectorId as nullable String
```

---

### Phase 4: Testing

Agent runs tests and updates tracker:

```markdown
## Testing Strategy

### Unit Tests
✅ Sets hover state correctly
✅ Clears hover on unhover event
✅ Handles multiple selections
❌ Edge case: rapid hover events (FIXED)

### Manual Testing
✅ Hover highlighting works
✅ Performance acceptable with 50 connectors
```

---

### Phase 5: Landing the Plane

**Command:** `land-the-plane`

#### Step 1: Update Tracker
```markdown
---
issue: CONN-001-T01
status: done  ← Updated from readyForDev
---

### Session 3 - 2026-02-16 23:45:00
- Task completed
- All tests passing
- Ready for next task
```

#### Step 2: Git Commits
```bash
git add lib/features/space/view/bloc/connector_highlight/
git commit -m "feat(CONN-001-T01): implement ConnectorHighlightBloc

- Create ConnectorHighlightBloc with state management
- Add hover and selection events
- Use freezed for immutable state
- All unit tests passing

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

git add tracker/CONN-001-T01.md
git commit -m "docs: update CONN-001-T01 tracker status to done"
```

#### Step 3: Generate Next Session Prompt
```
Recommended next session prompt:

"Continue working on connector highlighting. CONN-001-T01 is complete
(ConnectorHighlightBloc implemented). Next task is CONN-001-T02: Create
ConnectorHighlightPainter. This task involves implementing the painting
logic for different highlight states (normal, hover, selected) with
varying stroke widths and colors."
```

---

## Task Status Values

| Status | Meaning | Next Action |
|--------|---------|-------------|
| `readyForDev` | Dependencies met, ready to start | Run are-u-ready |
| `inProgress` | Currently being worked on | Continue work or land-the-plane |
| `blocked` | Waiting on dependencies | Work on unblocking tasks |
| `testing` | Code complete, testing in progress | Complete tests |
| `done` | Fully completed and tested | Move to next task |

---

## Best Practices

### 1. One Task at a Time
```
✅ Good: Complete CONN-001-T01 fully before starting T02
❌ Bad: Start T01, T02, T03 simultaneously
```

### 2. Update Tracker Continuously
```
✅ Good: Log decisions and changes as you work
❌ Bad: Try to remember everything at the end
```

### 3. Test Before Landing
```
✅ Good: Run all tests, verify acceptance criteria
❌ Bad: Skip tests, mark as done anyway
```

### 4. Use Descriptive Commits
```
✅ Good: "feat(CONN-001-T01): implement ConnectorHighlightBloc with hover state management"
❌ Bad: "update files"
```

### 5. Keep Sessions Focused
```
✅ Good: One task per session, land the plane when done
❌ Bad: Work on 5 tasks, forget to update trackers
```

---

## Example Session

### Full Session Transcript

```
User: are-u-ready CONN-001-T01

Agent: 📖 Loading CONN-001-T01: Create ConnectorHighlightBloc

Readiness Checklist:
- ✅ Task Context Loaded
- ✅ Blockers Resolved (No dependencies)
- ✅ Files Identified
  - lib/features/space/view/bloc/connector_highlight/connector_highlight_bloc.dart

I am ready to start CONN-001-T01. All dependencies look good.

How would you like to proceed?
1. Create a Plan
2. Start Coding

---

User: Start Coding

Agent: [Implements ConnectorHighlightBloc]
[Runs tests]
[Updates tracker file]

✅ CONN-001-T01 completed successfully!

Would you like to land the plane or continue to the next task?

---

User: land-the-plane

Agent: 🛬 Landing the plane for CONN-001-T01

Phase 1: Housekeeping & Cleanup
✅ Updated tracker/CONN-001-T01.md status to 'done'
✅ Committed code changes
✅ Committed tracker updates
✅ No artifacts to clean up

Phase 2: Continuity
📋 Next task: CONN-001-T02 - Create ConnectorHighlightPainter

Recommended next session prompt:
"Continue connector highlighting. T01 (ConnectorHighlightBloc) is done.
Start CONN-001-T02: Create ConnectorHighlightPainter with different
stroke widths and colors for normal/hover/selected states."

✅ Plane landed successfully!
```

---

## Troubleshooting

### "I am not ready - blockers exist"
**Solution:** Complete blocking tasks first
```bash
# Check what's blocking
cat tracker/CONN-001-T05.md | grep "Blocked By"

# Work on blocking tasks
are-u-ready CONN-001-T01
```

### "Status is inProgress but I forgot what I was doing"
**Solution:** Read tracker file session log
```bash
cat tracker/CONN-001-T01.md
# Look at Session Log section
# Last session will show what was completed
```

### "Lost track of which tasks are done"
**Solution:** Check INDEX.md or grep statuses
```bash
# View index
cat tracker/INDEX.md

# Or search all trackers
grep "^status:" tracker/CONN-*.md | grep -v done
```

### "Want to skip a task"
**Solution:** Update status manually, but document why
```bash
# Edit tracker file
vim tracker/CONN-001-T03.md
# Change status to 'blocked' or add note
```

---

## Integration with Issue Trackers

### Syncing with External Systems

If using GitHub Issues, Linear, or Beads:

1. **Create External Issue:**
   ```
   Title: [CONN-001-T01] Create ConnectorHighlightBloc
   Labels: epic:conn-001, phase:foundation, effort:0.5d
   ```

2. **Link in Tracker:**
   ```markdown
   ## External References
   - GitHub Issue: #123
   - Linear: CONN-42
   ```

3. **Update Both:**
   - Tracker file: Detailed technical log
   - External issue: High-level status updates

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `are-u-ready` | Pick next task automatically |
| `are-u-ready TASK-ID` | Start specific task |
| `land-the-plane` | End session, commit, handoff |
| `cat tracker/INDEX.md` | View all tasks |
| `grep "status: readyForDev" tracker/*.md` | Find ready tasks |

---

**Pro Tip:** Use `are-u-ready` at the start of every session to ensure context is loaded correctly and prevent "agent dementia"!

---

**Last Updated:** 2026-02-16
