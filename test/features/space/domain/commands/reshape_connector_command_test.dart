import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/commands/reshape_connector_command.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockShapeLayerBloc extends MockBloc<ShapeLayerEvent, ShapeLayerState>
    implements ShapeLayerBloc {}

void main() {
  group('ReshapeConnectorCommand', () {
    late MockShapeLayerBloc shapeLayerBloc;

    setUp(() {
      shapeLayerBloc = MockShapeLayerBloc();
    });

    test('execute removes original and adds modified', () async {
      final original = ConnectorNode(
        id: 1,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 2,
        color: 0,
        startNodeId: 10,
        endNodeId: 20,
      );

      final modified = original.copyWith(startPoint: const Offset(50, 50));

      final command = ReshapeConnectorCommand(
        originalNode: original,
        modifiedNode: modified,
      );

      await command.execute(shapeLayerBloc);

      verify(
        () => shapeLayerBloc.add(ShapeLayerEvent.removeNode(original.id)),
      ).called(1);
      verify(
        () => shapeLayerBloc.add(ShapeLayerEvent.addNode(modified)),
      ).called(1);
    });

    test('undo removes modified and adds original', () async {
      final original = ConnectorNode(
        id: 1,
        startPoint: const Offset(0, 0),
        endPoint: const Offset(100, 100),
        strokeWidth: 2,
        color: 0,
        startNodeId: 10,
        endNodeId: 20,
      );

      final modified = original.copyWith(startPoint: const Offset(50, 50));

      final command = ReshapeConnectorCommand(
        originalNode: original,
        modifiedNode: modified,
      );

      await command.undo(shapeLayerBloc);

      verify(
        () => shapeLayerBloc.add(ShapeLayerEvent.removeNode(modified.id)),
      ).called(1);
      verify(
        () => shapeLayerBloc.add(ShapeLayerEvent.addNode(original)),
      ).called(1);
    });
  });
}
