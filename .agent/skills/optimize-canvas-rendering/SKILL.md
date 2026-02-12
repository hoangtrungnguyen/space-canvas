---
name: optimize-canvas-rendering
---
# **Canvas Optimization Skill**

## **Objective**

Identify performance bottlenecks in CustomPainter implementations and apply rendering optimizations to ensure 60fps performance during BLoC state updates.

## **Reasoning Protocol**

1. **Discovery**: Execute `scripts/analyze_painters.dart` to list all CustomPainter subclasses.  
2. **Profiling (Static)**: For each painter, check:  
   * Does `shouldRepaint` return true unconditionally? (BAD)  
   * Does `paint` use `saveLayer`? (EXPENSIVE - Verify necessity)  
   * Are complex calculations (Path parsing) done inside `paint`? (MOVE to BLoC or ViewModel)  
3. **Context Analysis**: Check the parent widget of the CustomPaint. Is it wrapped in a RepaintBoundary?  
4. **State Tracing**: Examine the BLoC state driving this painter. Does the state implement Equatable or freezed to support efficient equality checks?

## **Constraints**

* **NEVER** perform heavy computation (HTTP calls, JSON parsing, large list iteration) inside the paint method.  
* **ALWAYS** suggest RepaintBoundary for widgets that repaint frequently (animations/gestures) but are surrounded by static content.  
* **PREFER** `drawPoints` or `drawVertices` over iterating through a list to call `drawCircle` (Batching is faster).

## **Tools**

### **scripts/analyze_painters.dart**
This script parses the Abstract Syntax Tree (AST) of the project to find specific coding patterns that correlate with poor performance.

**Usage:**
```bash
dart scripts/analyze_painters.dart [directory]
```

## **Resources**

### **resources/efficient_painter.dart**
Reference implementation of an optimized CustomPainter pattern using a ViewModel and smart repaint logic.
