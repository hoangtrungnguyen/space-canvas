import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/view/bloc/active_layer/active_layer_bloc.dart';

class ActiveLayer extends StatelessWidget {
  const ActiveLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveLayerBloc, ActiveLayerState>(
      builder: (context, state) {
        // TODO: Implement active layer rendering (e.g. selection box, temporary shapes)
        return const SizedBox.shrink();
      },
    );
  }
}
