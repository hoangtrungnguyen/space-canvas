import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/object_painter.dart';
import 'package:ideascape/features/space/view/bloc/bloc.dart';
import 'package:ideascape/features/space/view/pages/active_layer/connector_painter.dart';
import 'package:ideascape/features/space/domain/models/objects/connector_object.dart';
import 'package:ideascape/features/space/view/constant.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

class ShapesLayer extends StatelessWidget {
  const ShapesLayer({super.key, required this.transformationController});

  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShapeLayerBloc, ShapeLayerState>(
      buildWhen: (p, c) {
        return p.data.objects != c.data.objects ||
            p.data.hiddenObjectIds != c.data.hiddenObjectIds;
      },
      builder: (context, state) {
        // Split objects into connectors and others for layering
        final connectors = <ConnectorObject>[];
        final otherObjects = <SpaceObject>[];
        for (final object in state.data.objects.values) {
          if (state.data.hiddenObjectIds.contains(object.id)) continue;

          if (object is ConnectorObject) {
            connectors.add(object);
          } else {
            otherObjects.add(object);
          }
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            if (connectors.isNotEmpty)
              CustomPaint(
                size: Size(defaultWidth, defaultHeight),
                painter: ConnectorPainter(
                  connectors: connectors,
                  transform: transformationController.value,
                ),
              ),
            if (otherObjects.isNotEmpty)
              CustomPaint(
                size: Size(defaultWidth, defaultHeight),
                painter: ObjectPainter(
                  objects: otherObjects,
                  transform: transformationController.value,
                ),
              ),
          ],
        );
      },
    );
  }
}
