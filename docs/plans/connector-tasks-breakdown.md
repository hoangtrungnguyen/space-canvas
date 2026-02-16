# Connector Enhancements - Complete Task Breakdown

**Created:** 2026-02-16
**Status:** Ready for Implementation
**Total Tasks:** 89 tasks across 4 epics
**Total Effort:** 33-41 days (4.5-5.5 weeks)

---

## Task Overview by Epic

| Epic | Tasks | Effort | Priority | Dependencies |
|------|-------|--------|----------|--------------|
| **CONN-001** Enhanced Connector Highlighting | 18 tasks | 5-6 days | High | None |
| **CONN-002** Cubic Bézier Curves | 24 tasks | 12-15 days | Medium | CONN-001 |
| **CONN-003** Dynamic Endpoint Editing | 26 tasks | 8-10 days | High | CONN-001, Command Pattern |
| **CONN-004** Magnetic Connector Creation | 21 tasks | 8-10 days | High | CONN-003 |

---

## EPIC CONN-001: Enhanced Connector Highlighting
**Priority:** High | **Effort:** 5-6 days | **Dependencies:** None

### Phase 1: Foundation (1-2 days)

#### CONN-001-T01: Create ConnectorHighlightBloc
- **File:** `lib/features/space/view/bloc/connector_highlight/connector_highlight_bloc.dart`
- **Description:** Create BLoC for managing connector highlight states (hover, selection)
- **Acceptance Criteria:**
  - ConnectorHighlightState with hoveredConnectorId, selectedConnectorIds, hoverZone
  - Events: HoverConnector, UnhoverConnector, SelectConnector, DeselectConnector
  - State transitions work correctly
- **Effort:** 0.5 days

#### CONN-001-T02: Create ConnectorHighlightPainter
- **File:** `lib/features/space/domain/models/objects/visitors/connector_highlight_painter.dart`
- **Description:** Enhanced painting logic for connectors with highlight states
- **Acceptance Criteria:**
  - Different stroke widths for normal, hover, selected states
  - Color changes based on state
  - Hit test padding for easier interaction
- **Effort:** 0.5 days

#### CONN-001-T03: Add hover state tracking to SelectConnectorToolHandler
- **File:** `lib/features/space/view/pages/tool_handler/implementations/select_connector_tool_handler.dart`
- **Description:** Update tool handler to track hover state and emit events
- **Acceptance Criteria:**
  - onPanUpdate detects connector under cursor
  - Emits hover/unhover events to ConnectorHighlightBloc
  - Works with existing gesture handling
- **Effort:** 0.5 days

#### CONN-001-T04: Unit tests for highlight state management
- **File:** `test/features/space/view/bloc/connector_highlight/connector_highlight_bloc_test.dart`
- **Description:** Comprehensive tests for ConnectorHighlightBloc
- **Test Cases:**
  - Sets hover state on hover event
  - Clears hover on unhover event
  - Handles multiple selected connectors
  - State transitions are correct
- **Effort:** 0.5 days

### Phase 2: Visual Enhancement (1-2 days)

#### CONN-001-T05: Update PaintVisitor to use highlight painter
- **File:** `lib/features/space/domain/models/objects/visitors/paint_visitor.dart`
- **Description:** Integrate ConnectorHighlightPainter into existing paint logic
- **Acceptance Criteria:**
  - visitConnector uses highlight painter
  - Highlight state retrieved from context
  - Backward compatible with non-highlighted connectors
- **Effort:** 0.5 days

#### CONN-001-T06: Implement ConnectorHandlePainter
- **File:** `lib/features/space/view/painters/connector_handle_painter.dart`
- **Description:** Draw interactive handles on connector endpoints
- **Acceptance Criteria:**
  - Start and end handles visible when selected/hovered
  - Handles are circles with white fill and blue border
  - Handle hit areas larger than visual representation
- **Effort:** 0.5 days

#### CONN-001-T07: Add smooth transitions for hover states
- **File:** Various
- **Description:** Add AnimatedBuilder for smooth hover transitions
- **Acceptance Criteria:**
  - Hover state changes animate smoothly
  - Transition duration ~200ms
  - No performance impact
