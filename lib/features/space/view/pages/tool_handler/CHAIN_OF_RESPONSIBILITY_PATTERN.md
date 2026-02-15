# Chain of Responsibility Pattern for Tool Handlers

**Status:** Documentation Only - Not Yet Implemented
**Priority:** Phase 3 Enhancement
**Related:** [Tool Handler Architecture Refactoring](../../../../../docs/plans/tool-handler-architecture-refactoring.md)

---

## Overview

The Chain of Responsibility (CoR) pattern is a behavioral design pattern that allows an object to pass a request along a chain of potential handlers until one handles it. This pattern is particularly useful for our canvas tool handlers when dealing with complex hit-testing and gesture routing logic.

## Problem Statement

### Current Issues in Our Codebase

Looking at handlers like `SelectToolHandler` and `SelectConnectorToolHandler`, we have complex conditional logic for determining what action to take:

```dart
// Current approach in SelectToolHandler.onPanStart
void onPanStart(DragStartDetails details, BuildContext context, TransformationController controller) {
  final worldPoint = toWorldPoint(details.localPosition, controller);
  final activeBloc = getActiveLayerBloc(context);
  final state = activeBloc.state;

  // Check for resize handle
  ResizeHandle? hitHandle;
  if (state.activeNodes.isNotEmpty) {
    final scale = controller.value.getMaxScaleOnAxis();
    final hitRadius = 20.0 / scale;

    for (final node in state.activeNodes.values) {
      final rect = node.rect.inflate(4.0);
      hitHandle = _getHitHandle(worldPoint, rect, hitRadius);
      if (hitHandle != null) break;
    }
  }

  if (hitHandle != null) {
    // Start Resize - highest priority
    activeBloc.add(ActiveLayerEvent.handleChanged(hitHandle));
    // ... resize logic
  } else {
    // Check for connector
    final mediator = getMediator(context);
    final hitNode = mediator.hitTest(worldPoint);

    if (hitNode is ConnectorNode) {
      // Handle connector - medium priority
      getToolbarBloc(context).add(
        const ToolbarEvent.selected(SpaceTool.selectConnector),
      );
      // ... connector logic
    } else {
      // Handle regular node - lower priority
      mediator.selectAt(worldPoint, isDrag: true, filter: SelectionFilter.excludeConnectors);
    }
  }
}
```

### Problems with This Approach

1. **❌ Hard to Extend**
   - Adding a new hit target (e.g., rotation handle, text bounds) requires modifying existing code
   - Violates Open/Closed Principle

2. **❌ Hard to Test**
   - Must test all conditional branches together
   - Difficult to isolate specific behaviors
   - Complex setup for each test case

3. **❌ Priority is Implicit**
   - Handle checks come before connector checks, but this isn't obvious
   - Priority logic is hidden in nested conditionals
   - No clear documentation of precedence rules

4. **❌ Difficult to Reorder**
   - Changing priority requires restructuring conditionals
   - Risk of introducing bugs when reordering

5. **❌ Duplicated Logic**
   - Similar hit-testing patterns repeated across handlers
   - Coordinate transformation duplicated
   - Distance checks scattered throughout

6. **❌ Low Cohesion**
   - Single method handles multiple responsibilities
   - Mixes concerns (resize, connector, node selection)

---

## Solution: Chain of Responsibility Pattern

### Core Concept

Break down complex conditional logic into a chain of specialized handlers, where each handler:
1. Checks if it can handle the request
2. Either handles it or passes to the next handler
3. Has a single, well-defined responsibility

### Pattern Structure

