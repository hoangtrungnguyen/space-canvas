import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/domain/models/object_painter.dart';

class ActiveLayer extends StatelessWidget {
  const ActiveLayer({super.key, required this.transformationController});

  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveLayerBloc, ActiveLayerState>(
      builder: (context, state) {
        if (state.activeObjects.isEmpty) return const SizedBox.shrink();
        return AnimatedBuilder(
          animation: transformationController,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: ObjectPainter(
                objects: state.activeObjects.values.toList(),
                transform: transformationController.value,
              ),
            );
          },
        );
      },
    );
  }
}
