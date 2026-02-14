import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.grey[100],
      child: Column(
        children: [
          const SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text('Team'),
          ),
          ListTile(
            leading: const Icon(Icons.home_filled),
            title: const Text('Home'),
            tileColor: Colors.blue.withValues(alpha: 0.1),
            onTap: () {
              context.go('/home');
            },
          ),
          const Spacer(),
          const Divider(thickness: 1),
          const ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help & Feedback'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
