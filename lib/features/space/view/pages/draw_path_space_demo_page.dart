import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/object_painter.dart';
import 'package:ideascape/features/space/domain/models/objects/space_object.dart';

import '../../domain/models/grid_painter.dart';

class SpaceDemoPage extends StatefulWidget {
  static String routePath = "/line-demo-path";

  const SpaceDemoPage({super.key});

  @override
  State<SpaceDemoPage> createState() => _SpaceDemoPageState();
}

class _SpaceDemoPageState extends State<SpaceDemoPage> {
  Map<int, SpaceObject> objects = {};
  late TransformationController _controller;
  final Matrix4 _transformMatrix = Matrix4.identity();
  bool _panEnabled = false;

  final List<PathObject> _paths = [];

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the desired initial scale.
    _controller = TransformationController(_transformMatrix);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text('Interactive Drawing - $_panEnabled'),
        actions: [
          IconButton(
            icon: const Icon(Icons.online_prediction),
            onPressed: () {
              setState(() {
                _panEnabled = !_panEnabled;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          InteractiveViewer(
            transformationController: _controller,
            panEnabled: _panEnabled,
            scaleEnabled: _panEnabled,
            onInteractionStart: _handleInteractionStart,
            onInteractionUpdate: _handleInteractionUpdate,
            onInteractionEnd: _handleInteractionEnd,
            boundaryMargin: EdgeInsets.all(double.infinity),
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              height: double.infinity,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomPaint(
                        size: MediaQuery.of(context).size * 15,
                        painter: GridPainter(
                          transformationController: _controller,
                        ),
                      ),

                      CustomPaint(
                        // Set a size for the canvas world.
                        size: Size(double.infinity, double.infinity),
                        // The painter gets the objects and the current transform matrix from the state.
                        painter: ObjectPainter(
                          objects: _paths,
                          transform: _transformMatrix,
                        ),
                      ),
                      if (_currentPath != null)
                        CustomPaint(
                          size: Size(double.infinity, double.infinity),
                          painter: ObjectPainter(
                            objects: [
                              PathObject(
                                path: _currentPath!,
                                paint: _currentPaint,
                                id: -1,
                              ),
                            ],
                            transform: _transformMatrix,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // The line currently being drawn.
  Path? _currentPath;

  // The paint object for the current line.
  // This can be customized to change color, stroke width, etc.
  final Paint _currentPaint =
      Paint()
        ..color = Colors.black
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

  /// Converts a global screen coordinate to the local coordinate on the canvas,
  /// taking the current InteractiveViewer transformation into account.
  Offset _toLocal(Offset global) {
    // Get the inverted matrix to transform the global coordinate to the local coordinate.
    final Matrix4 inverse = _controller.value.clone()..invert();
    return MatrixUtils.transformPoint(inverse, global);
  }

  void _handleInteractionStart(ScaleStartDetails details) {
    // If in drawing mode, start a new path.
    if (!_panEnabled) {
      final localPosition = _toLocal(details.focalPoint);
      setState(() {
        _currentPath = Path()..moveTo(localPosition.dx, localPosition.dy);
      });
    }
  }

  void _handleInteractionUpdate(ScaleUpdateDetails details) {
    // If in drawing mode and a path exists, extend the path.
    // We check scale to prevent drawing while zooming.
    if (!_panEnabled && _currentPath != null && details.scale == 1.0) {
      final localPosition = _toLocal(details.focalPoint);
      setState(() {
        _currentPath!.lineTo(localPosition.dx, localPosition.dy);
      });
    }
  }

  void _handleInteractionEnd(ScaleEndDetails details) {
    // If in drawing mode, finalize the path.
    if (!_panEnabled && _currentPath != null) {
      setState(() {
        _paths.add(
          PathObject(
            path: _currentPath!,
            paint: _currentPaint,
            id: DateTime.now().millisecondsSinceEpoch,
          ),
        );
        _currentPath = null;
      });
    }
  }
}
