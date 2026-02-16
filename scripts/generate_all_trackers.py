#!/usr/bin/env python3
"""
Generate tracker files for all connector enhancement tasks
Reads from docs/plans/connector-tasks-breakdown.md
"""

import os
import re
from datetime import datetime
from pathlib import Path

# Task data for all 89 tasks
TASKS = {
    # CONN-001: Enhanced Connector Highlighting (18 tasks)
    "CONN-001-T01": {
        "title": "Create ConnectorHighlightBloc",
        "epic": "CONN-001",
        "phase": "Phase 1: Foundation",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Create BLoC for managing connector highlight states (hover, selection)",
        "dependencies": [],
        "files": ["lib/features/space/view/bloc/connector_highlight/connector_highlight_bloc.dart"],
        "modules": ["lib/features/space/view/bloc/connector_highlight/"],
        "acceptance": [
            "ConnectorHighlightState with hoveredConnectorId, selectedConnectorIds, hoverZone",
            "Events: HoverConnector, UnhoverConnector, SelectConnector, DeselectConnector",
            "State transitions work correctly"
        ]
    },
    "CONN-001-T02": {
        "title": "Create ConnectorHighlightPainter",
        "epic": "CONN-001",
        "phase": "Phase 1: Foundation",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Enhanced painting logic for connectors with highlight states",
        "dependencies": [],
        "files": ["lib/features/space/domain/models/objects/visitors/connector_highlight_painter.dart"],
        "modules": ["lib/features/space/domain/models/objects/visitors/"],
        "acceptance": [
            "Different stroke widths for normal, hover, selected states",
            "Color changes based on state",
            "Hit test padding for easier interaction"
        ]
    },
    "CONN-001-T03": {
        "title": "Add hover state tracking to SelectConnectorToolHandler",
        "epic": "CONN-001",
        "phase": "Phase 1: Foundation",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Update tool handler to track hover state and emit events",
        "dependencies": ["CONN-001-T01"],
        "files": ["lib/features/space/view/pages/tool_handler/implementations/select_connector_tool_handler.dart"],
        "modules": ["lib/features/space/view/pages/tool_handler/implementations/"],
        "acceptance": [
            "onPanUpdate detects connector under cursor",
            "Emits hover/unhover events to ConnectorHighlightBloc",
            "Works with existing gesture handling"
        ]
    },
    "CONN-001-T04": {
        "title": "Unit tests for highlight state management",
        "epic": "CONN-001",
        "phase": "Phase 1: Foundation",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Comprehensive tests for ConnectorHighlightBloc",
        "dependencies": ["CONN-001-T01"],
        "files": ["test/features/space/view/bloc/connector_highlight/connector_highlight_bloc_test.dart"],
        "modules": ["test/features/space/view/bloc/connector_highlight/"],
        "acceptance": [
            "Sets hover state on hover event",
            "Clears hover on unhover event",
            "Handles multiple selected connectors",
            "State transitions are correct"
        ]
    },
    "CONN-001-T05": {
        "title": "Update PaintVisitor to use highlight painter",
        "epic": "CONN-001",
        "phase": "Phase 2: Visual Enhancement",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Integrate ConnectorHighlightPainter into existing paint logic",
        "dependencies": ["CONN-001-T01", "CONN-001-T02"],
        "files": ["lib/features/space/domain/models/objects/visitors/paint_visitor.dart"],
        "modules": ["lib/features/space/domain/models/objects/visitors/"],
        "acceptance": [
            "visitConnector uses highlight painter",
            "Highlight state retrieved from context",
            "Backward compatible with non-highlighted connectors"
        ]
    },
    "CONN-001-T06": {
        "title": "Implement ConnectorHandlePainter",
        "epic": "CONN-001",
        "phase": "Phase 2: Visual Enhancement",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Draw interactive handles on connector endpoints",
        "dependencies": [],
        "files": ["lib/features/space/view/painters/connector_handle_painter.dart"],
        "modules": ["lib/features/space/view/painters/"],
        "acceptance": [
            "Start and end handles visible when selected/hovered",
            "Handles are circles with white fill and blue border",
            "Handle hit areas larger than visual representation"
        ]
    },
    "CONN-001-T07": {
        "title": "Add smooth transitions for hover states",
        "epic": "CONN-001",
        "phase": "Phase 2: Visual Enhancement",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Add AnimatedBuilder for smooth hover transitions",
        "dependencies": ["CONN-001-T05"],
        "files": ["Various widget files"],
        "modules": ["lib/features/space/view/widgets/"],
        "acceptance": [
            "Hover state changes animate smoothly",
            "Transition duration ~200ms",
            "No performance impact"
        ]
    },
    "CONN-001-T08": {
        "title": "Test visual feedback on different connector types",
        "epic": "CONN-001",
        "phase": "Phase 2: Visual Enhancement",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Manual testing of visual enhancements",
        "dependencies": ["CONN-001-T05", "CONN-001-T06"],
        "files": ["Manual testing checklist"],
        "modules": ["N/A (Manual Testing)"],
        "acceptance": [
            "Hover highlighting works",
            "Selection highlighting distinct from hover",
            "Handles appear correctly",
            "Works on thin and thick connectors"
        ]
    },
    "CONN-001-T09": {
        "title": "Enhance ConnectorHitTestVisitor with larger tolerance",
        "epic": "CONN-001",
        "phase": "Phase 3: Hit Testing",
        "effort": "0.25 days",
        "status": "readyForDev",
        "description": "Improve hit detection with wider tolerance area",
        "dependencies": [],
        "files": ["lib/features/space/domain/models/objects/visitors/connector_hit_test_visitor.dart"],
        "modules": ["lib/features/space/domain/models/objects/visitors/"],
        "acceptance": [
            "Hit test tolerance of 8px",
            "Point-to-line distance calculation accurate",
            "Works for straight connectors"
        ]
    },
    "CONN-001-T10": {
        "title": "Implement separate hit testing for handles vs body",
        "epic": "CONN-001",
        "phase": "Phase 3: Hit Testing",
        "effort": "0.25 days",
        "status": "readyForDev",
        "description": "Priority hit testing for handles",
        "dependencies": ["CONN-001-T09"],
        "files": ["lib/features/space/domain/models/objects/visitors/connector_hit_test_visitor.dart"],
        "modules": ["lib/features/space/domain/models/objects/visitors/"],
        "acceptance": [
            "Handle hit test checked first",
            "Handle radius of 12px",
            "Body hit test as fallback"
        ]
    },
    "CONN-001-T11": {
        "title": "Add ConnectorHoverZone enum",
        "epic": "CONN-001",
        "phase": "Phase 3: Hit Testing",
        "effort": "0.1 days",
        "status": "readyForDev",
        "description": "Enum for tracking which part of connector is hovered",
        "dependencies": [],
        "files": ["lib/features/space/domain/models/objects/connector_hover_zone.dart"],
        "modules": ["lib/features/space/domain/models/objects/"],
        "acceptance": [
            "Values: body, startHandle, endHandle"
        ]
    },
    "CONN-001-T12": {
        "title": "Test hit detection accuracy",
        "epic": "CONN-001",
        "phase": "Phase 3: Hit Testing",
        "effort": "0.4 days",
        "status": "readyForDev",
        "description": "Unit tests for ConnectorHitTestVisitor",
        "dependencies": ["CONN-001-T09", "CONN-001-T10"],
        "files": ["test/features/space/domain/models/objects/visitors/connector_hit_test_visitor_test.dart"],
        "modules": ["test/features/space/domain/models/objects/visitors/"],
        "acceptance": [
            "Detects hit on start handle",
            "Detects hit on end handle",
            "Detects hit on connector body with tolerance",
            "Misses when point outside tolerance"
        ]
    },
    "CONN-001-T13": {
        "title": "Integrate with existing selection system",
        "epic": "CONN-001",
        "phase": "Phase 4: Integration & Polish",
        "effort": "0.25 days",
        "status": "readyForDev",
        "description": "Ensure highlight system works with current selection logic",
        "dependencies": ["CONN-001-T01", "CONN-001-T05"],
        "files": ["Various selection-related files"],
        "modules": ["lib/features/space/view/"],
        "acceptance": [
            "Selected connectors remain highlighted",
            "Multi-selection works",
            "Selection persists across tool changes"
        ]
    },
    "CONN-001-T14": {
        "title": "Add cursor changes",
        "epic": "CONN-001",
        "phase": "Phase 4: Integration & Polish",
        "effort": "0.25 days",
        "status": "readyForDev",
        "description": "Update cursor based on hover zone",
        "dependencies": ["CONN-001-T11"],
        "files": ["Cursor management files"],
        "modules": ["lib/features/space/view/pages/"],
        "acceptance": [
            "Cursor types: pointer, grab, grabbing"
        ]
    },
    "CONN-001-T15": {
        "title": "Performance optimization for many connectors",
        "epic": "CONN-001",
        "phase": "Phase 4: Integration & Polish",
        "effort": "0.25 days",
        "status": "readyForDev",
        "description": "Optimize for scenes with 50+ connectors",
        "dependencies": ["CONN-001-T05"],
        "files": ["Performance optimization in paint visitor and BLoC"],
        "modules": ["lib/features/space/domain/models/objects/visitors/"],
        "acceptance": [
            "Dirty region repainting",
            "Cache paint objects",
            "Debounce hover events to 16ms",
            "Culling for off-screen connectors"
        ]
    },
    "CONN-001-T16": {
        "title": "Documentation and examples",
        "epic": "CONN-001",
        "phase": "Phase 4: Integration & Polish",
        "effort": "0.25 days",
        "status": "readyForDev",
        "description": "Add inline docs and usage examples",
        "dependencies": ["All CONN-001 tasks"],
        "files": ["Various code files with documentation"],
        "modules": ["Documentation files"],
        "acceptance": [
            "Inline documentation added",
            "Usage examples provided"
        ]
    },
    "CONN-001-T17": {
        "title": "Widget tests for connector highlighting",
        "epic": "CONN-001",
        "phase": "Phase 4: Integration & Polish",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Widget tests for highlight functionality",
        "dependencies": ["CONN-001-T05", "CONN-001-T06"],
        "files": ["test/features/space/view/widgets/connector_highlight_test.dart"],
        "modules": ["test/features/space/view/widgets/"],
        "acceptance": [
            "Connector highlights on hover",
            "Selection shows different color than hover",
            "Handles appear on hover and selection",
            "Multiple connectors can be selected"
        ]
    },
    "CONN-001-T18": {
        "title": "Manual testing checklist completion",
        "epic": "CONN-001",
        "phase": "Phase 4: Integration & Polish",
        "effort": "0.5 days",
        "status": "readyForDev",
        "description": "Complete manual testing checklist",
        "dependencies": ["All CONN-001 tasks"],
        "files": ["Manual testing documentation"],
        "modules": ["N/A (Manual Testing)"],
        "acceptance": [
            "All manual test cases pass",
            "Performance verified with 50+ connectors",
            "Works on different zoom levels"
        ]
    },
}

