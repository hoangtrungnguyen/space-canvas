# Design Patterns for Intelligent Canvas Interaction

Modern canvas-based applications require more than just drawing pixels; they require high-performance manipulation, predictable state management, and an extensible architecture. IdeaScape utilizes several classic design patterns to achieve this.

![Design Patterns Interaction Demo](https://github.com/hoangtrungnguyen/space-canvas/blob/master/docs/media/design_patterns_demo.webp)

*Figure 1: Demonstration of Tool Switching, Object Creation, and Layer Hopping interactions.*

---

## Final Canvas State
![Final state of the canvas demonstration](https://github.com/hoangtrungnguyen/space-canvas/blob/master/docs/media/final_canvas_state.png)

---

## 1. Mediator Pattern: The Traffic Controller
**Key Implementation**: [interaction_mediator.dart](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/domain/interaction_mediator.dart)

In IdeaScape, multiple systems (BloCs, History, Tool Handlers) must work in unison. The `CanvasInteractionMediator` acts as the central hub, decoupling these components.

### "Layer Hopping" Coordination
The Mediator manages the transition of objects between layers:
- When a user clicks an object, the Mediator removes it from the static `ShapeLayerBloc` and adds it to the high-performance `ActiveLayerBloc`.
- During the drag, only the `ActiveLayer` re-renders.
- Upon release, the Mediator commits the change back to the `ShapeLayer` via the `HistoryManager`.

This pattern ensures that tool handlers don't need to know about the internal complexities of state synchronization across multiple Blocs.

---

## 2. Visitor Pattern: Extensible Hit-Testing
**Key Implementation**: [hit_test_visitor.dart](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/domain/models/objects/visitors/hit_test_visitor.dart)

As new object types (e.g., Connectors, Groups) are added, the logic for "did the user click this?" becomes complex. The **Visitor Pattern** allows us to define this logic outside of the data classes.

- **Data Classes**: Remain clean and focused solely on state.
- **Visitors**: The `HitTestVisitor` implements specific logic for each shape type (e.g., proximity checks for lines vs. containment checks for rectangles).

This makes it trivial to add a `RenderVisitor` or `ExportVisitor` in the future without modifying existing shape models.

---

## 3. Strategy Pattern: Pluggable Interaction Logic
**Key Implementation**: [ToolHandler](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/view/pages/tool_handler/tool_handler.dart) and its [implementations](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/view/pages/tool_handler/implementations/)

Interacting with the canvas changes drastically depending on the active tool. The **Strategy Pattern** allows the application to swap out gesture handling logic at runtime.

- **Select Strategy**: [select_tool_handler.dart](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/view/pages/tool_handler/implementations/select_tool_handler.dart) manages selection and movement.
- **Pen Strategy**: [pen_tool_handler.dart](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/view/pages/tool_handler/implementations/pen_tool_handler.dart) manages high-frequency path point collection.
- **Text Strategy**: [text_tool_handler.dart](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/view/pages/tool_handler/implementations/text_tool_handler.dart) manages font sizing and editor activation.

By treating each tool as a separate strategy, we keep the main UI code clean and modular.

---

## 4. Factory Pattern: Centralized Instantiation
**Key Implementation**: [NodeFactory](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/domain/factories/node_factory.dart) & [ToolHandlerFactory](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/view/pages/tool_handler/tool_handler_factory.dart)

To ensure consistency and simplify object creation, we use **Factories**.
- `NodeFactory` ensures that all new shapes, connectors, and text objects are created with correct defaults and unique IDs.
- `ToolHandlerFactory` provides the correct `ToolHandler` implementation based on the current `SpaceTool` enum, shielding the UI from the instantiation details of each strategy.

---

## 5. Memento Pattern: Conceptual State Capture
**Theory in Action**: [connector_tool_handler.dart](https://github.com/hoangtrungnguyen/space-canvas/blob/master/lib/features/space/view/pages/tool_handler/implementations/connector_tool_handler.dart)

The **Memento Pattern** is concerned with capturing and restoring internal state. In the `ConnectorToolHandler`, this theory is applied when capturing the `startNodeId` and the current drag state. 

Although implemented as ephemeral state in the handler, the concept is the same: capturing the state of a "connection in progress" so it can be finalized as a permanent `ConnectorNode` once the interaction completes.

---

## Conclusion

By orchestrating these design patterns, IdeaScape maintains a clean separation of concerns. The **Mediator** coordinates, the **Visitor** analyzes, the **Strategy** acts, and the **Factory** builds—resulting in a canvas that is as fast as it is flexible.
