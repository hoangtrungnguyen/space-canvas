#!/usr/bin/env python3
"""
Parse connector-tasks-breakdown.md and generate tracker files for all tasks
This script automatically extracts task information from the markdown file
"""

import os
import re
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional


class TaskParser:
    """Parser for task breakdown markdown file"""

    def __init__(self, markdown_file: Path):
        self.markdown_file = markdown_file
        self.content = markdown_file.read_text()
        self.tasks = []
        self.current_epic = None
        self.current_phase = None

    def parse(self) -> List[Dict]:
        """Parse the markdown file and extract all tasks"""
        lines = self.content.split('\n')
        i = 0

        while i < len(lines):
            line = lines[i].strip()

            # Detect epic section
            if line.startswith('## EPIC CONN-'):
                self.current_epic = self._extract_epic_info(line)
                i += 1
                continue

            # Detect phase section
            if line.startswith('### Phase'):
                self.current_phase = line.replace('###', '').strip()
                i += 1
                continue

            # Detect task (starts with #### CONN-XXX-TXX:)
            if line.startswith('#### CONN-'):
                task = self._parse_task(lines, i)
                if task:
                    self.tasks.append(task)
                i += 1
                continue

            i += 1

        return self.tasks

    def _extract_epic_info(self, line: str) -> Dict:
        """Extract epic information from header line"""
        # Example: "## EPIC CONN-001: Enhanced Connector Highlighting"
        match = re.match(r'## EPIC (CONN-\d+):\s*(.+)', line)
        if match:
            return {
                'id': match.group(1),
                'name': match.group(2).split('**')[0].strip()
            }
        return None

    def _parse_task(self, lines: List[str], start_idx: int) -> Optional[Dict]:
        """Parse a single task from the markdown"""
        line = lines[start_idx].strip()

        # Extract task ID and title
        # Example: "#### CONN-001-T01: Create ConnectorHighlightBloc"
        match = re.match(r'####\s+(CONN-\d+-T\d+):\s*(.+)', line)
        if not match:
            return None

        task_id = match.group(1)
        title = match.group(2)

        task = {
            'id': task_id,
            'title': title,
            'epic': self.current_epic['id'] if self.current_epic else '',
            'epic_name': self.current_epic['name'] if self.current_epic else '',
            'phase': self.current_phase or '',
            'description': '',
            'files': [],
            'modules': [],
            'effort': '',
            'dependencies': [],
            'acceptance': [],
            'status': 'readyForDev'
        }

        # Parse task content (next lines until next task or section)
        i = start_idx + 1
        current_section = None

        while i < len(lines):
            line = lines[i].strip()

            # Stop at next task or major section
            if line.startswith('####') or line.startswith('## '):
                break

            # Detect sections within task
            if line.startswith('- **File:'):
                task['files'].append(self._extract_value(line, 'File:'))
            elif line.startswith('- **Description:'):
                task['description'] = self._extract_value(line, 'Description:')
            elif line.startswith('- **Effort:'):
                task['effort'] = self._extract_value(line, 'Effort:')
            elif line.startswith('- **Dependencies:'):
                deps = self._extract_value(line, 'Dependencies:')
                if deps and deps != 'None':
                    task['dependencies'] = [d.strip() for d in deps.split(',')]
            elif line.startswith('- **Acceptance Criteria:'):
                current_section = 'acceptance'
            elif current_section == 'acceptance' and line.startswith('  - '):
                task['acceptance'].append(line[4:])
            elif line == '':
                current_section = None

            i += 1

        # Infer modules from files
        task['modules'] = self._infer_modules(task['files'])

        return task

    def _extract_value(self, line: str, key: str) -> str:
        """Extract value from a markdown list item"""
        pattern = f'- \\*\\*{re.escape(key)}\\*\\*\\s*(.+)'
        match = re.match(pattern, line)
        return match.group(1).strip() if match else ''

    def _infer_modules(self, files: List[str]) -> List[str]:
        """Infer module paths from file paths"""
        modules = set()
        for file_path in files:
            if '/' in file_path:
                # Extract directory path
                parts = file_path.rsplit('/', 1)
                modules.add(parts[0] + '/')
            elif file_path.startswith('lib/') or file_path.startswith('test/'):
                modules.add(file_path)
        return list(modules) if modules else ['N/A']