```dart
/// Base interface for gesture handlers in the chain
abstract class GestureHandler {
  GestureHandler? next;

  /// Set the next handler in the chain
  void setNext(GestureHandler handler) {
    next = handler;
  }

  /// Attempt to handle the gesture event
  /// Returns true if handled, false otherwise
  bool handle(GestureEvent event, BuildContext context) {
    if (canHandle(event, context)) {
      doHandle(event, context);
      return true;
    }
    return next?.handle(event, context) ?? false;
  }

  /// Check if this handler can handle the event
  bool canHandle(GestureEvent event, BuildContext context);

  /// Actually handle the event (only called if canHandle returns true)
  void doHandle(GestureEvent event, BuildContext context);
}

/// Wrapper for gesture events with common data
class GestureEvent {
  final Offset worldPoint;
  final Offset localPosition;
  final TransformationController controller;
  final GestureType type;

  const GestureEvent({
    required this.worldPoint,
    required this.localPosition,
    required this.controller,
    required this.type,
  });

  factory GestureEvent.panStart(
    DragStartDetails details,
    TransformationController controller,
  ) {
    final worldPoint = CanvasUtils.toWorldPoint(details.localPosition, controller);
    return GestureEvent(
      worldPoint: worldPoint,
      localPosition: details.localPosition,
      controller: controller,
      type: GestureType.panStart,
    );
  }

  factory GestureEvent.tapUp(
    TapUpDetails details,
    TransformationController controller,
  ) {
    final worldPoint = CanvasUtils.toWorldPoint(details.localPosition, controller);
    return GestureEvent(
      worldPoint: worldPoint,
      localPosition: details.localPosition,
      controller: controller,
      type: GestureType.tapUp,
    );
  }
}

enum GestureType { tapUp, panStart, panUpdate, panEnd }
```

---

## Implementation Examples

### Example 1: ResizeHandleGestureHandler

Specialized handler for detecting and initiating resize operations:

```dart
/// Handles resize handle interactions
///
/// Priority: Highest (should be first in chain)
/// Responsibility: Detect if user tapped/dragged a resize handle
class ResizeHandleGestureHandler extends GestureHandler {
  const ResizeHandleGestureHandler();

  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    final state = context.read<ActiveLayerBloc>().state;

    // Can only resize if there are active nodes
    if (state.activeNodes.isEmpty) return false;

    // Check if point is near any resize handle
    final scale = event.controller.value.getMaxScaleOnAxis();
    final hitRadius = 20.0 / scale;

    for (final node in state.activeNodes.values) {
      final rect = node.rect.inflate(4.0);
      final handle = _getHitHandle(event.worldPoint, rect, hitRadius);
      if (handle != null) return true;
    }

    return false;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final activeBloc = context.read<ActiveLayerBloc>();
    final state = activeBloc.state;
    final scale = event.controller.value.getMaxScaleOnAxis();
    final hitRadius = 20.0 / scale;

    // Find which handle was hit
    for (final node in state.activeNodes.values) {
      final rect = node.rect.inflate(4.0);
      final handle = _getHitHandle(event.worldPoint, rect, hitRadius);

      if (handle != null) {
        // Start resize operation
        activeBloc.add(ActiveLayerEvent.handleChanged(handle));

        context.read<ShapeLayerBloc>().add(
          ShapeLayerEvent.removeNode(node.id),
        );

        activeBloc.add(
          ActiveLayerEvent.interactionStarted(
            node: node,
            point: event.worldPoint,
          ),
        );
        return;
      }
    }
  }

  ResizeHandle? _getHitHandle(Offset point, Rect rect, double radius) {
    if ((point - rect.topLeft).distance <= radius) return ResizeHandle.topLeft;
    if ((point - rect.topRight).distance <= radius) return ResizeHandle.topRight;
    if ((point - rect.bottomLeft).distance <= radius) return ResizeHandle.bottomLeft;
    if ((point - rect.bottomRight).distance <= radius) return ResizeHandle.bottomRight;
    if ((point - rect.topCenter).distance <= radius) return ResizeHandle.topCenter;
    if ((point - rect.bottomCenter).distance <= radius) return ResizeHandle.bottomCenter;
    if ((point - rect.centerLeft).distance <= radius) return ResizeHandle.centerLeft;
    if ((point - rect.centerRight).distance <= radius) return ResizeHandle.centerRight;
    return null;
  }
}
```

