import 'package:flutter/material.dart';

import '../../domain/models/objects/space_object.dart';

class ShapeLibrary extends StatelessWidget {
  final ValueChanged<ShapeType> onShapeSelected;

  const ShapeLibrary({super.key, required this.onShapeSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Shapes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              children: [
                _buildShapeButton(
                  context,
                  ShapeType.rectangle,
                  Icons.crop_square,
                ),
                _buildShapeButton(
                  context,
                  ShapeType.oval,
                  Icons.circle_outlined,
                ),
                _buildShapeButton(
                  context,
                  ShapeType.triangle,
                  Icons.change_history,
                ),
                _buildShapeButton(
                  context,
                  ShapeType.diamond,
                  Icons.diamond_outlined,
                ),
                _buildShapeButton(
                  context,
                  ShapeType.parallelogram,
                  Icons.check_box_outline_blank_rounded, // Best approx or custom icon
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Cloud',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              children: [
                _buildShapeButton(
                  context,
                  ShapeType.database,
                  Icons.storage,
                ),
                _buildShapeButton(
                  context,
                  ShapeType.server,
                  Icons.dns,
                ),
                _buildShapeButton(
                  context,
                  ShapeType.cloud,
                  Icons.cloud_queue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShapeButton(
    BuildContext context,
    ShapeType type,
    IconData icon,
  ) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () => onShapeSelected(type),
      // onPressed: () {
      //   onShapeSelected(type);
      // },
      tooltip: type.name,
    );
  }
}
