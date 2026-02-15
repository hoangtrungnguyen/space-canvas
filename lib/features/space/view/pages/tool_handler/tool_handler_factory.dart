import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/connector_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/eraser_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/image_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/pan_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/pen_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/shape_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/select_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/select_connector_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/implementations/text_tool_handler.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';

/// Factory for creating [ToolHandler] instances using the Registry pattern.
///
/// This implementation uses a registry map to associate tools with their handlers,
/// making it easy to add new tools without modifying the factory code.
/// Custom handlers can be registered at runtime using [register].
class ToolHandlerFactory {
  /// Private constructor to prevent instantiation
  ToolHandlerFactory._();

  /// Registry mapping tools to their handler factory functions
  static final Map<SpaceTool, ToolHandler Function()> _registry = {
    SpaceTool.pan: () => const PanToolHandler(),
    SpaceTool.shape: () => const ShapeToolHandler(),
    SpaceTool.text: () => const TextToolHandler(),
    SpaceTool.eraser: () => EraserToolHandler(),
    SpaceTool.connector: () => const ConnectorToolHandler(),
    SpaceTool.pen: () => const PenToolHandler(),
    SpaceTool.image: () => const ImageToolHandler(),
    SpaceTool.select: () => const SelectToolHandler(),
    SpaceTool.selectConnector: () => const SelectConnectorToolHandler(),
  };

  /// Retrieves a handler instance for the given [tool].
  ///
  /// Throws [UnimplementedError] if no handler is registered for the tool.
  static ToolHandler getHandler(SpaceTool tool) {
    final factory = _registry[tool];
    if (factory == null) {
      throw UnimplementedError('No handler registered for tool: $tool');
    }
    return factory();
  }

  /// Registers a custom handler factory for a [tool].
  ///
  /// This allows extending the factory with new tools at runtime,
  /// useful for plugins or dynamic tool registration.
  ///
  /// Example:
  /// ```dart
  /// ToolHandlerFactory.register(
  ///   SpaceTool.customTool,
  ///   () => CustomToolHandler(),
  /// );
  /// ```
  static void register(SpaceTool tool, ToolHandler Function() factory) {
    _registry[tool] = factory;
  }

  /// Checks if a handler is registered for the given [tool].
  static bool isRegistered(SpaceTool tool) {
    return _registry.containsKey(tool);
  }

  /// Unregisters a handler for the given [tool].
  ///
  /// Returns true if a handler was removed, false if none was registered.
  static bool unregister(SpaceTool tool) {
    return _registry.remove(tool) != null;
  }
}
