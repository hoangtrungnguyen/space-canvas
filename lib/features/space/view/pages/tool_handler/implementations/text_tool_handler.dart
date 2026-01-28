import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/aliases.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/domain/commands/add_shape_command.dart';
import 'package:ideascape/features/space/domain/factories/space_object_factory.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

class TextToolHandler extends ToolHandler {
  const TextToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {
    final worldPoint = MatrixUtils.transformPoint(
      Matrix4.inverted(controller.value),
      details.localPosition,
    );

    showDialog<String>(
      context: context,
      builder: (c) {
        String text = "";
        return AlertDialog(
          title: const Text("Enter Text"),
          content: TextField(
            autofocus: true,
            onChanged: (v) => text = v,
            onSubmitted: (v) => Navigator.pop(c, v),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, text),
              child: const Text("OK"),
            ),
          ],
        );
      },
    ).then((result) {
      if (result != null && result.isNotEmpty && context.mounted) {
        final id = getIt<SpaceDataService>().nextUniqueId;
        final textObject = SpaceObjectFactory.createText(
          id: id,
          text: result,
          position: worldPoint,
        );

        context.read<HistoryManager>().execute(AddShapeCommand(textObject));
      }
    });
  }

  @override
  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

  @override
  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

  @override
  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}
}
