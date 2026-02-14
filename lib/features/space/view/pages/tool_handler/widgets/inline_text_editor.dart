import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideascape/features/space/domain/models/objects/node.dart';
import 'package:ideascape/features/space/view/bloc/toolbar/toolbar_bloc.dart';
import 'package:ideascape/features/space/domain/commands/add_node_command.dart';
import 'package:ideascape/features/space/domain/managers/history_manager.dart';
import 'package:super_editor/super_editor.dart' hide TextNode;

class InlineTextEditor extends StatefulWidget {
  const InlineTextEditor({
    super.key,
    required this.textObject,
    required this.transformationController,
  });

  final TextNode textObject;
  final TransformationController transformationController;

  @override
  State<InlineTextEditor> createState() => _InlineTextEditorState();
}

class _InlineTextEditorState extends State<InlineTextEditor> {
  late ImeAttributedTextEditingController _controller;
  late FocusNode _focusNode;
  late double _localFontSize;
  late Color _localColor;

  @override
  void initState() {
    super.initState();
    _localFontSize = widget.textObject.fontSize;
    _localColor = Color(widget.textObject.color);
    _controller = ImeAttributedTextEditingController(
      controller: AttributedTextEditingController(
        text: AttributedText(widget.textObject.text),
      ),
    );
    _focusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onCommit() {
    final newText = _controller.text.toPlainText();
    // Allow empty text if it was initially empty, or maybe we should allow it regardless?
    // Let's stick to non-empty for now or we might "lose" objects.
    if (newText.isNotEmpty) {
      final updatedObject = widget.textObject.copyWith(
        text: newText,
        fontSize: _localFontSize,
        color: _localColor.toARGB32(),
      );
      context.read<HistoryManager>().execute(AddNodeCommand(updatedObject));
    }
    context.read<ToolbarBloc>().add(const ToolbarEvent.endedEditing());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.transformationController,
      builder: (context, child) {
        final worldToCanvas = widget.transformationController.value;
        final canvasPos = MatrixUtils.transformPoint(
          worldToCanvas,
          widget.textObject.position,
        );
        final scale = worldToCanvas.getMaxScaleOnAxis();

        return Stack(
          children: [
            // Scrim to catch clicks outside
            GestureDetector(
              onTap: _onCommit,
              behavior: HitTestBehavior.opaque,
              child: Container(color: Colors.transparent),
            ),
            // Styling Menu Positioning
            Positioned(
              left: canvasPos.dx,
              top: canvasPos.dy - 60, // Position above the text
              child: _buildStyleBar(scale),
            ),
            Positioned(
              left: canvasPos.dx,
              top: canvasPos.dy,
              child: IntrinsicWidth(
                child: SuperTextField(
                  focusNode: _focusNode,
                  textController: _controller,
                  textStyleBuilder: (att) {
                    return TextStyle(
                      fontSize: _localFontSize * scale,
                      color: _localColor,
                      fontFamily: widget.textObject.fontFamily,
                    );
                  },
                  hintBuilder:
                      (context) => Text(
                        "Type something...",
                        style: TextStyle(
                          fontSize: _localFontSize * scale,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStyleBar(double scale) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Font Size Controls
            IconButton(
              onPressed:
                  () => setState(
                    () => _localFontSize = (_localFontSize - 2).clamp(8, 200),
                  ),
              icon: const Icon(Icons.remove, size: 18),
            ),
            Text(
              "${_localFontSize.toInt()}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed:
                  () => setState(
                    () => _localFontSize = (_localFontSize + 2).clamp(8, 200),
                  ),
              icon: const Icon(Icons.add, size: 18),
            ),
            const VerticalDivider(width: 16),
            // Color Pickers
            ...[
              Colors.black,
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.orange,
            ].map((color) {
              final isSelected = _localColor == color;
              return GestureDetector(
                onTap: () => setState(() => _localColor = color),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border:
                        isSelected
                            ? Border.all(color: Colors.blueAccent, width: 2)
                            : null,
                  ),
                ),
              );
            }),
            const VerticalDivider(width: 16),
            // Done Button
            IconButton(
              onPressed: _onCommit,
              icon: const Icon(Icons.check, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
