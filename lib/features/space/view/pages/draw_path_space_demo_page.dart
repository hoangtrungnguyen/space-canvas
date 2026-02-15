import 'package:flutter/material.dart';
import 'package:ideascape/features/space/domain/models/node_painter.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';

import '../../domain/models/grid_painter.dart';

class SpaceDemoPage extends StatefulWidget {
  static String routePath = "/line-demo-path";

  const SpaceDemoPage({super.key});

  @override
  State<SpaceDemoPage> createState() => _SpaceDemoPageState();
}

class _SpaceDemoPageState extends State<SpaceDemoPage> {
  Map<int, Node> nodes = {};
  late TransformationController _controller;
  final Matrix4 _transformMatrix = Matrix4.identity();
  bool _panEnabled = false;

  final List<ListOfPointNode> _drawings = [];

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
                        painter: NodePainter(
                          nodes: _drawings,
                          transform: _transformMatrix,
                        ),
                      ),
                      if (_currentPoints.isNotEmpty)
                        CustomPaint(
                          size: Size(double.infinity, double.infinity),
                          painter: NodePainter(
                            nodes: [
                              ListOfPointNode(
                                points: _currentPoints,
                                color: Colors.black.toARGB32(),
                                strokeWidth: 4.0,
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

  // The points currently being drawn.
  List<Offset> _currentPoints = [];

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
        _currentPoints = [localPosition];
      });
    }
  }

  void _handleInteractionUpdate(ScaleUpdateDetails details) {
    // If in drawing mode and a path exists, extend the path.
    // We check scale to prevent drawing while zooming.
    if (!_panEnabled && _currentPoints.isNotEmpty && details.scale == 1.0) {
      final localPosition = _toLocal(details.focalPoint);
      setState(() {
        _currentPoints = [..._currentPoints, localPosition];
      });
    }
  }

  void _handleInteractionEnd(ScaleEndDetails details) {
    // If in drawing mode, finalize the path.
    if (!_panEnabled && _currentPoints.isNotEmpty) {
      setState(() {
        _drawings.add(
          ListOfPointNode(
            points: _currentPoints,
            color: Colors.black.toARGB32(),
            strokeWidth: 4.0,
            id: DateTime.now().millisecondsSinceEpoch,
          ),
        );
        _currentPoints = [];
      });
    }
  }
}
