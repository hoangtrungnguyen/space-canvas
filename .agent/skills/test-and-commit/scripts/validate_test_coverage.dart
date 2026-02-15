import 'dart:io';
import 'package:path/path.dart' as p;

/// Validates that source files have corresponding tests
/// Usage: dart validate_test_coverage.dart [directory]
void main(List<String> args) async {
  final libRoot = args.isNotEmpty ? args[0] : 'lib';
  final testRoot = args.length > 1 ? args[1] : 'test';

  final libDir = Directory(libRoot);
  final testDir = Directory(testRoot);

  if (!libDir.existsSync()) {
    print('Error: Library directory $libRoot not found.');
    exit(1);
  }

  if (!testDir.existsSync()) {
    print('Error: Test directory $testRoot not found.');
    exit(1);
  }

  print('Validating test coverage...');
  print('Library root: $libRoot');
  print('Test root: $testRoot');
  print('');

  final validator = TestCoverageValidator(
    libRoot: libRoot,
    testRoot: testRoot,
  );

  await validator.analyze();
  validator.printReport();

  // Exit with appropriate code
  if (validator.hasViolations) {
    exit(1);
  } else {
    exit(0);
  }
}

class TestCoverageValidator {
  final String libRoot;
  final String testRoot;

  final List<String> missingTests = [];
  final List<String> existingTests = [];
  final List<String> exemptFiles = [];
  final Map<String, String> testMapping = {};

  // File patterns that don't require tests
  final List<Pattern> exemptPatterns = [
    RegExp(r'\.g\.dart$'), // Generated files
    RegExp(r'\.freezed\.dart$'), // Freezed files
    RegExp(r'\.gr\.dart$'), // Auto route
    RegExp(r'/main\.dart$'), // Main entry points
    RegExp(r'/firebase_options\.dart$'), // Firebase config
    RegExp(r'/generated/'), // Generated directory
    RegExp(r'/l10n/'), // Localization
  ];

  // Files that MUST have tests (high priority)
  final List<Pattern> criticalPatterns = [
    RegExp(r'_bloc\.dart$'),
    RegExp(r'_cubit\.dart$'),
    RegExp(r'/usecases/.*\.dart$'),
    RegExp(r'/repositories/.*\.dart$'),
    RegExp(r'/commands/.*\.dart$'),
    RegExp(r'/managers/.*\.dart$'),
  ];

  TestCoverageValidator({
    required this.libRoot,
    required this.testRoot,
  });

  bool get hasViolations => missingTests.isNotEmpty;

  Future<void> analyze() async {
    // Scan all Dart files in lib/
    await for (final entity in Directory(libRoot).list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        _analyzeFile(entity.path);
      }
    }
  }

  void _analyzeFile(String libFilePath) {
    // Check if exempt
    if (_isExempt(libFilePath)) {
      exemptFiles.add(libFilePath);
      return;
    }

    // Calculate expected test path
    // Example: lib/features/space/domain/models/node.dart
    //       -> test/features/space/domain/models/node_test.dart
    final relativePath = p.relative(libFilePath, from: libRoot);
    final testPath = p.join(
      testRoot,
      relativePath.replaceFirst(RegExp(r'\.dart$'), '_test.dart'),
    );

    testMapping[libFilePath] = testPath;

    // Check if test exists
    if (File(testPath).existsSync()) {
      existingTests.add(libFilePath);
    } else {
      missingTests.add(libFilePath);
    }
  }

  bool _isExempt(String path) {
    return exemptPatterns.any((pattern) => path.contains(pattern));
  }

  bool _isCritical(String path) {
    return criticalPatterns.any((pattern) => path.contains(pattern));
  }

  void printReport() {
    print('=== Test Coverage Report ===');
    print('');

    // Summary
    final totalFiles = existingTests.length + missingTests.length;
    final coveragePercent =
        totalFiles > 0 ? (existingTests.length * 100 / totalFiles).round() : 0;

    print('Total source files: $totalFiles');
    print('Files with tests: ${existingTests.length}');
    print('Files missing tests: ${missingTests.length}');
    print('Exempt files: ${exemptFiles.length}');
    print('Coverage: $coveragePercent%');
    print('');

    // Missing tests (critical first)
    if (missingTests.isNotEmpty) {
      final criticalMissing =
          missingTests.where((f) => _isCritical(f)).toList();
      final nonCriticalMissing =
          missingTests.where((f) => !_isCritical(f)).toList();

      if (criticalMissing.isNotEmpty) {
        print('⚠️  CRITICAL: Missing tests for important files:');
        for (final file in criticalMissing) {
          final relativePath = p.relative(file);
          final testPath = p.relative(testMapping[file]!);
          print('  ✗ $relativePath');
          print('    → Should create: $testPath');
          _printTestReason(file);
        }
        print('');
      }

      if (nonCriticalMissing.isNotEmpty) {
        print('Missing tests (${nonCriticalMissing.length} files):');
        for (final file in nonCriticalMissing.take(10)) {
          // Show first 10
          final relativePath = p.relative(file);
          final testPath = p.relative(testMapping[file]!);
          print('  ✗ $relativePath → $testPath');
        }

        if (nonCriticalMissing.length > 10) {
          print('  ... and ${nonCriticalMissing.length - 10} more');
        }
        print('');
      }

      // Recommendations
      print('Recommendations:');
      if (criticalMissing.isNotEmpty) {
        print('  1. PRIORITY: Add tests for BLoCs, Cubits, and UseCases');
      }
      print('  2. Use templates from .agent/skills/test-and-commit/templates/');
      print(
        '  3. Run: dart .agent/skills/test-and-commit/scripts/generate_test_scaffold.dart',
      );
      print('');

      print('Status: ❌ FAIL - Tests required before commit');
    } else {
      print('Status: ✅ PASS - All source files have tests');
    }
  }

  void _printTestReason(String file) {
    if (file.contains('_bloc.dart')) {
      print('      Reason: BLoCs require testing all events and states');
    } else if (file.contains('_cubit.dart')) {
      print('      Reason: Cubits require testing all state transitions');
    } else if (file.contains('/usecases/')) {
      print('      Reason: UseCases contain business logic');
    } else if (file.contains('/repositories/')) {
      print('      Reason: Repositories handle data operations');
    } else if (file.contains('/commands/')) {
      print('      Reason: Commands must be verified for correctness');
    } else if (file.contains('/managers/')) {
      print('      Reason: Managers contain complex state logic');
    }
  }
}
