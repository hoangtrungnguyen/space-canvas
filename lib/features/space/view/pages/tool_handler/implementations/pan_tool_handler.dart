import 'package:flutter/material.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/base_tool_handler.dart';

class PanToolHandler extends BaseToolHandler {
  const PanToolHandler();

  @override
  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  ) {}

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
