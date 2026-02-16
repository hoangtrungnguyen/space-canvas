# Tracker Directory

This directory contains task tracker files for the Connector Enhancement initiative.

## Purpose

The tracker system serves multiple purposes:

1. **Context Preservation**: Prevents "agent dementia" by logging all decisions, technical approaches, and session details
2. **Dependency Management**: Tracks which tasks block others, ensuring work proceeds in correct order
3. **Progress Tracking**: Shows status of all 89 tasks across 4 epics
4. **Knowledge Base**: Archives technical decisions and reasoning for future reference
5. **Workflow Integration**: Works with `are-u-ready` and `land-the-plane` workflows

## Structure

### Tracker File Format

Each task has a markdown file following this format:

```markdown
---
issue: CONN-001-T01
status: readyForDev
epic: CONN-001
phase: Phase 1: Foundation
effort: 0.5 days
description: Create BLoC for managing connector highlight states
dependencies: None
---

**Timestamp:** 2026-02-16 23:00:00
**Affected Modules:**
  - lib/features/space/view/bloc/connector_highlight/

---

## Task Details
[Epic, Phase, Title, Description, Effort, Dependencies, Status]

## Files to Modify/Create
[List of files]

## Acceptance Criteria
[Success criteria]

## Implementation Notes
[Technical approach, code changes, decisions]

## Testing Strategy
[Unit, integration, manual tests]

## Session Log
[Chronological log of all work sessions]

## Related Tasks
[Blocks, Blocked By, Related]

## Notes
[Additional context]
```

### Status Values

- `analyze`: Researching and analyzing requirements
- `readyForDev`: Dependencies met, ready to start implementation
- `inProgress`: Currently being worked on
- `blocked`: Waiting on dependencies
- `testing`: Code complete, testing in progress
- `done`: Fully completed and tested

## Files in This Directory

- **INDEX.md**: Master index with all 89 tasks, progress tracking, and navigation
- **README.md**: This file - explains the tracker system
- **CONN-XXX-TXX.md**: Individual task tracker files (89 total)

## Usage

### View All Tasks
```bash
cat tracker/INDEX.md
```

### Find Next Task
```bash
# Find all ready tasks
grep "^status: readyForDev" tracker/CONN-*.md

# Find tasks with no dependencies
grep "^dependencies: None" tracker/CONN-*.md
```

### Start Working on a Task
```bash
# Use are-u-ready workflow
are-u-ready CONN-001-T01
```

### Check Task Status
```bash
# View specific task
cat tracker/CONN-001-T01.md

# Check status field
head -n 20 tracker/CONN-001-T01.md | grep "^status:"
```

### Update Task Status
```bash
# Edit the task file
vim tracker/CONN-001-T01.md

# Change status field in YAML header
# Example: status: readyForDev → status: done
```

## Workflows

### are-u-ready Workflow

Validates readiness before starting a task:

1. Loads task context from tracker file
2. Checks dependencies (reads "Blocked By" tasks)
3. Verifies environment (if needed)
4. Provides readiness checklist
5. Asks how to proceed

**Usage:**
```bash
# Automatic task selection
are-u-ready

# Specific task
are-u-ready CONN-001-T01
```

### land-the-plane Workflow

Cleanly ends a session:

1. Updates tracker file with session log
2. Commits all changes with clear messages
3. Cleans up artifacts
4. Generates next session prompt

**Usage:**
```bash
land-the-plane
```

## Maintaining the Tracker

### When Starting a Task

1. Run `are-u-ready TASK-ID`
2. Update status to `inProgress`
3. Add session entry to Session Log

### During Implementation

Update these sections as you work:

- **Implementation Notes**: Technical approach, code changes
- **Decisions Made**: Key architectural decisions
- **Testing Strategy**: Test results
- **Session Log**: Progress notes

### When Completing a Task

1. Update status to `done`
2. Verify all acceptance criteria met
3. Run `land-the-plane`
4. Git commit with clear message

### Example Session Log Entry

```markdown
## Session Log

### Session 1 - 2026-02-16 22:37:58
- Tracker file created from task breakdown
- Status: readyForDev
- Ready for implementation

### Session 2 - 2026-02-17 10:15:00
- Started implementation
- Created ConnectorHighlightBloc with events and states
- Used freezed for immutable state
- Status: inProgress

### Session 3 - 2026-02-17 14:30:00
- Completed unit tests
- All tests passing
- Verified acceptance criteria
- Status: done
```

## Dependencies

### Task Dependencies

Tasks may depend on other tasks. Check the `dependencies` field in the YAML header.

