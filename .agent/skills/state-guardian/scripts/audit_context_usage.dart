import 'dart:io';

/// Audits Dart files for unsafe `context.read()` usage inside `build()` methods.
///
/// Rule: Never use `context.read()` inside a `build()` method.
/// Use `context.select()` or `BlocSelector` instead to minimize rebuilds.
///
/// Usage: dart audit_context_usage.dart [lib_directory]
void main(List<String> args) {
  final rootPath = args.isNotEmpty ? args[0] : 'lib';
  final dir = Directory(rootPath);

  if (!dir.existsSync()) {
    print('Error: Directory $rootPath not found.');
    exit(1);
  }

  print('Auditing context usage in $rootPath...');

  final violations = <String>[];
  int widgetFileCount = 0;

  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final content = entity.readAsStringSync();
      // Only check files that contain Widget classes
      if (content.contains('extends StatelessWidget') ||
          content.contains('extends StatefulWidget') ||
          content.contains('extends State<')) {
        widgetFileCount++;
        _auditContextUsage(entity, content, violations);
      }
    }
  }

  print('\n--- Context Usage Report ---');
  print('Scanned $widgetFileCount widget files.');

  if (violations.isNotEmpty) {
    print('Found ${violations.length} violation(s):');
    for (final v in violations) {
      print('  ⚠️  $v');
    }
    print(
      '\nFAILURE: Avoid context.read() inside build(). '
      'Use context.select() or BlocSelector instead.',
    );
    exit(1);
  } else {
    print('\n✅ SUCCESS: No unsafe context usage found.');
  }
}

void _auditContextUsage(File file, String content, List<String> violations) {
  final lines = content.split('\n');
  bool insideBuild = false;
  int braceDepth = 0;

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trim();

    // Detect build() method entry
    if (_isBuildMethod(trimmed)) {
      insideBuild = true;
      braceDepth = 0;
    }

    if (insideBuild) {
      braceDepth += _countChar(line, '{') - _countChar(line, '}');

      // Check for context.read() usage
      if (trimmed.contains('context.read<') ||
          trimmed.contains('context.read(')) {
        violations.add(
          '${file.path}:${i + 1} - context.read() used inside build() method',
        );
      }

      // Exit build method
      if (braceDepth <= 0 && i > 0) {
        insideBuild = false;
      }
    }
  }
}

bool _isBuildMethod(String line) {
  // Match: Widget build(BuildContext context)
  // or:    @override ... build(BuildContext
  return line.contains('Widget build(BuildContext') ||
      line.contains('Widget build(') && line.contains('BuildContext');
}

int _countChar(String s, String char) {
  int count = 0;
  for (int i = 0; i < s.length; i++) {
    if (s[i] == char) count++;
  }
  return count;
}