- **Effort:** 0.5 days

#### CONN-001-T08: Test visual feedback on different connector types
- **Description:** Manual testing of visual enhancements
- **Test Cases:**
  - Hover highlighting works
  - Selection highlighting distinct from hover
  - Handles appear correctly
  - Works on thin and thick connectors
- **Effort:** 0.5 days

### Phase 3: Hit Testing (1 day)

#### CONN-001-T09: Enhance ConnectorHitTestVisitor with larger tolerance
- **File:** `lib/features/space/domain/models/objects/visitors/connector_hit_test_visitor.dart`
- **Description:** Improve hit detection with wider tolerance area
- **Acceptance Criteria:**
  - Hit test tolerance of 8px
  - Point-to-line distance calculation accurate
  - Works for straight connectors
- **Effort:** 0.25 days

#### CONN-001-T10: Implement separate hit testing for handles vs body
- **File:** `lib/features/space/domain/models/objects/visitors/connector_hit_test_visitor.dart`
- **Description:** Priority hit testing for handles
- **Acceptance Criteria:**
  - Handle hit test checked first
  - Handle radius of 12px
  - Body hit test as fallback
- **Effort:** 0.25 days

#### CONN-001-T11: Add ConnectorHoverZone enum
- **File:** `lib/features/space/domain/models/objects/connector_hover_zone.dart`
- **Description:** Enum for tracking which part of connector is hovered
- **Values:** body, startHandle, endHandle
- **Effort:** 0.1 days

#### CONN-001-T12: Test hit detection accuracy
- **File:** `test/features/space/domain/models/objects/visitors/connector_hit_test_visitor_test.dart`
- **Test Cases:**
  - Detects hit on start handle
  - Detects hit on end handle
  - Detects hit on connector body with tolerance
  - Misses when point outside tolerance
- **Effort:** 0.4 days

### Phase 4: Integration & Polish (1 day)

#### CONN-001-T13: Integrate with existing selection system
- **Description:** Ensure highlight system works with current selection logic
- **Acceptance Criteria:**
  - Selected connectors remain highlighted
  - Multi-selection works
  - Selection persists across tool changes
- **Effort:** 0.25 days

#### CONN-001-T14: Add cursor changes
- **Description:** Update cursor based on hover zone
- **Cursor Types:** pointer, grab, grabbing
- **Effort:** 0.25 days

#### CONN-001-T15: Performance optimization for many connectors
- **Description:** Optimize for scenes with 50+ connectors
- **Optimizations:**
  - Dirty region repainting
  - Cache paint objects
  - Debounce hover events to 16ms
  - Culling for off-screen connectors
- **Effort:** 0.25 days

#### CONN-001-T16: Documentation and examples
- **Description:** Add inline docs and usage examples
- **Effort:** 0.25 days

#### CONN-001-T17: Widget tests for connector highlighting
- **File:** `test/features/space/view/widgets/connector_highlight_test.dart`
- **Test Cases:**
  - Connector highlights on hover
  - Selection shows different color than hover
  - Handles appear on hover and selection
  - Multiple connectors can be selected
- **Effort:** 0.5 days

#### CONN-001-T18: Manual testing checklist completion
- **Checklist:**
  - ✓ Hover over connector shows highlight
  - ✓ Selection shows different color than hover
  - ✓ Handles appear on hover and selection
  - ✓ Multiple connectors can be selected
  - ✓ Highlight clears when moving away
  - ✓ Performance smooth with 50+ connectors
  - ✓ Works on different zoom levels
- **Effort:** 0.5 days

---

## EPIC CONN-002: Cubic Bézier Curves
**Priority:** Medium | **Effort:** 12-15 days | **Dependencies:** CONN-001

### Phase 1: Data Model & Basic Rendering (2-3 days)

#### CONN-002-T01: Update ConnectorNode model with Bézier fields
- **File:** `lib/features/space/domain/models/objects/node.dart`
- **Description:** Add ConnectorType enum and control point fields
- **Changes:**
  - Add `type` field (straight, bezier, orthogonal)
  - Add `controlPoint1` and `controlPoint2` optional fields
  - Add `routingMode` field (manual, autoSmooth, autoRoute)
