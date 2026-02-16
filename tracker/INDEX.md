# Connector Enhancement Tasks - Tracker Index

**Generated:** 2026-02-16
**Total Tasks:** 89
**Project:** Connector System Improvements

---

## Quick Navigation

- [CONN-001: Enhanced Connector Highlighting](#conn-001-enhanced-connector-highlighting) (18 tasks)
- [CONN-002: Cubic Bézier Curves](#conn-002-cubic-bézier-curves) (24 tasks)
- [CONN-003: Dynamic Endpoint Editing](#conn-003-dynamic-endpoint-editing) (26 tasks)
- [CONN-004: Magnetic Connector Creation](#conn-004-magnetic-connector-creation) (21 tasks)

---

## Implementation Status

### Overall Progress
- 🔴 Not Started: 89 tasks (100%)
- 🟡 In Progress: 0 tasks (0%)
- 🟢 Completed: 0 tasks (0%)

### By Epic
| Epic | Total | Ready | In Progress | Completed | Priority |
|------|-------|-------|-------------|-----------|----------|
| CONN-001 | 18 | 18 | 0 | 0 | High |
| CONN-002 | 24 | 24 | 0 | 0 | Medium |
| CONN-003 | 26 | 26 | 0 | 0 | High |
| CONN-004 | 21 | 21 | 0 | 0 | High |

---

## CONN-001: Enhanced Connector Highlighting

**Priority:** High | **Effort:** 5-6 days | **Dependencies:** None

### Phase 1: Foundation (1-2 days)
- [CONN-001-T01](CONN-001-T01.md) - Create ConnectorHighlightBloc (0.5d)
- [CONN-001-T02](CONN-001-T02.md) - Create ConnectorHighlightPainter (0.5d)
- [CONN-001-T03](CONN-001-T03.md) - Add hover state tracking to SelectConnectorToolHandler (0.5d) → T01
- [CONN-001-T04](CONN-001-T04.md) - Unit tests for highlight state management (0.5d) → T01

### Phase 2: Visual Enhancement (1-2 days)
- [CONN-001-T05](CONN-001-T05.md) - Update PaintVisitor to use highlight painter (0.5d) → T01, T02
- [CONN-001-T06](CONN-001-T06.md) - Implement ConnectorHandlePainter (0.5d)
- [CONN-001-T07](CONN-001-T07.md) - Add smooth transitions for hover states (0.5d) → T05
- [CONN-001-T08](CONN-001-T08.md) - Test visual feedback on different connector types (0.5d) → T05, T06

### Phase 3: Hit Testing (1 day)
- [CONN-001-T09](CONN-001-T09.md) - Enhance ConnectorHitTestVisitor with larger tolerance (0.25d)
- [CONN-001-T10](CONN-001-T10.md) - Implement separate hit testing for handles vs body (0.25d) → T09
- [CONN-001-T11](CONN-001-T11.md) - Add ConnectorHoverZone enum (0.1d)
- [CONN-001-T12](CONN-001-T12.md) - Test hit detection accuracy (0.4d) → T09, T10

### Phase 4: Integration & Polish (1 day)
- [CONN-001-T13](CONN-001-T13.md) - Integrate with existing selection system (0.25d) → T01, T05
- [CONN-001-T14](CONN-001-T14.md) - Add cursor changes (0.25d) → T11
- [CONN-001-T15](CONN-001-T15.md) - Performance optimization for many connectors (0.25d) → T05
- [CONN-001-T16](CONN-001-T16.md) - Documentation and examples (0.25d) → All T01-T15
- [CONN-001-T17](CONN-001-T17.md) - Widget tests for connector highlighting (0.5d) → T05, T06
- [CONN-001-T18](CONN-001-T18.md) - Manual testing checklist completion (0.5d) → All T01-T17

**Next Task:** [CONN-001-T01](CONN-001-T01.md) ✅ Ready to start

---

## CONN-002: Cubic Bézier Curves

**Priority:** Medium | **Effort:** 12-15 days | **Dependencies:** CONN-001

### Phase 1: Data Model & Basic Rendering (2-3 days)
- [CONN-002-T01](CONN-002-T01.md) - Update ConnectorNode model with Bézier fields (0.5d)
- [CONN-002-T02](CONN-002-T02.md) - Create BezierPathBuilder utility (0.5d)
- [CONN-002-T03](CONN-002-T03.md) - Update PaintVisitor to render curves (0.5d)
- [CONN-002-T04](CONN-002-T04.md) - Add migration for existing connectors (0.5d)
- [CONN-002-T05](CONN-002-T05.md) - Unit tests for path building (1d)

### Phase 2: Control Point Manipulation (2-3 days)
- [CONN-002-T06](CONN-002-T06.md) - Implement ControlPointGestureHandler (1d)
- [CONN-002-T07](CONN-002-T07.md) - Add visual rendering of control points (0.5d)
- [CONN-002-T08](CONN-002-T08.md) - Support dragging control points (1d)
- [CONN-002-T09](CONN-002-T09.md) - Integrate with ModifyNodeCommand for undo/redo (0.5d)
- [CONN-002-T10](CONN-002-T10.md) - Widget tests for control point interaction (1d)

### Phase 3: Smart Curve Generation (2-3 days)
- [CONN-002-T11](CONN-002-T11.md) - Implement SmartCurveGenerator (1d)
- [CONN-002-T12](CONN-002-T12.md) - Auto-calculate control points based on node directions (1d)
- [CONN-002-T13](CONN-002-T13.md) - Add tension/curvature adjustment (0.5d)
- [CONN-002-T14](CONN-002-T14.md) - Test different curve shapes (0.5d)

### Phase 4: Hit Testing (1-2 days)
- [CONN-002-T15](CONN-002-T15.md) - Create BezierHitTestVisitor (1d)
- [CONN-002-T16](CONN-002-T16.md) - Implement sample-based hit testing (0.5d)
- [CONN-002-T17](CONN-002-T17.md) - Optimize performance (0.5d)
- [CONN-002-T18](CONN-002-T18.md) - Test accuracy with thin curves (0.5d)

### Phase 5: UI Controls (1-2 days)
- [CONN-002-T19](CONN-002-T19.md) - Add toolbar button for connector type (0.5d)
- [CONN-002-T20](CONN-002-T20.md) - Add context menu options (0.5d)
- [CONN-002-T21](CONN-002-T21.md) - Keyboard shortcut to toggle connector type (0.25d)
- [CONN-002-T22](CONN-002-T22.md) - Settings for default connector type (0.25d)

### Phase 6: Testing & Polish (2-3 days)
- [CONN-002-T23](CONN-002-T23.md) - Integration tests for curved connectors (1d)
- [CONN-002-T24](CONN-002-T24.md) - Manual testing checklist completion (1d)

**Blocked by:** CONN-001-T18

---

## CONN-003: Dynamic Endpoint Editing

**Priority:** High | **Effort:** 8-10 days | **Dependencies:** CONN-001, Command Pattern

### Phase 1: Data Model Migration (2 days)
- [CONN-003-T01](CONN-003-T01.md) - Create ConnectorEndpoint model (0.5d)
- [CONN-003-T02](CONN-003-T02.md) - Create AttachmentPoint enum (0.1d)
- [CONN-003-T03](CONN-003-T03.md) - Update ConnectorNode with new endpoint fields (0.5d)
- [CONN-003-T04](CONN-003-T04.md) - Add backward compatibility for old connectors (0.5d)
- [CONN-003-T05](CONN-003-T05.md) - Unit tests for new models (0.4d)

### Phase 2: Attachment Point System (2-3 days)
- [CONN-003-T06](CONN-003-T06.md) - Implement AttachmentPointCalculator (1d)
- [CONN-003-T07](CONN-003-T07.md) - Create ConnectorAttachmentManager (1d)
- [CONN-003-T08](CONN-003-T08.md) - Add attachment point visualization (0.5d)
- [CONN-003-T09](CONN-003-T09.md) - Test attachment point calculations (0.5d)

### Phase 3: Endpoint Dragging (2-3 days)
- [CONN-003-T10](CONN-003-T10.md) - Implement EndpointDragHandler (1.5d)
- [CONN-003-T11](CONN-003-T11.md) - Add snap detection and preview (1d)
- [CONN-003-T12](CONN-003-T12.md) - Integrate with gesture handler chain (0.25d)
- [CONN-003-T13](CONN-003-T13.md) - Visual feedback during drag (0.25d)

### Phase 4: Auto-Update Connectors (1-2 days)
- [CONN-003-T14](CONN-003-T14.md) - Update MoveVisitor to notify connectors (0.5d)
- [CONN-003-T15](CONN-003-T15.md) - Add listener system for object movements (0.5d)
- [CONN-003-T16](CONN-003-T16.md) - Handle batch moves (multiple objects) (0.5d)
- [CONN-003-T17](CONN-003-T17.md) - Test with complex diagrams (0.5d)

### Phase 5: UI Polish (1-2 days)
- [CONN-003-T18](CONN-003-T18.md) - Smooth animations for snapping (0.5d)
- [CONN-003-T19](CONN-003-T19.md) - Cursor changes (0.25d)
- [CONN-003-T20](CONN-003-T20.md) - Hover effects on attachment points (0.25d)
- [CONN-003-T21](CONN-003-T21.md) - Error states (invalid attachment) (0.5d)

### Phase 6: Edge Cases (1 day)
- [CONN-003-T22](CONN-003-T22.md) - Handle deletion of attached objects (0.25d)
- [CONN-003-T23](CONN-003-T23.md) - Handle grouped objects (0.25d)
- [CONN-003-T24](CONN-003-T24.md) - Handle undo/redo with attachments (0.25d)
- [CONN-003-T25](CONN-003-T25.md) - Circular connector detection (0.25d)
- [CONN-003-T26](CONN-003-T26.md) - Integration and manual testing (1d)

**Blocked by:** CONN-001-T18

---

## CONN-004: Magnetic Connector Creation

**Priority:** High | **Effort:** 8-10 days | **Dependencies:** CONN-003

### Phase 1: Snap Detection (2 days)
- [CONN-004-T01](CONN-004-T01.md) - Implement MagneticSnapDetector (1d)
- [CONN-004-T02](CONN-004-T02.md) - Add SnapTarget model (0.25d)
- [CONN-004-T03](CONN-004-T03.md) - Test snap detection accuracy (0.5d)
- [CONN-004-T04](CONN-004-T04.md) - Add configuration for snap radius (0.25d)

### Phase 2: Visual Preview (2 days)
- [CONN-004-T05](CONN-004-T05.md) - Create ConnectorPreviewPainter (1d)
- [CONN-004-T06](CONN-004-T06.md) - Implement ConnectorPreviewBloc (0.5d)
- [CONN-004-T07](CONN-004-T07.md) - Add ConnectorPreviewLayer widget (0.25d)
- [CONN-004-T08](CONN-004-T08.md) - Test preview rendering (0.25d)

### Phase 3: Tool Integration (1-2 days)
- [CONN-004-T09](CONN-004-T09.md) - Update ConnectorToolHandler with magnetic logic (0.5d)
- [CONN-004-T10](CONN-004-T10.md) - Add keyboard modifier support (Shift to disable) (0.25d)
- [CONN-004-T11](CONN-004-T11.md) - Handle edge cases (0.5d)
- [CONN-004-T12](CONN-004-T12.md) - Test connector creation flow (0.5d)

### Phase 4: Smart Attachment Selection (1 day)
- [CONN-004-T13](CONN-004-T13.md) - Implement approach angle detection (0.25d)
- [CONN-004-T14](CONN-004-T14.md) - Add preference for edge vs corner attachment (0.25d)
- [CONN-004-T15](CONN-004-T15.md) - Test with various object configurations (0.25d)
- [CONN-004-T16](CONN-004-T16.md) - Fine-tune attachment point selection (0.25d)

### Phase 5: Polish & UX (1-2 days)
- [CONN-004-T17](CONN-004-T17.md) - Add smooth animations for snap effect (0.5d)
- [CONN-004-T18](CONN-004-T18.md) - Implement magnetic "pull" feeling (0.25d)
- [CONN-004-T19](CONN-004-T19.md) - Add audio/haptic feedback (optional) (0.25d)
- [CONN-004-T20](CONN-004-T20.md) - Cursor changes during snap (0.25d)

### Phase 6: Settings & Testing (1-2 days)
- [CONN-004-T21](CONN-004-T21.md) - User settings and manual testing (1d)

**Blocked by:** CONN-003-T26

---

## Dependency Graph

```
CONN-001 (No dependencies)
  │
  ├─> CONN-002 (Needs highlight system)
  │
  └─> CONN-003 (Needs highlight system)
       │
       └─> CONN-004 (Needs attachment point system)
```

---

## Usage with Workflows

### Starting a Task (are-u-ready workflow)

```bash
# Option 1: Specify task ID
are-u-ready CONN-001-T01

# Option 2: Let the agent pick next task
are-u-ready
```

### Completing a Session (landing-plane workflow)

```bash
land-the-plane
```

The agent will:
1. Update the tracker file for completed tasks
2. Commit all changes
3. Generate next session prompt

---

## File Structure

```
tracker/
├── INDEX.md                 # This file
├── CONN-001-T01.md         # Task trackers
├── CONN-001-T02.md
├── ...
└── CONN-004-T21.md

docs/plans/
├── connector-enhancements-roadmap.md      # Overall roadmap
├── connector-tasks-breakdown.md           # Detailed task breakdown
├── epic-connector-highlighting.md         # CONN-001 details
├── epic-connector-bezier-curves.md        # CONN-002 details
├── epic-connector-endpoint-editing.md     # CONN-003 details
└── epic-connector-magnetic-snapping.md    # CONN-004 details
```

---

## Next Steps

1. **Start with CONN-001-T01**: No dependencies, foundation task
2. **Use are-u-ready workflow**: Validate context and dependencies
3. **Update tracker files**: Log progress, decisions, and code changes
4. **Follow phase sequence**: Complete phases in order
5. **Test thoroughly**: Each task has acceptance criteria

---

## Statistics

- **Total Effort:** 33-41 days (4.5-5.5 weeks)
- **Average Task Size:** 0.5 days
- **Largest Epic:** CONN-003 (26 tasks)
- **Smallest Epic:** CONN-001 (18 tasks)
- **Critical Path:** CONN-001 → CONN-003 → CONN-004

---

**Last Updated:** 2026-02-16
**Generated By:** parse_and_generate_trackers.py
