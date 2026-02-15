import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/tool_handler/tool_handler.dart';
import 'package:ideascape/features/space/view/utils/canvas_utils.dart';

/// Base implementation of [ToolHandler] that provides common utilities
/// for coordinate transformation and accessing BLoCs/services.
///
/// Extend this class to create custom tool handlers and leverage the
/// provided utility methods to reduce boilerplate code.
abstract class BaseToolHandler extends ToolHandler {
  const BaseToolHandler();

  /// Converts a local screen point to world coordinates.
  ///
  /// This is a common operation needed by most tool handlers to transform
  /// touch/mouse coordinates from screen space to canvas world space.
  @protected
  Offset toWorldPoint(Offset local, TransformationController controller) {
    return CanvasUtils.toWorldPoint(local, controller);
  }

  /// Gets the canvas interaction mediator from the context.
  ///
  /// The mediator handles selection, hit-testing, and interaction logic.
  @protected
  CanvasInteractionMediator getMediator(BuildContext context) {
    return context.read<CanvasInteractionMediator>();
  }

  /// Gets the active layer BLoC from the context.
  ///
  /// The active layer manages currently selected/active nodes.
  @protected
  ActiveLayerBloc getActiveLayerBloc(BuildContext context) {
    return context.read<ActiveLayerBloc>();
  }

  /// Gets the shape layer BLoC from the context.
  ///
  /// The shape layer manages all nodes in the canvas.
  @protected
  ShapeLayerBloc getShapeLayerBloc(BuildContext context) {
    return context.read<ShapeLayerBloc>();
  }

  /// Gets the toolbar BLoC from the context.
  ///
  /// The toolbar manages tool selection and drawing state.
  @protected
  ToolbarBloc getToolbarBloc(BuildContext context) {
    return context.read<ToolbarBloc>();
  }
}
