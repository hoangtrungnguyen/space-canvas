import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
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
        context.read<ShapeLayerBloc>().add(
          ShapeLayerEvent.textAdded(text: result, position: worldPoint),
        );
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
