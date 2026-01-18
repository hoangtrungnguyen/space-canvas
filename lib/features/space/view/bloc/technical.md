# CanvasBloc Technical Documentation

## Overview
The `CanvasBloc` is a specialized BLoC component dedicated to managing the transformation state and object collection of the infinite canvas in the Space feature. It serves as the central logic unit for handling canvas interactions such as panning, zooming, and object synchronization.

## Architecture

### CanvasBloc
- **Type**: `Bloc<CanvasEvent, CanvasState>`
- **Purpose**: Handles business logic for canvas transformations and object updates.

### ActiveLayerBloc
- **Type**: `Bloc<ActiveLayerEvent, ActiveLayerState>`
- **Purpose**: Manages the state of objects currently being manipulated (dragged, resized) to isolate high-frequency updates from the main ShapeLayer.
- **Key Logic**: Receives objects from `ShapeLayer` on interactions, updates them locally, and pushes them back upon completion.

### CanvasState
The state is implemented using the `freezed` package for immutability and value equality.

#### Properties
- `objects` (`Map<int, SpaceObject>`):
  - Stores all objects present on the canvas, mapped by their unique integer ID.
  - **Default**: `{}` (Empty Key-Value Map).
  - Used for efficient O(1) lookup of objects during rendering or interaction handling.
  
- `transformMatrix` (`Matrix4`):
  - Represents the current 2D transformation of the canvas view (translation and scale).
  - **Required**: Must be provided during initialization (typically `Matrix4.identity()` for initial state).
  - Used by the `Transform` widget or custom painters to render the canvas from the correct viewpoint.

### CanvasEvent
Events are defined as a Freezed union to represent distinct actions.

- `started`: Triggered when the Bloc is first initialized.
- `transformUpdated(Matrix4 matrix)`: Dispatched when the user pans or zooms the canvas. Updates the `transformMatrix`.
- `objectsUpdated(Map<int, SpaceObject> objects)`: Dispatched when the collection of objects changes (added, removed, or modified).

## Usage Example

```
// Initialization
final canvasBloc = CanvasBloc();

// Updating Transform (e.g., from a GestureDetector)
canvasBloc.add(CanvasEvent.transformUpdated(newMatrix));

// Consuming State
BlocBuilder<CanvasBloc, CanvasState>(
  builder: (context, state) {
    return Transform(
      transform: state.transformMatrix,
      child: Stack(
        children: state.objects.values.map((obj) => ObjectWidget(obj)).toList(),
      ),
    );
  },
);
```

## Rendering Layer System
The rendering architecture is composed of four distinct layers, stacked from bottom to top to ensure correct visibility and performance:

1. **Canvas Layer (Base)**: The foundational layer providing the workspace context.
   - **Structure**:
     - `Container`: Provides the solid background color.
     - `CustomPaint` (Grid): Draws the infinite grid lines or dots.
   - **Optimization**: The Grid `CustomPaint` is wrapped in a `RepaintBoundary`. This ensures that expensive grid drawing operations only occur when the viewport transform changes, disjoint from shape updates.

2. **Shape Layer**: Displays the persistent content of the space (all static shapes and components).
   - **Optimization**: Wrapped in a `RepaintBoundary` to prevent rasterization when interacting with active objects or tools on layers above.

3. **Active Layer**: Dedicated to currently selected items or components being manipulated (e.g., dragged, resized).
   - **Purpose**: Separating active items isolates high-frequency frame updates to this lightweight layer, avoiding full scene repaints.

4. **Tool Layer (Top)**: Handles temporary visual feedback for active tools.
   - **Examples**: Selection rubber bands, snap guides, measurement labels, laser trails.
   - **Position**: Placed at the very top to ensure UI guides are always visible over shapes.

## Dependencies
- `package:bloc`
- `package:flutter_bloc`
- `package:freezed_annotation`
- `package:vector_math` (implicitly via `Matrix4` in Flutter)

## Design Patterns & Architecture

To ensure scalability and maintainability, the following design patterns are adopted for the Space feature:

### 1. Command Pattern (Undo/Redo)
**Problem**: We need to support undoing and redoing complex actions (e.g., adding shapes, transforming objects) without coupling the UI to the specific execution logic.
**Solution**: Encapsulate every significant state change as a `SpaceCommand` object.

#### Structure
- **Command Interface**:
  ```dart
  abstract class SpaceCommand {
    /// Executes the logic against the provided Bloc
    Future<void> execute(ShapeLayerBloc bloc);
    
    /// Reverts the changes made by execute
    Future<void> undo(ShapeLayerBloc bloc);
  }
  ```
- **Invoker (`HistoryManager`)**:
  - Maintains a `undoStack` and `redoStack` of `SpaceCommand`s.
  - When a new command is executed, `redoStack` is cleared.

**Example Commands**:
- `AddObjectCommand(SpaceObject object)`
- `TransformObjectCommand(int id, Matrix4 oldMatrix, Matrix4 newMatrix)`
- `DeleteObjectCommand(int id)`

### 2. State Pattern (Tool Handling)
**Problem**: The `SpacePage` needs to handle gestures differently depending on the active tool (e.g., Panning vs. Drawing vs. Selecting), leading to complex `switch` statements.
**Solution**: Delegate gesture handling to concrete `ToolHandler` implementations.

#### Structure
- **Context**: `SpacePage` / `ToolHandlerFactory`.
- **State Interface**: `ToolHandler` (already implemented).
- **Concrete States**: `PenToolHandler`, `ShapeToolHandler`, `PanToolHandler`.

### 3. Factory Method (Object Creation)
**Problem**: Creating different instances of `SpaceObject` (Circle, Square, Star) requires complex initialization logic scattered across the UI.
**Solution**: Centralize object creation.

- **Usage**: `SpaceObjectFactory.create(SpaceShapeType type, Offset position)`
- This ensures that default properties (color, size, ID generation) are handled consistently in one place.

