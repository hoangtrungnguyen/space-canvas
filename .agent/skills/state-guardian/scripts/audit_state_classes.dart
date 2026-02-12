import 'dart:io';

/// Audits BLoC/Cubit classes for BuildContext being passed as a constructor
/// parameter or stored as a field. Also checks that State classes use `sealed`
/// for exhaustive switch patterns.
///
/// Rules enforced:
///   - NEVER pass BuildContext into a BLoC/Cubit/Notifier.
///   - ALWAYS use sealed classes for States.
///
/// Usage: dart audit_state_classes.dart [lib_directory]
void main(List<String> args) {
  final rootPath = args.isNotEmpty ? args[0] : 'lib';
  final dir = Directory(rootPath);

  if (!dir.existsSync()) {
    print('Error: Directory $rootPath not found.');
    exit(1);
  }

  print('Auditing state classes in $rootPath...');

  final violations = <String>[];
  int filesScanned = 0;

  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final content = entity.readAsStringSync();

      // Check BLoC/Cubit files for BuildContext usage
      if (entity.path.endsWith('_bloc.dart') ||
          entity.path.endsWith('_cubit.dart')) {
        filesScanned++;
        _checkBuildContextInBloc(entity, content, violations);
      }

      // Check state files for sealed class usage
      if (entity.path.endsWith('_state.dart')) {
        filesScanned++;
        _checkSealedState(entity, content, violations);
      }
    }
  }

  print('\n--- State Classes Report ---');
  print('Scanned $filesScanned files.');

  if (violations.isNotEmpty) {
    print('Found ${violations.length} violation(s):');
    for (final v in violations) {
      print('  ⚠️  $v');
    }
    print('\nFAILURE: Fix the above violations.');
    exit(1);
  } else {
    print('\n✅ SUCCESS: All state classes pass guardrails.');
  }
}

void _checkBuildContextInBloc(
  File file,
  String content,
  List<String> violations,
) {
  final lines = content.split('\n');
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();

    // Check for BuildContext as a constructor param or field
    if (line.contains('BuildContext') && !line.startsWith('//')) {
      // Ignore import lines
      if (!line.startsWith('import ')) {
        violations.add(
          '${file.path}:${i + 1} - BuildContext found in BLoC/Cubit: $line',
        );
      }
    }
  }
}

void _checkSealedState(File file, String content, List<String> violations) {
  final lines = content.split('\n');

  // Check if the file uses freezed (which handles sealed-like behavior)
  final usesFreezed =
      content.contains('@freezed') || content.contains('.freezed.dart');
  if (usesFreezed) return; // freezed union types are fine

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();

    // Look for top-level State class declarations
    if (line.contains('class ') && line.contains('State')) {
      // Check if it's marked sealed or abstract
      if (!line.contains('sealed ') &&
          !line.contains('abstract ') &&
          !line.startsWith('//') &&
          !line.startsWith('part ')) {
        // Extract class name
        final match = RegExp(r'class\s+(\w+)').firstMatch(line);
        if (match != null) {
          violations.add(
            '${file.path}:${i + 1} - State class "${match.group(1)}" '
            'should be `sealed` or `abstract` for exhaustive matching',
          );
        }
      }
    }
  }
}
