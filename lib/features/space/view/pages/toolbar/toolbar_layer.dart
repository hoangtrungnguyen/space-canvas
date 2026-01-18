import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/space_tools.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/view/pages/toolbar/toolbar_widget.dart';
import 'package:ideascape/features/space/view/widgets/shape_library.dart';

class ToolbarLayer extends StatelessWidget {
  const ToolbarLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Left-side main toolbar
        const Positioned(top: 16, left: 16, child: ToolbarWidget()),

        // Shape Library Panel
        BlocBuilder<ToolbarBloc, ToolbarState>(
          builder: (context, state) {
            if (state.tool != SpaceTool.shape) return const SizedBox.shrink();
            return Positioned(
              top: 16,
              left: 90, // Next to toolbar
              child: ShapeLibrary(
                onShapeSelected: (type) {
                  context.read<ToolbarBloc>().add(
                    ToolbarEvent.shapeSelected(type),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
