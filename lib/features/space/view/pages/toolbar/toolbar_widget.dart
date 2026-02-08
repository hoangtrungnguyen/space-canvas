import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:ideascape/features/space/domain/interaction_mediator.dart';

class ToolbarWidget extends StatelessWidget {
  const ToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToolbarBloc, ToolbarState>(
      builder: (context, state) {
        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectionToolButton(state: state),
                _buildToolButton(
                  context,
                  SpaceTool.pen,
                  Icons.draw_outlined,
                  state,
                ),
                _buildToolButton(
                  context,
                  SpaceTool.shape,
                  Icons.category_outlined,
                  state,
                ),
                _buildToolButton(
                  context,
                  SpaceTool.text,
                  Icons.text_fields_outlined,
                  state,
                ),
                _buildToolButton(
                  context,
                  SpaceTool.eraser,
                  Icons.cleaning_services_outlined,
                  state,
                ),
                _buildToolButton(
                  context,
                  SpaceTool.connector,
                  Icons.arrow_right_alt,
                  state,
                ),
                const Divider(height: 16, indent: 8, endIndent: 8),
                _buildToolButton(
                  context,
                  SpaceTool.pan,
                  Icons.pan_tool_outlined,
                  state,
                ),
                const Divider(height: 16, indent: 8, endIndent: 8),
                ListenableBuilder(
                  listenable: context.read<HistoryManager>(),
                  builder: (context, _) {
                    final history = context.read<HistoryManager>();
                    return Column(
                      children: [
                        _buildActionButton(
                          context,
                          Icons.undo,
                          'UNDO',
                          history.canUndo
                              ? () {
                                // Deselect and commit any pending changes first
                                final mediator =
                                    context.read<CanvasInteractionMediator>();
                                mediator.commitAndDeactivate();
                                // Then perform undo
                                history.undo();
                              }
                              : null,
                        ),
                        _buildActionButton(
                          context,
                          Icons.redo,
                          'REDO',
                          history.canRedo ? () => history.redo() : null,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String tooltip,
    VoidCallback? onPressed,
  ) {
    return IconButton(
      icon: Icon(
        icon,
        color: onPressed != null ? Colors.grey[800] : Colors.grey[300],
      ),
      onPressed: onPressed,
      tooltip: tooltip,
    );
  }

  Widget _buildToolButton(
    BuildContext context,
    SpaceTool tool,
    IconData icon,
    ToolbarState state,
  ) {
    final isSelected =
        state.tool == tool ||
        (tool == SpaceTool.select && state.tool == SpaceTool.selectConnector);
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
      ),
      onPressed: () {
        if (isSelected) {
          context.read<ToolbarBloc>().add(const ToolbarEvent.toDefault());
        } else {
          context.read<ToolbarBloc>().add(ToolbarEvent.selected(tool));
        }
      },
      tooltip: tool.name.toUpperCase(),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
              : Colors.transparent,
        ),
      ),
    );
  }
}

class SelectionToolButton extends StatelessWidget {
  final ToolbarState state;

  const SelectionToolButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    const tool = SpaceTool.select;
    final isSelected =
        state.tool == tool || state.tool == SpaceTool.selectConnector;

    return IconButton(
      icon: Icon(
        Icons.ads_click,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
      ),
      onPressed: () {
        if (isSelected) {
          context.read<ToolbarBloc>().add(const ToolbarEvent.toDefault());
        } else {
          // Default to generic select, handler might refine it later
          context.read<ToolbarBloc>().add(const ToolbarEvent.selected(tool));
        }
      },
      tooltip: tool.name.toUpperCase(),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
              : Colors.transparent,
        ),
      ),
    );
  }
}