### Example 2: ConnectorGestureHandler

Handles connector selection:

```dart
/// Handles connector node interactions
///
/// Priority: High (after resize handles)
/// Responsibility: Detect if user tapped/dragged a connector
class ConnectorGestureHandler extends GestureHandler {
  const ConnectorGestureHandler();

  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final hitNode = mediator.hitTest(event.worldPoint);
    return hitNode is ConnectorNode;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();

    // Switch to connector tool
    context.read<ToolbarBloc>().add(
      const ToolbarEvent.selected(SpaceTool.selectConnector),
    );

    // Select the connector
    final isDrag = event.type == GestureType.panStart;
    mediator.selectConnectorAt(event.worldPoint, isDrag: isDrag);

    // Clear any active handles
    context.read<ActiveLayerBloc>().add(
      const ActiveLayerEvent.handleChanged(null),
    );
  }
}
```

### Example 3: NodeGestureHandler

Handles regular node selection:

```dart
/// Handles regular node interactions
///
/// Priority: Medium (after connectors)
/// Responsibility: Select regular nodes (shapes, text, etc.)
class NodeGestureHandler extends GestureHandler {
  const NodeGestureHandler();

  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final hitNode = mediator.hitTest(
      event.worldPoint,
      filter: SelectionFilter.excludeConnectors,
    );
    return hitNode != null;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    final mediator = context.read<CanvasInteractionMediator>();
    final isDrag = event.type == GestureType.panStart;

    mediator.selectAt(
      event.worldPoint,
      isDrag: isDrag,
      filter: SelectionFilter.excludeConnectors,
    );
  }
}
```

### Example 4: BackgroundGestureHandler

Fallback handler for background interactions:

```dart
/// Handles background interactions (deselection, box select start)
///
/// Priority: Lowest (last in chain)
/// Responsibility: Handle clicks on empty canvas
class BackgroundGestureHandler extends GestureHandler {
  const BackgroundGestureHandler();

  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    // Always can handle (this is the fallback)
    return true;
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    // Deselect all nodes
    final mediator = context.read<CanvasInteractionMediator>();
    mediator.deselectAll();

    // Could also initiate box selection here
    if (event.type == GestureType.panStart) {
      // Start box selection...
    }
  }
}
```

---

## Refactored SelectToolHandler

### Before: Complex Conditionals

```dart
class SelectToolHandler extends BaseToolHandler {
  @override
  void onPanStart(DragStartDetails details, BuildContext context, TransformationController controller) {
    // 50+ lines of nested conditionals
    // Hard to understand, test, and modify
  }
}
```

### After: Clean Chain

```dart
class SelectToolHandler extends BaseToolHandler {
  const SelectToolHandler();

  @override
  void onTapUp(TapUpDetails details, BuildContext context, TransformationController controller) {
    final event = GestureEvent.tapUp(details, controller);
    final chain = _buildGestureChain();
    chain.handle(event, context);
  }

  @override
  void onPanStart(DragStartDetails details, BuildContext context, TransformationController controller) {
    final event = GestureEvent.panStart(details, controller);
    final chain = _buildGestureChain();
    chain.handle(event, context);
  }

  /// Build the gesture handler chain with explicit priorities
  GestureHandler _buildGestureChain() {
    return ResizeHandleGestureHandler()           // 1. Highest: Resize handles
      ..setNext(ConnectorGestureHandler()         // 2. High: Connectors
      ..setNext(NodeGestureHandler()              // 3. Medium: Regular nodes
      ..setNext(BackgroundGestureHandler())));    // 4. Low: Background/deselect
  }

  // Strategy pattern for onPanUpdate and onPanEnd remains unchanged
  @override
  void onPanUpdate(DragUpdateDetails details, BuildContext context, TransformationController controller) {
    final state = getActiveLayerBloc(context).state;
    final strategy = _getStrategyForState(state);
    strategy.onUpdate(details, context, controller);
  }

  @override
  void onPanEnd(DragEndDetails details, BuildContext context, TransformationController controller) {
    final state = getActiveLayerBloc(context).state;
    final strategy = _getStrategyForState(state);
    strategy.onEnd(details, context, controller);
  }

  InteractionStrategy _getStrategyForState(ActiveLayerState state) {
    if (state.resizeHandle != null) return const ResizeStrategy();
    if (state.activeNodes.isNotEmpty) return const MoveStrategy();
    return const IdleStrategy();
  }
}
```

