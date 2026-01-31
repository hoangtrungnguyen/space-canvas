# Domain Layer Technical Documentation

## Overview
The Domain layer contains the core business logic and architectural components that are independent of specific UI implementations. This document details the systems managing state mutations and user interactions.

## History System (Undo/Redo)

The history system is built using the **Command Pattern**. It decouples the object that invokes the operation (e.g., a Toolbar button or Gesture Handler) from the one that knows how to perform it.

### Core Components

#### 1. HistoryManager
**Location**: `lib/features/space/domain/managers/history_manager.dart`

The `HistoryManager` acts as the **Invoker**. It maintains the history of operations and coordinates execution.

- **Responsibilities**:
  - Maintains `undoStack` and `redoStack`.
  - Executes new commands and clears the redo history (linear history model).
  - Handles `undo()` by popping from undo stack and calling `command.undo`.
  - Handles `redo()` by popping from redo stack and calling `command.execute`.

**Properties**:
- `canUndo`: Boolean indicating if undo is available.
- `canRedo`: Boolean indicating if redo is available.

#### 2. SpaceCommand (Interface)
**Location**: `lib/features/space/domain/commands/space_command.dart`

All reversible actions must implement this interface.

```dart
abstract class SpaceCommand {
  Future<void> execute(ShapeLayerBloc bloc);
  Future<void> undo(ShapeLayerBloc bloc);
}
```

### Usage Guide

#### Defining a New Command
To create a strictly typed command (e.g., for moving an object), implement `SpaceCommand`:

```dart
class MoveObjectCommand implements SpaceCommand {
  final int objectId;
  final Offset oldPos;
  final Offset newPos;

  MoveObjectCommand(this.objectId, this.oldPos, this.newPos);

  @override
  Future<void> execute(ShapeLayerBloc bloc) async {
    bloc.add(ShapeLayerEvent.objectMoved(id: objectId, position: newPos));
  }

  @override
  Future<void> undo(ShapeLayerBloc bloc) async {
    bloc.add(ShapeLayerEvent.objectMoved(id: objectId, position: oldPos));
  }
}
```

#### Executing a Command
Inject `HistoryManager` (provided via `RepositoryProvider`) and execute the command:

```dart
// Within a Widget or ToolHandler
final command = MoveObjectCommand(id, startPos, endPos);
context.read<HistoryManager>().execute(command);
```

#### Triggering Undo/Redo
Simply call the methods on the instance.

```dart
// Undo Button
onPressed: () => context.read<HistoryManager>().undo();

// Redo Button
onPressed: () => context.read<HistoryManager>().redo();
```

## Interaction System

The interaction system manages how users select, move, and create objects on the canvas. It uses a **Mediator Pattern** to coordinate between different architectural layers.

### Core Architecture: "Layer Hopping"

To optimize rendering performance, the workspace uses two primary layers:
1.  **ShapeLayer**: Renders many static objects in a single batch.
2.  **ActiveLayer**: Renders a small number of "active" objects (those being moved or created) allowing for high-frequency updates during gestures.

**Process Flow:**
- **Select/Grab**: When an object is selected, it is removed from the `ShapeLayer` and added to the `ActiveLayer`.
- **Interaction**: Gestures (drag, resize) only affect the `ActiveLayer`, keeping the rest of the canvas static and efficient.
- **Commit/Drop**: When the interaction ends, the object is committed back to the `ShapeLayer` via a `Command`.

### Canvas Interaction Mediator
**Location**: `lib/features/space/domain/interaction_mediator.dart`

The `CanvasInteractionMediator` acts as a central coordinator, shielding Tool Handlers from the complexity of managing multiple Blocs and the History system.

#### Key Methods:
- `selectAt(Offset worldPoint, {required bool isDrag})`: Handles hit-testing and initiates "Layer Hopping".
- `dragActiveObject(Offset worldPoint, Offset delta)`: Updates the position of objects in the `ActiveLayer`.
- `commitAndDeactivate()`: Finalizes an interaction by committing the active object to history and clearing the `ActiveLayer`.
- `startDrawing/updateDrawing`: Specialized methods for high-frequency path creation (Pen tool).

### Tool Switching & Lifecycle Management
**Location**: `lib/features/space/view/pages/space_listener.dart`

The `SpaceListener` monitors the `ToolbarBloc` for tool changes. To prevent data loss and ensure a consistent state:
1.  **Auto-Commit**: When a tool is switched while an interaction is in progress, the mediator is triggered to `commitAndDeactivate()`.
2.  **State Reset**: The `ActiveLayerBloc` is cleared to ensure the new tool starts with a clean slate.

---

## Best Practices
1.  **Immutability**: Commands should store all necessary data (state snapshots) at the time of creation. Do not reference mutable objects that might change later.
2.  **Granularity**: Commands should be atomic. If a user drags an object, generate *one* command at the end of the drag (onPanEnd), rather than thousands of commands during the drag.
3.  **Dependencies**: Commands currently depend on `ShapeLayerBloc`. This is acceptable for now, but in a clean architecture, they might ideally target a pure Domain Controller or Repository to further decouple from Bloc.

## File Structure
```
lib/features/space/domain/
├── commands/           # Concrete implementations of SpaceCommand
│   ├── add_shape_command.dart
│   ├── delete_object_command.dart
│   └── space_command.dart
├── factories/          # Helpers for creating complex objects
│   └── space_object_factory.dart
├── managers/           # Stateful logic managers
│   └── history_manager.dart
├── interaction_mediator.dart # Mediator for cross-bloc coordination
└── technical.md        # This documentation
```
