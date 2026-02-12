import 'dart:io';

/// A script to audit BLoC imports for architectural violations.
/// Usage: dart audit_imports.dart [lib_directory]
void main(List<String> args) {
  final rootPath = args.isNotEmpty ? args[0] : 'lib';
  final dir = Directory(rootPath);

  if (!dir.existsSync()) {
    print('Error: Directory $rootPath not found.');
    exit(1);
  }

  print('Auditing BLoC imports in $rootPath...');

  final violations = <String>[];
  int blocCount = 0;

  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File) {
      if (entity.path.endsWith('_bloc.dart') ||
          entity.path.endsWith('_cubit.dart')) {
        blocCount++;
        _auditFile(entity, violations);
      }
    }
  }

  print('\n--- Audit Report ---');
  print('Scanned $blocCount BLoCs/Cubits.');

  if (violations.isNotEmpty) {
    print('Found ${violations.length} violations:');
    for (final v in violations) {
      print(' - $v');
    }
    print('\nFAILURE: BLoC layer must ensure separation of concerns.');
    exit(1);
  } else {
    print('\nSUCCESS: No architectural violations found.');
  }
}

void _auditFile(File file, List<String> violations) {
  final lines = file.readAsLinesSync();

  for (final line in lines) {
    final trimmed = line.trim();
    if (trimmed.startsWith('import ')) {
      // Check for 'package:flutter/material.dart'
      if (trimmed.contains('package:flutter/material.dart')) {
        violations.add(
          '${file.path}: Imports material.dart (UI dependency in BLoC)',
        );
      }

      // Check for 'package:flutter/cupertino.dart'
      if (trimmed.contains('package:flutter/cupertino.dart')) {
        violations.add(
          '${file.path}: Imports cupertino.dart (UI dependency in BLoC)',
        );
      }

      // Check for data layer imports (naive check based on folder structure)
      // Assuming structure: features/x/data/datasources
      if (trimmed.contains('/data/datasources/')) {
        violations.add('${file.path}: Imports data source directly ($trimmed)');
      }

      // Check for http package
      if (trimmed.contains('package:http/http.dart') ||
          trimmed.contains('package:dio/dio.dart')) {
        violations.add('${file.path}: Imports HTTP client directly ($trimmed)');
      }
    }
  }
}