def create_tracker_file(task: Dict, tracker_dir: Path):
    """Create a tracker markdown file for a task"""

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Format dependencies
    deps = ", ".join(task['dependencies']) if task['dependencies'] else "None"

    # Format affected modules
    modules_str = "\n".join([f"  - {m}" for m in task['modules']])

    # Format acceptance criteria
    criteria_str = "\n".join([f"- {c}" for c in task['acceptance']]) if task['acceptance'] else "- [To be defined]"

    # Format files
    files_str = "\n".join([f"- {f}" for f in task['files']]) if task['files'] else "- [To be defined]"

    # Epic full name
    epic_full = f"{task['epic']}: {task['epic_name']}"

    content = f"""---
issue: {task['id']}
status: {task['status']}
epic: {task['epic']}
phase: {task['phase']}
effort: {task['effort']}
description: {task['description']}
dependencies: {deps}
---

**Timestamp:** {timestamp}
**Affected Modules:**
{modules_str}

---

## Task Details

### Epic
{epic_full}

### Phase
{task['phase']}

### Title
{task['title']}

### Description
{task['description']}

### Effort Estimate
{task['effort']}

### Dependencies
{deps}

### Status
{task['status']}

---

## Files to Modify/Create

{files_str}

---

## Acceptance Criteria

{criteria_str}

---

## Implementation Notes

### Technical Approach
[To be filled during implementation]

### Code Changes
[To be filled during implementation]

### Decisions Made
[To be filled during implementation]

---

## Testing Strategy

### Unit Tests
[To be filled during implementation]

### Integration Tests
[To be filled during implementation]

### Manual Testing
[To be filled during implementation]

---

## Session Log

### Session 1 - Created: {timestamp}
- Tracker file created from task breakdown
- Status: {task['status']}
- Ready for implementation

---

## Related Tasks

### Blocks
[Tasks that depend on this task being completed]

### Blocked By
{deps}

### Related
[Other related tasks]

---

## Notes

[Additional notes, warnings, or important context]
"""

    # Write file
    filepath = tracker_dir / f"{task['id']}.md"
    filepath.write_text(content)
    return filepath


def main():
    """Main execution"""

    # Get paths
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    tracker_dir = project_root / "tracker"
    breakdown_file = project_root / "docs" / "plans" / "connector-tasks-breakdown.md"

    # Check if breakdown file exists
    if not breakdown_file.exists():
        print(f"❌ Error: Task breakdown file not found at {breakdown_file}")
        return 1

    # Create tracker directory
    tracker_dir.mkdir(exist_ok=True)

    print(f"📖 Reading task breakdown from: {breakdown_file}")
    print(f"📁 Generating tracker files in: {tracker_dir}\n")

    # Parse tasks
    parser = TaskParser(breakdown_file)
    tasks = parser.parse()

    if not tasks:
        print("❌ No tasks found in breakdown file")
        return 1

    print(f"Found {len(tasks)} tasks\n")

    # Generate tracker files
    created_count = 0
    epics = {}

    for task in tasks:
        filepath = create_tracker_file(task, tracker_dir)
        print(f"✓ Created {filepath.name}")
        created_count += 1

        # Track epics
        epic_id = task['epic']
        epics[epic_id] = epics.get(epic_id, 0) + 1

    # Summary
    print(f"\n{'='*60}")
    print(f"✅ Successfully generated {created_count} tracker files")
    print(f"\nBreakdown by Epic:")
    for epic_id, count in sorted(epics.items()):
        print(f"  {epic_id}: {count} tasks")

    print(f"\n📁 All tracker files created in: {tracker_dir}")
    print(f"\n{'='*60}")
    print("\nNext steps:")
    print("1. Review generated tracker files")
    print("2. Use 'are-u-ready' workflow to start implementation")
    print("3. Update task status as work progresses")

    return 0


if __name__ == "__main__":
    exit(main())
