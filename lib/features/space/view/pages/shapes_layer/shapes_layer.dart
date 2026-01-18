import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/object_painter.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/constant.dart';

class ShapesLayer extends StatelessWidget {
  const ShapesLayer({super.key, required this.transformationController});

  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShapeLayerBloc, ShapeLayerState>(
      buildWhen: (p, c) {
        return p.data.objects != c.data.objects;
      },
      builder: (context, state) {
        return CustomPaint(
          size: Size(defaultWidth, defaultHeight),
          painter: ObjectPainter(
            objects: state.data.objects.values.toList(),
            transform: transformationController.value,
          ),
        );
      },
    );
  }
}