- **Effort:** 0.5 days

#### CONN-002-T02: Create BezierPathBuilder utility
- **File:** `lib/features/space/domain/utils/bezier_path_builder.dart`
- **Description:** Build cubic Bézier curve paths from connector nodes
- **Acceptance Criteria:**
  - buildBezierPath() creates Path with cubic curve
  - Default control point calculation for S-curves
  - Works with custom control points
- **Effort:** 0.5 days

#### CONN-002-T03: Update PaintVisitor to render curves
- **File:** `lib/features/space/domain/models/objects/visitors/paint_visitor.dart`
- **Description:** Render Bézier curves in visitConnector
- **Acceptance Criteria:**
  - Checks connector type
  - Uses BezierPathBuilder for curved connectors
  - Falls back to straight lines for legacy connectors
- **Effort:** 0.5 days

#### CONN-002-T04: Add migration for existing connectors
- **Description:** Ensure backward compatibility with existing data
- **Migration:**
  - Old connectors default to ConnectorType.straight
  - Control points remain null for straight connectors
  - JSON serialization handles optional fields
- **Effort:** 0.5 days

#### CONN-002-T05: Unit tests for path building
- **File:** `test/features/space/domain/utils/bezier_path_builder_test.dart`
- **Test Cases:**
  - Builds cubic Bézier path with control points
  - Calculates default control points for S-curve
  - Handles null control points gracefully
- **Effort:** 1 day

### Phase 2: Control Point Manipulation (2-3 days)

#### CONN-002-T06: Implement ControlPointGestureHandler
- **File:** `lib/features/space/view/pages/tool_handler/gestures/control_point_gesture_handler.dart`
- **Description:** Handle dragging of control points
- **Acceptance Criteria:**
  - canHandle checks for control point hit
  - doHandle starts dragging control point
  - Works in gesture handler chain
- **Effort:** 1 day

#### CONN-002-T07: Add visual rendering of control points
- **File:** `lib/features/space/domain/models/objects/visitors/paint_visitor.dart`
- **Description:** Draw control points when connector selected
- **Visual Elements:**
  - Control point circles (blue fill)
  - Lines from endpoints to control points (dashed, semi-transparent)
  - Distinguishable from endpoint handles
- **Effort:** 0.5 days

#### CONN-002-T08: Support dragging control points
- **Description:** Interactive control point dragging
- **Acceptance Criteria:**
  - Mouse down on control point starts drag
  - Mouse move updates control point position
  - Mouse up commits change
  - Visual feedback during drag
- **Effort:** 1 day

#### CONN-002-T09: Integrate with ModifyNodeCommand for undo/redo
- **Description:** Ensure control point changes are undoable
- **Acceptance Criteria:**
  - Control point drag creates ModifyNodeCommand
  - Undo restores original control points
  - Redo reapplies changes
- **Effort:** 0.5 days

#### CONN-002-T10: Widget tests for control point interaction
- **File:** `test/features/space/view/widgets/control_point_test.dart`
- **Test Cases:**
  - Control points visible when selected
  - Can drag control point
  - Curve shape updates during drag
  - Undo restores original shape
- **Effort:** 1 day

### Phase 3: Smart Curve Generation (2-3 days)

#### CONN-002-T11: Implement SmartCurveGenerator
- **File:** `lib/features/space/domain/utils/smart_curve_generator.dart`
- **Description:** Auto-generate aesthetically pleasing curves
- **Functions:**
  - generateControlPoints() with direction vectors
  - Tension parameter (0.0 to 1.0)
  - Angle-based control point placement
- **Effort:** 1 day

#### CONN-002-T12: Auto-calculate control points based on node directions
- **Description:** Smart default curves based on object layout
- **Algorithm:**
  - Detect object orientations
  - Calculate natural flow direction
  - Generate smooth S-curves or C-curves
- **Effort:** 1 day

#### CONN-002-T13: Add tension/curvature adjustment
- **Description:** User-adjustable curve tension
- **UI Element:** Slider or numeric input
- **Range:** 0.0 (straight) to 1.0 (maximum curve)
- **Effort:** 0.5 days

