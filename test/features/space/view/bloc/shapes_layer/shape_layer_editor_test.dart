import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_editor.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

class FakeShapeLayerEvent extends Fake implements ShapeLayerEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeShapeLayerEvent());
  });

  group('ShapeLayerEditor', () {
    late MockShapeLayerBloc bloc;
    late ShapeLayerEditor editor;
    late ShapeNode testShape;

    setUp(() {
      bloc = MockShapeLayerBloc();
      editor = ShapeLayerEditor(bloc);
      testShape = ShapeNode(
        id: 1,
        type: ShapeType.rectangle,
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: 0xFF000000,
      );
    });

    test('addNode adds event to bloc', () async {
      await editor.addNode(testShape);
      verify(() => bloc.add(ShapeLayerEvent.addNode(testShape))).called(1);
    });

    test('removeNode adds event to bloc', () async {
      await editor.removeNode(testShape.id);
      verify(
        () => bloc.add(ShapeLayerEvent.removeNode(testShape.id)),
      ).called(1);
    });

    test('updateNode adds updateNodes event with single item list', () async {
      await editor.updateNode(testShape);
      verify(
        () => bloc.add(ShapeLayerEvent.updateNodes([testShape])),
      ).called(1);
    });

    test('updateNodes adds updateNodes event to bloc', () async {
      final shapes = [testShape];
      await editor.updateNodes(shapes);
      verify(() => bloc.add(ShapeLayerEvent.updateNodes(shapes))).called(1);
    });
  });
}
