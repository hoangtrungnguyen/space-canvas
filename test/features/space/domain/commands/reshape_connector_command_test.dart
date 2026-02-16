import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ideascape/features/space/domain/commands/reshape_connector_command.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_node.dart';
import 'package:ideascape/features/space/domain/interfaces/space_editor.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceEditor extends Mock implements SpaceEditor {}

void main() {
  group('ReshapeConnectorCommand', () {
    late MockSpaceEditor editor;

    setUp(() {
      editor = MockSpaceEditor();
      when(() => editor.updateNode(any())).thenAnswer((_) async {});
    });

    test('execute updates to modified connector', () async {
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

      await command.execute(editor);

      verify(() => editor.updateNode(modified)).called(1);
    });

    test('undo updates to original connector', () async {
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

      await command.undo(editor);

      verify(() => editor.updateNode(original)).called(1);
    });
  });
}