#### CONN-002-T14: Test different curve shapes
- **Test Scenarios:**
  - Horizontal connections (left-right)
  - Vertical connections (top-bottom)
  - Diagonal connections
  - Backward connections (right-to-left)
  - Self-loops (object to itself)
- **Effort:** 0.5 days

### Phase 4: Hit Testing (1-2 days)

#### CONN-002-T15: Create BezierHitTestVisitor
- **File:** `lib/features/space/domain/models/objects/visitors/bezier_hit_test_visitor.dart`
- **Description:** Accurate hit testing for curved connectors
- **Methods:**
  - Path.contains() for stroke hit test
  - Sample-based hit test for accuracy
  - _evaluateBezier() for point on curve
- **Effort:** 1 day

#### CONN-002-T16: Implement sample-based hit testing
- **Description:** Sample curve at regular intervals for hit detection
- **Parameters:**
  - Sample count: 50 points
  - Tolerance: 8px
- **Effort:** 0.5 days

#### CONN-002-T17: Optimize performance
- **Optimizations:**
  - Bounding box check before sampling
  - Spatial indexing for multi-connector scenes
  - Cache sampled points
- **Effort:** 0.5 days

#### CONN-002-T18: Test accuracy with thin curves
- **Test Cases:**
  - Hit detection works on 1px curves
  - Works on 5px curves
  - Works on 10px curves
  - Tolerance adjusts for stroke width
- **Effort:** 0.5 days

### Phase 5: UI Controls (1-2 days)

#### CONN-002-T19: Add toolbar button for connector type
- **File:** `lib/features/space/view/widgets/toolbar/connector_type_button.dart`
- **Description:** Toggle between straight and curved
- **UI:** Icon button with dropdown
- **Effort:** 0.5 days

#### CONN-002-T20: Add context menu options
- **Menu Items:**
  - "Convert to Curved"
  - "Convert to Straight"
  - "Auto-smooth Curve"
  - "Edit Control Points"
- **Effort:** 0.5 days

#### CONN-002-T21: Keyboard shortcut to toggle connector type
- **Shortcut:** Cmd/Ctrl + Shift + L (Line type)
- **Behavior:** Toggles selected connector between straight/curved
- **Effort:** 0.25 days

#### CONN-002-T22: Settings for default connector type
- **File:** `lib/core/settings/connector_settings.dart`
- **Setting:** Default connector type (straight/curved)
- **Effort:** 0.25 days

### Phase 6: Testing & Polish (2-3 days)

#### CONN-002-T23: Integration tests for curved connectors
- **Test Cases:**
  - Create curved connector
  - Control points visible when selected
  - Drag control point to reshape curve
  - Undo/redo works
  - Convert between straight and curved
- **Effort:** 1 day

#### CONN-002-T24: Manual testing checklist completion
- **Checklist:**
  - ✓ Curved connectors render smoothly
  - ✓ Control points visible and draggable
  - ✓ Auto-generated curves look natural
  - ✓ Hit testing works on curved lines
  - ✓ Undo/redo works
  - ✓ Performance acceptable with 50+ curves
  - ✓ Curves export/import correctly
  - ✓ Backward compatibility with straight connectors
- **Effort:** 1 day

---

## EPIC CONN-003: Dynamic Endpoint Editing
**Priority:** High | **Effort:** 8-10 days | **Dependencies:** CONN-001, Command Pattern

### Phase 1: Data Model Migration (2 days)

#### CONN-003-T01: Create ConnectorEndpoint model
- **File:** `lib/features/space/domain/models/objects/connector_endpoint.dart`
- **Description:** Model for connector endpoints with object references
- **Fields:**
  - attachedNodeId (nullable)
  - attachmentPoint (nullable)
  - position (required)
- **Effort:** 0.5 days

#### CONN-003-T02: Create AttachmentPoint enum
- **File:** `lib/features/space/domain/models/objects/attachment_point.dart`
- **Values:** topLeft, topCenter, topRight, middleLeft, center, middleRight, bottomLeft, bottomCenter, bottomRight, custom
- **Effort:** 0.1 days

