import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_state.dart';
import 'package:ideascape/features/space/view/bloc/shapes_layer/shape_layer_bloc.dart';

class ActiveLayerObserver extends StatelessWidget {
  final Widget child;

  const ActiveLayerObserver({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActiveLayerBloc, ActiveLayerState>(
      listenWhen: (previous, current) {
        // Only trigger update if the set of active object IDs changes
        final prevIds = previous.activeNodes.keys.toSet();
        final currIds = current.activeNodes.keys.toSet();
        return prevIds.length != currIds.length ||
            !prevIds.containsAll(currIds);
      },
      listener: (context, state) {
        final activeIds = state.activeNodes.keys.toSet();
        context.read<ShapeLayerBloc>().add(
          ShapeLayerEvent.hiddenNodes(activeIds),
        );
      },
      child: child,
    );
  }
}