---

## Benefits Demonstrated

### 1. ✅ Single Responsibility

Each handler has one job:
- `ResizeHandleGestureHandler`: Only detects resize handles
- `ConnectorGestureHandler`: Only detects connectors
- `NodeGestureHandler`: Only detects regular nodes
- `BackgroundGestureHandler`: Only handles background

### 2. ✅ Easy to Test

```dart
void main() {
  group('ResizeHandleGestureHandler', () {
    test('can handle point near resize handle', () {
      final handler = ResizeHandleGestureHandler();
      final event = createEventNearHandle();
      final context = createMockContext();

      expect(handler.canHandle(event, context), true);
    });

    test('cannot handle point far from handle', () {
      final handler = ResizeHandleGestureHandler();
      final event = createEventFarFromHandle();
      final context = createMockContext();

      expect(handler.canHandle(event, context), false);
    });

    test('starts resize when handling', () {
      final handler = ResizeHandleGestureHandler();
      final event = createEventNearHandle();
      final context = createMockContext();

      handler.doHandle(event, context);

      verify(() => activeBloc.add(any(that: isA<ActiveLayerEvent>()))).called(2);
    });
  });
}
```

### 3. ✅ Explicit Priority

```dart
// Priority is obvious from chain construction:
ResizeHandleGestureHandler()       // 1st - Highest priority
  ..setNext(ConnectorGestureHandler()    // 2nd
  ..setNext(NodeGestureHandler()         // 3rd
  ..setNext(BackgroundGestureHandler()))); // 4th - Lowest priority
```

### 4. ✅ Easy to Reorder

```dart
// Want connectors to have higher priority than resize handles?
// Just reorder the chain:
ConnectorGestureHandler()
  ..setNext(ResizeHandleGestureHandler()
  ..setNext(NodeGestureHandler()
  ..setNext(BackgroundGestureHandler())));
```

### 5. ✅ Easy to Extend

```dart
// Adding rotation handle? Just insert it in the chain:
ResizeHandleGestureHandler()
  ..setNext(RotationHandleGestureHandler()    // NEW!
  ..setNext(ConnectorGestureHandler()
  ..setNext(NodeGestureHandler()
  ..setNext(BackgroundGestureHandler()))));
```

### 6. ✅ Reusable Handlers

```dart
// Same handlers can be used in different tools with different chains

// SelectToolHandler chain
final selectChain =
  ResizeHandleGestureHandler()
    ..setNext(nodeHandler)        // Reuse!
    ..setNext(BackgroundGestureHandler());

// EraserToolHandler chain
final eraserChain =
  nodeHandler                     // Same handler, different context!
    ..setNext(BackgroundGestureHandler());

// Both use the same NodeGestureHandler instance
// But with different behavior based on tool context
```

---

## Integration with Existing Patterns

### Works Well With Strategy Pattern

CoR and Strategy solve different problems:
- **CoR**: Determines *what* to interact with (which object was clicked)
- **Strategy**: Determines *how* to interact with it (move, resize, reshape)