#### CONN-003-T03: Update ConnectorNode with new endpoint fields
- **File:** `lib/features/space/domain/models/objects/node.dart`
- **Changes:**
  - Add startEndpoint and endEndpoint fields
  - Deprecate old startPoint/endPoint
  - Add computed properties for positions
- **Effort:** 0.5 days

#### CONN-003-T04: Add backward compatibility for old connectors
- **Description:** Ensure old position-based connectors still work
- **Migration Logic:**
  - Convert old startPoint to ConnectorEndpoint with null attachedNodeId
  - Convert old endPoint similarly
  - JSON deserialization handles both formats
- **Effort:** 0.5 days

#### CONN-003-T05: Unit tests for new models
- **Test Cases:**
  - ConnectorEndpoint creation
  - AttachmentPoint enum values
  - ConnectorNode with endpoints
  - Backward compatibility migration
- **Effort:** 0.4 days

### Phase 2: Attachment Point System (2-3 days)

#### CONN-003-T06: Implement AttachmentPointCalculator
- **File:** `lib/features/space/domain/utils/attachment_point_calculator.dart`
- **Description:** Calculate attachment point positions for any node
- **Functions:**
  - getAttachmentPoints() - returns all 9 points
  - findNearestPoint() - finds closest to position
  - getPointPosition() - gets specific point position
- **Effort:** 1 day

#### CONN-003-T07: Create ConnectorAttachmentManager
- **File:** `lib/features/space/domain/managers/connector_attachment_manager.dart`
- **Description:** Manage connector-object relationships
- **Functions:**
  - updateConnectorsForNode() - update when object moves
  - attachEndpoint() - attach to node
  - detachEndpoint() - make free-floating
  - _recalculateConnectorPositions() - update positions
- **Effort:** 1 day

#### CONN-003-T08: Add attachment point visualization
- **File:** `lib/features/space/view/painters/attachment_point_painter.dart`
- **Description:** Draw attachment points on objects
- **Visual:**
  - Small circles at each attachment point
  - Highlighted when hovered
  - Color-coded by type
- **Effort:** 0.5 days

#### CONN-003-T09: Test attachment point calculations
- **Test Cases:**
  - Calculates all 9 points for rectangle
  - Finds nearest point correctly
  - Works with rotated objects
  - Works with different shape types
- **Effort:** 0.5 days

### Phase 3: Endpoint Dragging (2-3 days)

#### CONN-003-T10: Implement EndpointDragHandler
- **File:** `lib/features/space/view/pages/tool_handler/gestures/endpoint_drag_handler.dart`
- **Description:** Handle dragging connector endpoints
- **Lifecycle:**
  - canHandle() - check if near endpoint
  - doHandle() - start drag
  - _handleDragUpdate() - update preview
  - _handleDragEnd() - commit changes
- **Effort:** 1.5 days

#### CONN-003-T11: Add snap detection and preview
- **Description:** Show snap preview when dragging near objects
- **Features:**
  - Detect nearby objects (within 20px)
  - Find nearest attachment point
  - Show visual snap indicator
  - Update in real-time
- **Effort:** 1 day

#### CONN-003-T12: Integrate with gesture handler chain
- **Description:** Add EndpointDragHandler to CoR chain
- **Priority:** Should come before SelectConnectorToolHandler
- **Effort:** 0.25 days

#### CONN-003-T13: Visual feedback during drag
- **Features:**
  - Dashed line from start to cursor
  - Snap indicator pulse animation
  - Cursor changes (grab, grabbing)
- **Effort:** 0.25 days

### Phase 4: Auto-Update Connectors (1-2 days)

#### CONN-003-T14: Update MoveVisitor to notify connectors
- **File:** `lib/features/space/domain/models/objects/visitors/move_visitor.dart`
- **Description:** Update attached connectors when objects move
- **Changes:**
  - Call _updateAttachedConnectors() after moving node
  - Pass delta to ConnectorAttachmentManager
- **Effort:** 0.5 days

#### CONN-003-T15: Add listener system for object movements
- **Description:** Observer pattern for object move events
- **Implementation:**
  - NodeMovedEvent
  - ConnectorAttachmentManager subscribes
  - Batch updates for performance
- **Effort:** 0.5 days

