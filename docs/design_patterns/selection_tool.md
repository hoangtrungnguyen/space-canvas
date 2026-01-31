# Selection Tool Design Patterns

To add a selection tool to `toolbar_layer.dart`, you should lean into the existing architecture of your project while introducing patterns that handle **hit-testing**, **multi-object manipulation**, and **state feedback**.

Based on the current codebase, here are the recommended design patterns:

### 1. State / Strategy Pattern (Consistent with current Tools)
Your project already uses this via `ToolHandler` and `ToolHandlerFactory`. 
- **Why:** It keeps the logic for "selecting" separate from "drawing". 
- **Implementation:** Create a `SelectionToolHandler` that implements `ToolHandler`. It will handle `onPanStart` (to start a marquee selection or pick an object) and `onPanUpdate` (to move the selection).

### 2. Visitor Pattern (For Hit-Testing)
Selection requires checking if a user's tap or a "drag-box" (marquee) intersects with objects.
- **Why:** Objects like `PathObject`, `ShapeObject`, and `ConnectorObject` have different geometries. A Visitor allows you to add "intersection" logic without bloating the specific object classes.
- **Implementation:**
    ```dart
    abstract class SpaceObjectVisitor<T> {
      T visitShape(ShapeObject object);
      T visitPath(PathObject object);
      // ...
    }
    ```

### 3. Command Pattern (For Undo/Redo Integration)
Any action performed *via* the selection tool (moving, deleting, or resizing selected objects) must be undoable.
- **Why:** You already have a `HistoryManager`. Encapsulating selection-based actions as commands keeps history clean.
- **Examples:** `MoveObjectsCommand(List<int> ids, Offset delta)`, `DeleteObjectsCommand(List<int> ids)`.

### 4. Observer Pattern (Selection State Management)
The rest of the UI (like a property panel or the canvas itself) needs to know what is selected.
- **Implementation:** You should extend your `CanvasBloc` (or a dedicated `SelectionBloc`) to hold a `Set<int> selectedIds`. When this set changes, the `ToolbarLayer` or a new `SelectionUI` layer will automatically rebuild to show selection handles (the "marching ants" or bounding boxes).

### 5. Composite Pattern (Grouping)
You already have a `GroupObject` in your models. 
- **Why:** A selection tool often needs to treat multiple selected items as one.
- **Implementation:** When multiple objects are selected, you can temporarily treat them as a "Composite" to apply transformations (like scaling or moving) to all children simultaneously.

### 6. Decorator Pattern (Selection Highlighting)
Instead of changing the `paint` method of every object to support a "selected" look:
- **Implementation:** Use a **Selection Overlay Layer**. In your `Stack` in `toolbar_layer.dart`, add a layer that only draws bounding boxes and resize handles for the `selectedIds`. This "decorates" the objects visually without modifying their underlying data.

---

## Summary Checklist for Implementation:
1.  **Add to Enum**: Add `selection` to `SpaceTool` in `space_tools.dart`.
2.  **Create Handler**: Create `lib/features/space/view/pages/tool_handler/implementations/selection_tool_handler.dart`.
3.  **Update Factory**: Register it in `ToolHandlerFactory`.
4.  **Selection Feedback**: Add a `BlocBuilder` in `ToolbarLayer` that watches `selectedIds` and renders a `CustomPaint` overlay with transformation handles.
