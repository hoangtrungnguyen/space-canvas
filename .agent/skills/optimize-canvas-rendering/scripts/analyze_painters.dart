import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

/// A script to analyze CustomPainter performance characteristics.
/// Usage: dart analyze_painters.dart [directory]
void main(List<String> args) {
  final root = args.isNotEmpty ? args[0] : 'lib';
  final dir = Directory(root);

  if (!dir.existsSync()) {
    print('Error: Directory $root not found.');
    exit(1);
  }

  print('Analyzing CustomPainters in $root...');

  final visitor = PainterVisitor();

  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      try {
        final result = parseString(content: entity.readAsStringSync());
        visitor.currentFile = entity.path;
        result.unit.visitChildren(visitor);
      } catch (e) {
        // Skip parse errors
      }
    }
  }

  visitor.printReport();
}

class PainterVisitor extends RecursiveAstVisitor<void> {
  String currentFile = '';
  final List<String> riskyPainters = [];
  final List<String> optimizedPainters = [];

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.extendsClause?.superclass.name2.lexeme == 'CustomPainter') {
      _analyzePainter(node);
    }
    super.visitClassDeclaration(node);
  }

  void _analyzePainter(ClassDeclaration node) {
    bool hasShouldRepaint = false;
    bool usesSaveLayer = false;

    for (final member in node.members) {
      if (member is MethodDeclaration) {
        if (member.name.lexeme == 'shouldRepaint') {
          hasShouldRepaint = true;
          // Check for "=> true" or "return true"
          final body = member.body.toSource();
          if (body.contains('return true') || body.contains('=> true')) {
            // This is risky unless explicitly intended
            hasShouldRepaint = false; // Treat as if not optimized
          }
        }
        if (member.name.lexeme == 'paint') {
          if (member.body.toSource().contains('saveLayer')) {
            usesSaveLayer = true;
          }
        }
      }
    }

    final name = node.name.lexeme;
    if (!hasShouldRepaint || usesSaveLayer) {
      riskyPainters.add(
        '$name in ${p.basename(currentFile)} '
        '(shouldRepaint: $hasShouldRepaint, saveLayer: $usesSaveLayer)',
      );
    } else {
      optimizedPainters.add(name);
    }
  }

  void printReport() {
    print('\n--- Analysis Report ---');
    print('Optimized Painters: ${optimizedPainters.length}');
    print('Risky Painters: ${riskyPainters.length}');

    if (riskyPainters.isNotEmpty) {
      print('\n The following painters may cause performance issues:');
      for (final p in riskyPainters) {
        print(' - $p');
      }
      print(
        '\nRecommendation: Implement granular `shouldRepaint` checks and avoid `saveLayer`.',
      );
    } else {
      print('\n All painters appear to have basic optimizations.');
    }
  }
}