```dart
class SelectToolHandler extends BaseToolHandler {
  @override
  void onPanStart(...) {
    // CoR: Figure out WHAT was clicked
    final chain = _buildGestureChain();
    chain.handle(event, context);
  }

  @override
  void onPanUpdate(...) {
    // Strategy: Figure out HOW to handle the interaction
    final strategy = _getStrategyForState(state);
    strategy.onUpdate(details, context, controller);
  }
}
```

### Complements Mediator Pattern

The `CanvasInteractionMediator` coordinates complex interactions, while CoR simplifies the routing logic:

```dart
class NodeGestureHandler extends GestureHandler {
  @override
  void doHandle(GestureEvent event, BuildContext context) {
    // CoR determines this handler should run
    // Mediator coordinates the actual selection
    final mediator = context.read<CanvasInteractionMediator>();
    mediator.selectAt(event.worldPoint, isDrag: true);
  }
}
```

---

## When to Use Chain of Responsibility

### ✅ Good Use Cases

1. **Multiple Potential Handlers**
   - Resize handles, connectors, nodes, background
   - Each with different priority

2. **Priority Matters**
   - Resize handles should be checked before nodes
   - Order affects behavior

3. **Need Flexibility**
   - Different tools need different chains
   - Easy to add/remove/reorder handlers

4. **Complex Conditionals**
   - Current if/else nesting is hard to follow
   - Multiple exit points

5. **Reusable Logic**
   - Same handlers across different tools
   - Different combinations of handlers

### ❌ When NOT to Use

1. **Simple 1-2 Conditions**
   - Overkill for simple cases
   - Just use if/else

2. **Order Doesn't Matter**
   - If all handlers are equal priority
   - No need for chain structure

3. **Tightly Coupled Handlers**
   - If handlers depend on each other
   - Defeats purpose of separation

4. **State Machine Better Fit**
   - If dealing with sequential states
   - Use State pattern instead

---

## Implementation Roadmap

### Phase 1: Preparation (Before Implementation)
1. ✅ Document pattern and rationale (this file)
2. Review existing conditional logic in handlers
3. Identify all gesture types to handle
4. Design GestureEvent and GestureHandler interfaces

### Phase 2: Core Implementation
1. Create `GestureHandler` base class
2. Create `GestureEvent` wrapper class
3. Implement 4-5 concrete handlers:
   - `ResizeHandleGestureHandler`
   - `ConnectorGestureHandler`
   - `NodeGestureHandler`
   - `BackgroundGestureHandler`
   - (Optional) `RotationHandleGestureHandler`

### Phase 3: Integration
1. Refactor `SelectToolHandler` to use chain
2. Refactor `SelectConnectorToolHandler` to use chain
3. Update other handlers as needed

### Phase 4: Testing
1. Unit tests for each handler
2. Integration tests for chains
3. Test priority ordering
4. Test handler reuse across tools

### Phase 5: Documentation
1. Update handler documentation
2. Add examples to codebase
3. Document common patterns

---

## File Organization

Proposed structure for gesture handlers:

```
lib/features/space/view/pages/tool_handler/
├── core/
│   ├── tool_handler.dart
│   ├── base_tool_handler.dart
│   └── tool_handler_factory.dart
│
├── gestures/                              # NEW: Gesture handler chain
│   ├── gesture_handler.dart              # Base interface
│   ├── gesture_event.dart                # Event wrapper
│   ├── resize_handle_gesture_handler.dart
│   ├── connector_gesture_handler.dart
│   ├── node_gesture_handler.dart
│   └── background_gesture_handler.dart
│
├── strategies/
│   ├── interaction_strategy.dart
│   ├── move_strategy.dart
│   ├── resize_strategy.dart
│   └── ...
│
└── implementations/
    ├── select_tool_handler.dart          # Uses gesture chain
    ├── select_connector_tool_handler.dart # Uses gesture chain
    └── ...
```

---

## Testing Strategy

### Unit Tests

Test each handler independently:

