# Visitor Pattern in unidea-space

The **Visitor Pattern** is used in the `unidea-space` project to separate algorithms (like hit-testing, exporting, or serialization) from the object structure themselves (`SpaceObject` subclasses).

## Why Visitor Pattern?

In a canvas-based application, we have many types of objects (Rectangles, Paths, Text, etc.). Adding new functionality that needs to behave differently for each object (e.g., "Does this point intersect this object?") would normally require adding methods to every object class. This leads to:
1. **Bloated Classes**: The base `SpaceObject` and its subclasses become cluttered with unrelated logic.
2. **Difficult Maintenance**: Adding a new object type requires updating every single "operation" method.

By using the Visitor Pattern, we can add new operations (like `JsonSerializationVisitor`, `SvgExportVisitor`, or `HitTestVisitor`) without modifying the object classes.

## Implementation Details

### 1. The Visitor Interface
The `SpaceObjectVisitor<T>` interface defines a "visit" method for every concrete `SpaceObject` type.

```dart
abstract class SpaceObjectVisitor<T> {
  T visitPath(PathObject object);
  T visitShape(ShapeObject object);
  T visitText(TextObject object);
  T visitImage(ImageObject object);
  T visitConnector(ConnectorObject object);
  T visitGroup(GroupObject object);
  T visitListOfPoint(ListOfPointObject object);
}
```

### 2. The Accept Method
The base `SpaceObject` class defines an `accept` method, and every subclass implements it by calling the corresponding visitor method.

```dart
abstract class SpaceObject {
  // ... other properties
  T accept<T>(SpaceObjectVisitor<T> visitor);
}

// Example implementation in a subclass
class ShapeObject extends SpaceObject {
  @override
  T accept<T>(SpaceObjectVisitor<T> visitor) => visitor.visitShape(this);
}
```

### 3. Concrete Visitor: HitTestVisitor
The `HitTestVisitor` implementation handles the geometric logic for determining if an `Offset` (point) hits an object.

- **Shapes/Images**: Uses `rect.contains(point)`.
- **Paths**: Uses `path.contains(point)`.
- **Connectors/Lines**: Calculates the distance from the point to the line segment to allow for a "hit threshold" (making it easier to select thin lines).

## Usage in Bloc

When a user taps the canvas, the `ShapeLayerBloc` uses the visitor to find all objects under the tap and then selects the one with the highest `zIndex`.

```dart
on<_SelectAtPoint>((event, emit) {
  final visitor = HitTestVisitor(event.point);

  // Find all objects that contain the point
  final hitObjects = state.data.objects.values
      .where((obj) => obj.accept(visitor))
      .toList();

  // Sort by zIndex to select the top-most object
  hitObjects.sort((a, b) => b.zIndex.compareTo(a.zIndex));
  
  if (hitObjects.isNotEmpty) {
    add(ShapeLayerEvent.objectSelected(hitObjects.first.id));
  }
});
```

## Benefits for unidea-space
- **Extensibility**: Adding a new feature like "Export to SVG" is as simple as creating an `SvgExportVisitor`.
- **Type Safety**: The pattern leverages Dart's type system to ensure all object types are handled.
- **Clean Code**: Geometry logic stays in the `HitTestVisitor`, Painter logic stays in `ObjectPainter`, and data logic stays in the models.
