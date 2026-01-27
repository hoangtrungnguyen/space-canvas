import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';

/// The app bar for the Space page.
///
/// Displays action buttons including:
/// - Undo button (connected to HistoryManager)
/// - Share button
/// - User profile avatar
class SpaceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SpaceAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 6, 5, 5),
      actions: [
        IconButton(
          icon: const Icon(Icons.undo),
          onPressed: () {
            context.read<HistoryManager>().undo();
          },
        ),
        IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: CircleAvatar(child: Icon(Icons.person)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