#### CONN-003-T16: Handle batch moves (multiple objects)
- **Description:** Optimize for moving groups
- **Logic:**
  - Collect all affected connectors
  - Update all in single operation
  - Single repaint for all changes
- **Effort:** 0.5 days

#### CONN-003-T17: Test with complex diagrams
- **Test Scenarios:**
  - 10+ objects with 20+ connectors
  - Move single object with multiple connectors
  - Move group with internal/external connectors
  - Performance remains smooth
- **Effort:** 0.5 days

### Phase 5: UI Polish (1-2 days)

#### CONN-003-T18: Smooth animations for snapping
- **Description:** Animate snap transition
- **Animation:** Elastic easing, 200ms duration
- **Effort:** 0.5 days

#### CONN-003-T19: Cursor changes
- **Cursors:**
  - grab - hovering over endpoint
  - grabbing - dragging endpoint
  - pointer - hovering over attachment point
- **Effort:** 0.25 days

#### CONN-003-T20: Hover effects on attachment points
- **Effects:**
  - Scale up on hover
  - Glow effect
  - Color intensifies
- **Effort:** 0.25 days

#### CONN-003-T21: Error states (invalid attachment)
- **Scenarios:**
  - Cannot attach to self (show X icon)
  - Cannot attach to connector (show warning)
  - Attachment point occupied (optional)
- **Effort:** 0.5 days

### Phase 6: Edge Cases (1 day)

#### CONN-003-T22: Handle deletion of attached objects
- **Implementation:** Delete connector when attached object deleted
- **Option A (Recommended):** Auto-delete connector
- **Option B:** Detach and make free-floating
- **Effort:** 0.25 days

#### CONN-003-T23: Handle grouped objects
- **Logic:** Recursively update connectors for all group members
- **Test:** Move group, verify all member connectors update
- **Effort:** 0.25 days

#### CONN-003-T24: Handle undo/redo with attachments
- **Test Cases:**
  - Undo endpoint reattachment
  - Redo endpoint reattachment
  - Undo object deletion (restore connectors)
- **Effort:** 0.25 days

#### CONN-003-T25: Circular connector detection
- **Logic:** Allow connector from object to itself, use different attachment points
- **Effort:** 0.25 days

#### CONN-003-T26: Integration and manual testing
- **Checklist:**
  - ✓ Drag endpoint to different object
  - ✓ Attachment points show when dragging
  - ✓ Endpoint snaps to nearest point
  - ✓ Free-floating endpoints work
  - ✓ Moving object updates connectors
  - ✓ Undo/redo works
  - ✓ Deleting object handles connectors
  - ✓ Performance with 20+ connectors
- **Effort:** 1 day

---

## EPIC CONN-004: Magnetic Connector Creation
**Priority:** High | **Effort:** 8-10 days | **Dependencies:** CONN-003

### Phase 1: Snap Detection (2 days)

#### CONN-004-T01: Implement MagneticSnapDetector
- **File:** `lib/features/space/domain/utils/magnetic_snap_detector.dart`
- **Description:** Detect nearby objects and calculate snap targets
- **Functions:**
  - findSnapTarget() - find best snap target
  - _calculateSnapTarget() - evaluate single target
  - _selectBestAttachmentPoint() - based on approach angle
  - _calculateMagneticStrength() - distance-based strength
- **Effort:** 1 day

#### CONN-004-T02: Add SnapTarget model
- **File:** `lib/features/space/domain/models/objects/snap_target.dart`
- **Fields:**
  - nodeId, node, attachmentPoint, snapPosition
  - distance, magneticStrength
- **Computed:** isStrongSnap (magneticStrength > 0.7)
- **Effort:** 0.25 days

#### CONN-004-T03: Test snap detection accuracy
- **Test Cases:**
  - Finds snap target within radius (30px)
  - Returns null when no objects in range
  - Selects best attachment point based on approach angle
  - Excludes specified nodes
  - Magnetic strength calculation correct
- **Effort:** 0.5 days

#### CONN-004-T04: Add configuration for snap radius
- **File:** `lib/core/settings/magnetic_snap_settings.dart`
- **Settings:**
  - snapRadius (default: 30px)
  - strongSnapRadius (default: 15px)
  - User-adjustable via settings UI
