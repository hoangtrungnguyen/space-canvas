# Issue: task-2026-02-16-tool-handler-cor
**Description:** Implemented Chain of Responsibility pattern for gesture handling in `SelectToolHandler`. Created `GestureHandler` chain (Resize -> Connector -> Node -> Background) to replace complex nested conditionals.
**Timestamp:** 2026-02-16 13:30:00
**Affected Modules:**
  - lib/features/space/view/pages/tool_handler/gestures/
  - lib/features/space/view/pages/tool_handler/implementations/select_tool_handler.dart
  - lib/features/space/view/pages/tool_handler/base_tool_handler.dart
  - test/features/space/view/pages/tool_handler/gestures/

---

## Session Details
### Completed Work (Phase 2.6)
1.  **Infrastructure:** Created `GestureEvent` wrapper and `GestureHandler` abstract base class with strict `canHandle` -> `doHandle` flow.
2.  **Concrete Handlers:**
    -   `ResizeHandleGestureHandler`: Priority 1 (Pan only). Detects hits on resize handles of active nodes.
    -   `ConnectorGestureHandler`: Priority 2 (Tap/Pan). Detects hits on connectors -> switches tool.
    -   `NodeGestureHandler`: Priority 3 (Tap/Pan). Detects hits on regular nodes -> selects.
    -   `BackgroundGestureHandler`: Priority 4 (Fallback). Deselects everything via mediator.
3.  **Tool Integration:** Refactored `SelectToolHandler` to use `GestureChainBuilder`.
    -   **Tap Chain:** Connector -> Node -> Background (skips resize handles).
    -   **Pan Chain:** Resize Handle -> Connector -> Node -> Background.
4.  **Utilities:** Enhanced `BaseToolHandler` with helper methods (`getScale`, `hitTestNode`, etc.).
5.  **Testing:** Added 35 new unit tests covering all gesture handlers and chain logic. Updated `SelectToolHandler` tests. All 73 tests passing.

### Technical Decisions
-   **Chain Split:** Split into "Tap Chain" and "Pan Chain" because tapping a resize handle should select the node, not resize it. Only dragging a handle initiates resize.
-   **Mocktail Constraints:** Tests required careful setup of `hitTest` mocks to handle optional `filter` parameters correctly.
-   **Mediator Interaction:** `BackgroundGestureHandler` uses `mediator.selectAt(..., filter: excludeConnectors)` to trigger internal deselection logic in `SelectionManager`, rather than a dedicated `deselectAll` method (which didn't exist).

### Next Steps
-   Refactor `SelectConnectorToolHandler` to potentially use CoR. [COMPLETED Phase 2.7]
-   Implement Command Pattern (Undo/Redo).

### Completed Work (Phase 2.7)
1.  **Refactoring:** Migrated `SelectConnectorToolHandler` to Chain of Responsibility.
2.  **New Handlers:**
    -   `ConnectorHandleGestureHandler`: Priority 1 (Pan Start). Detects drag on start/end handles for reshaping.
    -   `ConnectorBodyGestureHandler`: Priority 2 (Tap/Pan). Detects hits on connector body for selection/movement.
    -   `ConnectorBackgroundGestureHandler`: Priority 3 (Fallback). handle background taps/drags (deselect).
3.  **Testing:** Added comprehensive unit tests for all new handlers and verified `SelectConnectorToolHandler` with regression tests.

