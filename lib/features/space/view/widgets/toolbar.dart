import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({super.key});

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
                const Divider(height: 16, indent: 8, endIndent: 8),
                _buildToolButton(
                  context,
                  SpaceTool.pan,
                  Icons.pan_tool_outlined,
                  state,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildToolButton(
    BuildContext context,
    SpaceTool tool,
    IconData icon,
    ToolbarState state,
  ) {
    final isSelected = state.tool == tool;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[700],
      ),
      onPressed: () {
        if (isSelected) {
          context.read<ToolbarBloc>().add(ToolbarEvent.toDefault());
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