```dart
void main() {
  group('ResizeHandleGestureHandler', () {
    late ResizeHandleGestureHandler handler;
    late MockBuildContext context;
    late MockActiveLayerBloc activeBloc;

    setUp(() {
      handler = ResizeHandleGestureHandler();
      context = MockBuildContext();
      activeBloc = MockActiveLayerBloc();

      when(() => context.read<ActiveLayerBloc>()).thenReturn(activeBloc);
    });

    test('cannot handle when no active nodes', () {
      final state = ActiveLayerState(activeNodes: {});
      when(() => activeBloc.state).thenReturn(state);

      final event = createTestEvent(worldPoint: Offset(10, 10));
      expect(handler.canHandle(event, context), false);
    });

    test('can handle when point is near resize handle', () {
      final node = createTestNode(rect: Rect.fromLTWH(0, 0, 100, 100));
      final state = ActiveLayerState(activeNodes: {node.id: node});
      when(() => activeBloc.state).thenReturn(state);

      final event = createTestEvent(worldPoint: Offset(0, 0)); // Top-left handle
      expect(handler.canHandle(event, context), true);
    });

    test('cannot handle when point is far from handles', () {
      final node = createTestNode(rect: Rect.fromLTWH(0, 0, 100, 100));
      final state = ActiveLayerState(activeNodes: {node.id: node});
      when(() => activeBloc.state).thenReturn(state);

      final event = createTestEvent(worldPoint: Offset(50, 50)); // Center (no handle)
      expect(handler.canHandle(event, context), false);
    });

    test('starts resize when handling', () {
      final node = createTestNode(rect: Rect.fromLTWH(0, 0, 100, 100));
      final state = ActiveLayerState(activeNodes: {node.id: node});
      when(() => activeBloc.state).thenReturn(state);

      final event = createTestEvent(worldPoint: Offset(0, 0));
      handler.doHandle(event, context);

      verify(() => activeBloc.add(any(that: isA<ActiveLayerEvent>()))).called(2);
    });
  });
}
```

### Integration Tests

Test chains work correctly:

```dart
void main() {
  group('SelectToolHandler gesture chain', () {
    testWidgets('prioritizes resize handles over nodes', (tester) async {
      await tester.pumpWidget(TestApp());

      // Create node with resize handles
      final node = createTestNode(rect: Rect.fromLTWH(100, 100, 100, 100));
      await selectNode(tester, node);

      // Tap on top-left corner (resize handle)
      await tester.tapAt(Offset(100, 100));
      await tester.pump();

      // Should start resize, not move
      expect(find.byType(ResizeHandles), findsOneWidget);
      expect(isResizing(), true);
    });

    testWidgets('selects connector over regular node', (tester) async {
      await tester.pumpWidget(TestApp());

      // Create overlapping connector and node
      final node = createTestNode(rect: Rect.fromLTWH(100, 100, 100, 100));
      final connector = createTestConnector(
        start: Offset(100, 100),
        end: Offset(200, 200),
      );

      // Tap on overlap point
      await tester.tapAt(Offset(150, 150));
      await tester.pump();

      // Should select connector (higher priority)
      expect(selectedConnector, connector);
      expect(selectedNode, isNull);
    });

    testWidgets('falls back to background handler', (tester) async {
      await tester.pumpWidget(TestApp());

      // Tap on empty area
      await tester.tapAt(Offset(500, 500));
      await tester.pump();

      // Should deselect all
      expect(hasSelection(), false);
    });
  });
}
```

---

## Performance Considerations

### ✅ Efficient

- Each handler only does necessary checks
- Chain stops at first handler that can handle
- No unnecessary object creation (handlers are const)

### Potential Optimizations

1. **Handler Caching**
   ```dart
   class SelectToolHandler extends BaseToolHandler {
     // Cache the chain to avoid rebuilding
     late final GestureHandler _gestureChain = _buildGestureChain();
   }
   ```

