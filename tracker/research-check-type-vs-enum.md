# Research: Check by Type vs Check by Enum

**Status:** Open
**Created:** 2026-02-16
**Context:**
The user questioned whether checking by type (runtime check) or checking by enum property is better for performance and code style in the following locations:

1.  **ConnectorHandleGestureHandler**:
    ```dart
    // lib/features/space/view/pages/tool_handler/gestures/connector_handle_gesture_handler.dart:30
    if (hitNode is ConnectorNode) { ... }
    ```

2.  **HasMovedVisitor**:
    ```dart
    // lib/features/space/domain/models/visitors/has_moved_visitor.dart:15
    if (current is! ShapeNode) return false;
    ```

**Objectives:**
- [ ] Benchmark performance of `is Type` vs `obj.type == Enum.value` in Dart (AOT and JIT).
- [ ] Analyze maintainability implications (e.g., if class hierarchy changes vs if enum definition changes).
- [ ] Recommend a consistent pattern for the codebase.

**References:**
- Dart Type System
- Flutter Performance Best Practices
