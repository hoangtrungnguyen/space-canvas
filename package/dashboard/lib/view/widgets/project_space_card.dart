import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ideascape/features/space/view/pages/space_page.dart';

class ProjectSpaceCard extends StatelessWidget {
  final String title;
  final String lastEdited;
  final Color color;
  final String id;

  const ProjectSpaceCard({
    super.key,
    required this.title,
    required this.lastEdited,
    required this.id,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => context.pushNamed(
            IdeaSpace.routeName,
            pathParameters: {"id": id},
          ),
      borderRadius: BorderRadius.circular(8.0),
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8.0),
                  ),
                ),
                // You can add a preview image here in the future
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastEdited,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
