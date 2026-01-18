import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/connector_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/eraser_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/image_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/pan_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/pen_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/shape_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/text_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

class ToolHandlerFactory {
  static ToolHandler getHandler(SpaceTool tool) {
    switch (tool) {
      case SpaceTool.pan:
        return const PanToolHandler();
      case SpaceTool.shape:
        return const ShapeToolHandler();
      case SpaceTool.text:
        return const TextToolHandler();
      case SpaceTool.eraser:
        return const EraserToolHandler();
      case SpaceTool.connector:
        return const ConnectorToolHandler();
      case SpaceTool.pen:
        return const PenToolHandler();
      case SpaceTool.image:
        return const ImageToolHandler();
    }
  }
}