2. **Short-Circuit Optimization**
   ```dart
   @override
   bool handle(GestureEvent event, BuildContext context) {
     if (canHandle(event, context)) {
       doHandle(event, context);
       return true; // Stop chain immediately
     }
     return next?.handle(event, context) ?? false;
   }
   ```

3. **Lazy Evaluation**
   ```dart
   class ConditionalHandler extends GestureHandler {
     final bool Function() isEnabled;

     @override
     bool canHandle(GestureEvent event, BuildContext context) {
       if (!isEnabled()) return false; // Skip expensive checks
       return _doExpensiveCheck(event, context);
     }
   }
   ```

---

## Comparison with Current Approach

| Aspect | Current (Nested If/Else) | Chain of Responsibility |
|--------|-------------------------|------------------------|
| **Extensibility** | ❌ Modify existing code | ✅ Add new handler to chain |
| **Testability** | ❌ Test all branches together | ✅ Test each handler independently |
| **Priority** | ❌ Implicit in nesting | ✅ Explicit in chain order |
| **Reordering** | ❌ Restructure code | ✅ Reorder chain construction |
| **Reusability** | ❌ Copy-paste logic | ✅ Reuse handlers across tools |
| **Readability** | ❌ Complex nesting | ✅ Clear separation of concerns |
| **Maintainability** | ❌ Hard to modify | ✅ Easy to modify |
| **Lines of Code** | ~50-70 per handler | ~15-20 per handler |

---

## Real-World Example: Adding Rotation Handle

### Current Approach (Hard)

```dart
// Must modify existing SelectToolHandler.onPanStart
void onPanStart(...) {
  // ... existing 50 lines of code ...

  // Insert rotation check somewhere in the middle?
  // Where exactly? Before or after resize handles?
  // Risk breaking existing logic

  if (hitHandle != null) {
    // Is this resize or rotation?
    // Need to add another parameter/check
  } else if (hitRotationHandle != null) {
    // New logic here...
  } else {
    // ... rest of existing code
  }
}
```

### Chain Approach (Easy)

```dart
// 1. Create new handler (doesn't modify existing code)
class RotationHandleGestureHandler extends GestureHandler {
  @override
  bool canHandle(GestureEvent event, BuildContext context) {
    // Check for rotation handle
  }

  @override
  void doHandle(GestureEvent event, BuildContext context) {
    // Start rotation
  }
}

// 2. Insert into chain at desired priority
GestureHandler _buildGestureChain() {
  return ResizeHandleGestureHandler()
    ..setNext(RotationHandleGestureHandler()    // Add here!
    ..setNext(ConnectorGestureHandler()
    ..setNext(NodeGestureHandler()
    ..setNext(BackgroundGestureHandler()))));
}
```

---

## Conclusion

The Chain of Responsibility pattern is an excellent fit for our tool handler system because:

1. ✅ **Matches Our Problem**: Multiple potential targets with clear priorities
2. ✅ **Improves Code Quality**: Better separation of concerns, testability, maintainability
3. ✅ **Enables Growth**: Easy to add new interaction types
4. ✅ **Works with Existing Patterns**: Complements Strategy and Mediator patterns
5. ✅ **Low Risk**: Can be introduced gradually without breaking existing code

**Recommendation**: Implement as a **Phase 3 enhancement** after:
- Phase 1: Base handler refactoring (✅ Complete)
- Phase 2: Command pattern for undo/redo

This gives us a solid foundation before adding this additional abstraction layer.

---

**Related Documentation:**
- [Tool Handler Architecture Refactoring](../../../../../docs/plans/tool-handler-architecture-refactoring.md)
- [Strategy Pattern Usage](strategies/README.md) (if created)
- [Testing Guide](../../../../../docs/testing-guide.md) (if exists)

**Last Updated:** February 15, 2026
**Author:** Claude Sonnet 4.5
**Status:** Documentation Only - Awaiting Implementation