# Epic information
EPIC_INFO = {
    "CONN-001": "Enhanced Connector Highlighting",
    "CONN-002": "Cubic Bézier Curves",
    "CONN-003": "Dynamic Endpoint Editing",
    "CONN-004": "Magnetic Connector Creation"
}


def create_tracker_file(task_id, task_data, tracker_dir):
    """Create a tracker file for a single task"""

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Format dependencies
    deps = ", ".join(task_data["dependencies"]) if task_data["dependencies"] else "None"

    # Format affected modules
    modules_str = "\n".join([f"  - {m}" for m in task_data["modules"]])

    # Format acceptance criteria
    criteria_str = "\n".join([f"- {c}" for c in task_data["acceptance"]])

    # Format files
    files_str = "\n".join([f"- {f}" for f in task_data["files"]])

    # Epic full name
    epic_full = f"{task_data['epic']}: {EPIC_INFO[task_data['epic']]}"

    content = f"""---
issue: {task_id}
status: {task_data['status']}
epic: {task_data['epic']}
phase: {task_data['phase']}
effort: {task_data['effort']}
description: {task_data['description']}
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
{task_data['phase']}

### Title
{task_data['title']}

### Description
{task_data['description']}

### Effort Estimate
{task_data['effort']}

### Dependencies
{deps}

### Status
{task_data['status']}

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
- Status: {task_data['status']}
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
    filepath = tracker_dir / f"{task_id}.md"
    filepath.write_text(content)
    print(f"✓ Created {filepath}")


def main():
    """Generate all tracker files"""

    # Get project root (assuming script is in scripts/)
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    tracker_dir = project_root / "tracker"

    # Create tracker directory
    tracker_dir.mkdir(exist_ok=True)

    print(f"Generating tracker files in {tracker_dir}\n")

    # Generate files for all tasks
    count = 0
    for task_id, task_data in TASKS.items():
        create_tracker_file(task_id, task_data, tracker_dir)
        count += 1

    print(f"\n✅ Successfully generated {count} tracker files")
    print(f"📁 Location: {tracker_dir}")
    print("\nNote: This script currently includes 18 CONN-001 tasks.")
    print("To complete all 89 tasks, the TASKS dictionary needs to be expanded")
    print("with data for CONN-002 (24 tasks), CONN-003 (26 tasks), and CONN-004 (21 tasks).")


if __name__ == "__main__":
    main()
