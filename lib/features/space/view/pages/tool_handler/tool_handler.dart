import 'package:flutter/material.dart';

abstract class ToolHandler {
  const ToolHandler();

  void onTapUp(
    TapUpDetails details,
    BuildContext context,
    TransformationController controller,
  );

  void onPanStart(
    DragStartDetails details,
    BuildContext context,
    TransformationController controller,
  );

  void onPanUpdate(
    DragUpdateDetails details,
    BuildContext context,
    TransformationController controller,
  );

  void onPanEnd(
    DragEndDetails details,
    BuildContext context,
    TransformationController controller,
  );
}