**Example:**
```yaml
dependencies: CONN-001-T01, CONN-001-T02
```

This means the task is blocked until T01 and T02 are marked as `done`.

### Epic Dependencies

- **CONN-001**: No dependencies (start here)
- **CONN-002**: Depends on CONN-001 completion
- **CONN-003**: Depends on CONN-001 completion
- **CONN-004**: Depends on CONN-003 completion

### Dependency Graph

```
CONN-001 (Foundation)
  ├─> CONN-002 (Bézier Curves)
  └─> CONN-003 (Endpoint Editing)
       └─> CONN-004 (Magnetic Snapping)
```

## Progress Tracking

### Current Status

Track progress by epic:

```bash
# Count tasks by status for CONN-001
grep "^status:" tracker/CONN-001-*.md | sort | uniq -c

# View completion percentage
total=$(ls tracker/CONN-*.md | wc -l)
done=$(grep "^status: done" tracker/CONN-*.md | wc -l)
echo "Progress: $done/$total tasks complete"
```

### Update INDEX.md

When significant progress is made, update the progress table in `INDEX.md`:

```markdown
### Overall Progress
- 🔴 Not Started: 70 tasks
- 🟡 In Progress: 5 tasks
- 🟢 Completed: 14 tasks
```

## Archival

### Purpose

Tracker files serve as a permanent archive of:

- Technical decisions and reasoning
- Challenges encountered and solutions
- Implementation approach
- Testing results
- Time taken vs estimated

### Long-term Value

Future developers (human or AI) can:

1. Understand why decisions were made
2. See what approaches were tried
3. Find solutions to similar problems
4. Estimate effort for similar tasks

## Integration with Other Systems

### Git Commits

Link commits to tasks:

```bash
git commit -m "feat(CONN-001-T01): implement ConnectorHighlightBloc

Implements hover and selection state management.

Tracker: tracker/CONN-001-T01.md
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

### External Issue Trackers

If using GitHub Issues, Linear, Beads, etc.:

1. Create matching external issue
2. Link in tracker file under "External References"
3. Update both systems (tracker for details, external for status)

## Best Practices

### ✅ Do

- Update tracker files continuously during work
- Log all important decisions
- Mark tasks as `done` only when fully complete
- Keep session logs chronological
- Check dependencies before starting tasks
- Use `are-u-ready` at session start
- Use `land-the-plane` at session end

### ❌ Don't

- Skip updating tracker files
- Mark incomplete tasks as done
- Work on blocked tasks
- Forget to commit tracker updates
- Leave stale `inProgress` tasks
- Work on multiple tasks simultaneously

## Related Documentation

- [Connector Enhancements Roadmap](../docs/plans/connector-enhancements-roadmap.md)
- [Task Breakdown](../docs/plans/connector-tasks-breakdown.md)
- [Workflow Guide](../docs/WORKFLOW_GUIDE.md)
- [Epic Details](../docs/plans/epic-*.md)

## Scripts

### Generate Trackers

Regenerate all tracker files from task breakdown:

```bash
python3 scripts/parse_and_generate_trackers.py
```

**Warning:** This will overwrite existing tracker files. Backup first if you've made changes.

### Validate Trackers

Check all tracker files for consistency:

```bash
# Check for required fields
for file in tracker/CONN-*.md; do
  if ! grep -q "^status:" "$file"; then
    echo "Missing status in $file"
  fi
done

# Check for orphaned dependencies
for file in tracker/CONN-*.md; do
  deps=$(grep "^dependencies:" "$file" | cut -d: -f2)
  for dep in $deps; do
    if [ ! -f "tracker/$dep.md" ]; then
      echo "Missing dependency $dep referenced in $file"
    fi
  done
done
```

## Statistics

- **Total Tasks**: 89
- **Total Effort**: 33-41 days (4.5-5.5 weeks)
- **Epics**: 4
- **Average Task Size**: 0.5 days

### By Epic

| Epic | Tasks | Effort |
|------|-------|--------|
| CONN-001 | 18 | 5-6 days |
| CONN-002 | 24 | 12-15 days |
| CONN-003 | 26 | 8-10 days |
| CONN-004 | 21 | 8-10 days |

## Questions?

Refer to:
- [Workflow Guide](../docs/WORKFLOW_GUIDE.md) for usage instructions
- [landing-plane-flutter.md](../.agent/workflows/landing-plane-flutter.md) for workflow details
- [are-u-ready.md](../.agent/workflows/are-u-ready.md) for readiness checks

---

**Last Updated:** 2026-02-16
**Tracker Version:** 1.0
**Generated By:** parse_and_generate_trackers.py