- **Effort:** 0.25 days

### Phase 2: Visual Preview (2 days)

#### CONN-004-T05: Create ConnectorPreviewPainter
- **File:** `lib/features/space/view/painters/connector_preview_painter.dart`
- **Description:** Draw preview line during connector creation
- **Features:**
  - Solid line when snapped (blue)
  - Dashed line when not snapped (gray)
  - Snap indicator at attachment point
  - Pulsing circle effect based on magnetic strength
- **Effort:** 1 day

#### CONN-004-T06: Implement ConnectorPreviewBloc
- **File:** `lib/features/space/view/bloc/connector_preview/connector_preview_bloc.dart`
- **Description:** Manage connector preview state
- **State:**
  - startPoint, endPoint, snapTarget, isVisible
- **Events:**
  - UpdatePreview, HidePreview
- **Effort:** 0.5 days

#### CONN-004-T07: Add ConnectorPreviewLayer widget
- **File:** `lib/features/space/view/widgets/connector_preview_layer.dart`
- **Description:** Render preview overlay on canvas
- **Implementation:**
  - BlocBuilder for ConnectorPreviewBloc
  - CustomPaint with ConnectorPreviewPainter
  - Positioned above canvas, below toolbar
- **Effort:** 0.25 days

#### CONN-004-T08: Test preview rendering
- **Test Cases:**
  - Preview line shows when creating connector
  - Preview updates in real-time
  - Snap indicator appears correctly
  - Preview hidden when not creating connector
- **Effort:** 0.25 days

### Phase 3: Tool Integration (1-2 days)

#### CONN-004-T09: Update ConnectorToolHandler with magnetic logic
- **File:** `lib/features/space/view/pages/tool_handler/implementations/connector_tool_handler.dart`
- **Changes:**
  - onTapUp checks for snap target
  - Uses snap position instead of cursor position
  - Creates connector with ConnectorEndpoint (with attachments)
- **Effort:** 0.5 days

#### CONN-004-T10: Add keyboard modifier support (Shift to disable)
- **Description:** Hold Shift to disable snapping
- **Implementation:**
  - Check HardwareKeyboard.instance.isShiftPressed
  - Skip snap detection when Shift held
  - Visual indicator (cursor or tooltip)
- **Effort:** 0.25 days

#### CONN-004-T11: Handle edge cases
- **Cases:**
  - No snap targets available
  - Overlapping objects (choose nearest)
  - Start and end on same object (circular)
  - Object deleted while creating connector
- **Effort:** 0.5 days

#### CONN-004-T12: Test connector creation flow
- **Test Cases:**
  - Click near object, connector snaps
  - Click far from object, connector free-floating
  - Shift disables snapping
  - Preview shows correctly
  - Created connector has correct endpoints
- **Effort:** 0.5 days

### Phase 4: Smart Attachment Selection (1 day)

#### CONN-004-T13: Implement approach angle detection
- **Description:** Calculate approach angle from cursor position
- **Algorithm:**
  - Angle from object center to cursor
  - Map angle to edge (right, bottom, left, top)
- **Effort:** 0.25 days

#### CONN-004-T14: Add preference for edge vs corner attachment
- **Logic:**
  - Prefer edge centers (middleLeft, topCenter) over corners
  - Corners used when approach is diagonal
  - User setting to always prefer edges
- **Effort:** 0.25 days

#### CONN-004-T15: Test with various object configurations
- **Configurations:**
  - Objects side-by-side (horizontal)
  - Objects stacked (vertical)
  - Objects diagonal
  - Small objects
  - Large objects
  - Rotated objects
- **Effort:** 0.25 days

#### CONN-004-T16: Fine-tune attachment point selection
- **Adjustments:**
  - Angle ranges for each edge
  - Distance weighting
  - Object size consideration
  - User feedback integration
- **Effort:** 0.25 days

### Phase 5: Polish & UX (1-2 days)

#### CONN-004-T17: Add smooth animations for snap effect
- **Animations:**
  - Snap indicator pulse (scale 1.0 to 1.2)
  - Preview line smooth follow (lerp)
  - Elastic snap when clicking
- **Effort:** 0.5 days

#### CONN-004-T18: Implement magnetic "pull" feeling
- **Description:** Cursor slightly attracted to snap point
- **Implementation:**
  - Offset cursor position toward snap point
  - Strength based on magneticStrength
  - Optional setting (some users prefer no pull)
- **Effort:** 0.25 days

#### CONN-004-T19: Add audio/haptic feedback (optional)
- **Features:**
  - Subtle "click" sound when snapping
  - Haptic feedback on mobile/trackpad
  - User setting to enable/disable
- **Effort:** 0.25 days

#### CONN-004-T20: Cursor changes during snap
- **Cursors:**
  - crosshair - creating connector
  - crosshair + blue dot - near snap target
  - grab - about to snap
- **Effort:** 0.25 days

### Phase 6: Settings & Testing (1-2 days)

#### CONN-004-T21: User settings and manual testing
- **Settings:**
  - Enable/disable magnetic snapping
  - Adjust snap sensitivity (radius)
  - Audio/haptic feedback toggle
  - Attachment point algorithm preference
- **Manual Testing:**
  - ✓ Connector snaps to objects within ~30px
  - ✓ Preview line follows cursor smoothly
  - ✓ Snap indicator appears at attachment point
  - ✓ Shift disables snapping
  - ✓ Works for both start and end points
  - ✓ Attachment point selection feels intuitive
  - ✓ Preview updates at 60fps
  - ✓ Works with zoomed canvas
  - ✓ Works with rotated objects
- **Effort:** 1 day

---

## Implementation Sequence (Recommended)

### Week 1-2: Foundation
1. **CONN-001** (5-6 days) - Enhanced Connector Highlighting
   - Immediate UX improvement
   - Foundation for other epics
   - No dependencies

### Week 2-3: Restructuring
2. **CONN-003** (8-10 days) - Dynamic Endpoint Editing
   - Critical for user workflow
   - Enables diagram restructuring
   - Depends on CONN-001

### Week 3-4: Creation UX
3. **CONN-004** (8-10 days) - Magnetic Connector Creation
   - Dramatically improves creation UX
   - Builds on CONN-003 attachment system
   - Depends on CONN-003

### Week 4-5: Visual Polish
4. **CONN-002** (12-15 days) - Cubic Bézier Curves
   - Professional visual quality
   - Most complex implementation
   - Can be implemented independently
   - Depends on CONN-001

---

## Task Dependencies Graph

```
CONN-001 (No dependencies)
  ├─> CONN-002 (Needs highlight system for control points)
  └─> CONN-003 (Needs highlight system for endpoints)
       └─> CONN-004 (Needs attachment point system)
```

---

## Risk Mitigation

### High Risk Tasks
1. **CONN-002-T15** - Bézier hit testing performance
   - **Mitigation:** Implement spatial indexing, optimize sampling

2. **CONN-003-T14-T17** - Auto-update connector system
   - **Mitigation:** Thorough testing with complex diagrams, batch updates

3. **CONN-004-T09-T12** - Tool integration with magnetic snapping
   - **Mitigation:** Extensive manual testing, user feedback

### Medium Risk Tasks
1. **CONN-001-T15** - Performance with many connectors
   - **Mitigation:** Profiling, optimization passes

2. **CONN-003-T22-T25** - Edge cases (deletion, groups, undo)
   - **Mitigation:** Comprehensive test coverage

---

## Success Metrics

### CONN-001 Success
- ✅ Connector selection accuracy +30%
- ✅ Hover works within 0.5s
- ✅ Zero performance degradation with 100 connectors

### CONN-002 Success
- ✅ 80%+ of new connectors use curves
- ✅ Control point manipulation <16ms latency
- ✅ Zero curve rendering crashes

### CONN-003 Success
- ✅ Endpoint drag-and-drop success rate >95%
- ✅ Snap accuracy >98%
- ✅ Diagram restructuring time -50%

### CONN-004 Success
- ✅ Connector creation accuracy +80%
- ✅ Creation time -40%
- ✅ First-attempt success rate >95%

---

**Last Updated:** 2026-02-16
**Status:** Ready for Implementation
