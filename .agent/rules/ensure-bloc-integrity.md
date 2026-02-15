---
trigger: always_on
priority: high
glob:
  - "lib/**/*_bloc.dart"
  - "lib/**/*_cubit.dart"
  - "lib/**/bloc/**/*.dart"
  - "lib/**/presentation/bloc/**/*.dart"
description: Automatically enforces BLoC pattern integrity rules. Activates when BLoC/Cubit files are created or modified.
---

# BLoC Integrity Rule

## Rule Purpose

This rule ensures that all BLoC/Cubit implementations follow Clean Architecture principles and maintain strict separation of concerns. It acts as an "always-on" guardian that prevents architectural violations.

## Trigger Conditions

This rule activates automatically in the following scenarios:

### 1. **File-Based Triggers** (Automatic)
- Any file matching `*_bloc.dart` is created or modified
- Any file matching `*_cubit.dart` is created or modified
- Any file in `/bloc/` or `/cubit/` directories is modified
- Any file in `/presentation/bloc/` is modified

### 2. **Import-Based Triggers** (Automatic)
- A non-BLoC file attempts to import `flutter_bloc`
- A BLoC file imports from prohibited layers:
  - `package:http`
  - `package:dio`
  - `data/datasources/`
  - `package:flutter/material.dart` (with exceptions)

### 3. **Refactoring Triggers** (User-Initiated)
- User requests: "refactor BLoC", "clean up state management"
- User requests: "improve architecture", "fix dependencies"

## Enforcement Rules

### **Layer Isolation** (CRITICAL)

```yaml
allowed_imports:
  - domain/usecases/*
  - domain/repositories/*
  - domain/models/*
  - core/*
  - package:bloc
  - package:flutter_bloc
  - package:freezed_annotation
  - package:equatable

prohibited_imports:
  - data/datasources/*          # BLoC cannot access data sources directly
  - package:http                # Use repositories/usecases instead
  - package:dio                 # Use repositories/usecases instead
  - package:sqflite             # Use repositories/usecases instead
  - presentation/widgets/*      # BLoC cannot import UI widgets
  - package:flutter/material.dart  # Except for Colors, EdgeInsets (minimal)

conditional_allowed:
  - package:flutter/material.dart:
      allowed_types: [Color, EdgeInsets, TextDirection, Alignment, BoxConstraints]
      rationale: "Minimal visual data types acceptable in state"
```

### **State Purity** (CRITICAL)

```dart
// ❌ VIOLATION: Mutable state
class BadState {
  List<String> items;  // Not final!
  BadState(this.items);
}

// ✅ CORRECT: Immutable state with freezed
@freezed
class GoodState with _$GoodState {
  const factory GoodState.initial() = _Initial;
  const factory GoodState.loaded(List<String> items) = _Loaded;
}
```

**Prohibited in State Classes:**
- `BuildContext` instances
- `AnimationController` instances
- `TextEditingController` instances
- `GlobalKey` instances
- Any mutable collections without `final`

### **Event Naming** (HIGH Priority)

```dart
// ❌ VIOLATION: Setter-style naming
@freezed
class CanvasEvent with _$CanvasEvent {
  const factory CanvasEvent.setX(double x) = _SetX;  // BAD
  const factory CanvasEvent.updateValue(int val) = _UpdateValue;  // BAD
}

// ✅ CORRECT: Verb-based, intention-revealing
@freezed
class CanvasEvent with _$CanvasEvent {
  const factory CanvasEvent.panStarted(Offset position) = _PanStarted;  // GOOD
  const factory CanvasEvent.zoomRequested(double scale) = _ZoomRequested;  // GOOD
}
```

### **Dependency Injection** (CRITICAL)

```dart
// ❌ VIOLATION: Direct instantiation
class BadBloc extends Bloc<Event, State> {
  BadBloc() : super(Initial()) {
    final repo = HttpRepository();  // Direct dependency!
    on<FetchData>((event, emit) async {
      final data = await repo.fetch();
    });
  }
}

// ✅ CORRECT: Constructor injection
class GoodBloc extends Bloc<Event, State> {
  final FetchDataUseCase _fetchData;

  GoodBloc(this._fetchData) : super(const State.initial()) {
    on<FetchData>(_onFetchData);
  }

  Future<void> _onFetchData(FetchData event, Emitter<State> emit) async {
    emit(const State.loading());
    final result = await _fetchData.execute();
    // ...
  }
}
```

## Automatic Actions

When this rule is triggered, the agent will automatically:

### 1. **Static Analysis**
- Execute `.agent/skills/ensure-bloc-integrity/scripts/audit_imports.dart`
- Scan for architectural violations
- Generate violation report

### 2. **Violation Detection**
Check for:
- Illegal imports (material.dart in BLoC)
- Cross-feature dependencies (FeatureA importing FeatureB)
- Direct data source access
- Mutable state fields
- UI controllers in state

### 3. **Reporting**
Provide structured feedback:
```
⚠️ BLoC Integrity Violation in canvas_bloc.dart:15

Violation: Illegal import
  Import: package:flutter/material.dart
  Used for: Navigator, BuildContext

Fix:
  1. Remove Navigator calls from BLoC
  2. Emit NavigationState instead
  3. Handle navigation in UI layer

Reference: .agent/skills/ensure-bloc-integrity/SKILL.md#navigation-pattern
```

### 4. **Auto-Fix Suggestions**
Propose refactoring:
```dart
// Before (Violation)
on<SaveData>((event, emit) async {
  final response = await http.get(Uri.parse('...'));
  emit(Loaded(response.body));
});

// After (Suggested Fix)
// 1. Create UseCase:
class SaveDataUseCase {
  final DataRepository repository;
  SaveDataUseCase(this.repository);

  Future<String> execute() => repository.save();
}

// 2. Update BLoC:
on<SaveData>((event, emit) async {
  final data = await _saveDataUseCase.execute();
  emit(State.loaded(data));
});
```

## Integration Points

### **Pre-Commit Hook**
- Runs automatically before every commit
- Blocks commit if violations found
- Exit code 1 = violations, 0 = clean

### **IDE Integration**
- Provides real-time feedback as code is written
- Shows inline warnings/errors
- Suggests quick fixes

### **CI/CD Pipeline**
- Runs as part of automated testing
- Fails build if violations detected
- Generates compliance report

## Exceptions

### Explicitly Allowed Violations

1. **Visual Data Types in State**
   ```dart
   // Allowed: Primitive visual data
   @freezed
   class CanvasState with _$CanvasState {
     const factory CanvasState({
       required Color backgroundColor,  // ✓ Allowed
       required EdgeInsets padding,     // ✓ Allowed
     }) = _CanvasState;
   }
   ```

2. **Legacy Code** (Temporary)
   ```dart
   // Add suppression comment (requires justification)
   // ignore: bloc_imports_material
   import 'package:flutter/material.dart';
   ```

3. **Platform-Specific BLoCs**
   - If a BLoC is inherently platform-specific (rare), document why
   - Example: `PlatformChannelBloc` that wraps method channels

## Metrics Tracking

Track these metrics to measure rule effectiveness:

```yaml
metrics:
  violations_detected_per_week: 0-5  # Target range
  auto_fix_acceptance_rate: >80%     # How often suggestions are used
  false_positive_rate: <5%           # Invalid violations flagged
  average_fix_time: <10min           # Time to resolve violation
```

## Configuration

Override defaults in `.agent/rules.config.yaml`:

```yaml
rules:
  ensure-bloc-integrity:
    enabled: true
    trigger: always_on
    severity: error  # error | warning | info

    # Customize allowed imports
    allow_material_dart: false
    allowed_material_types:
      - Color
      - EdgeInsets
      - TextDirection

    # Strict mode (zero tolerance)
    strict_mode: true

    # Auto-fix
    auto_fix_enabled: false  # Suggest only, don't auto-modify
```

## Examples

### Example 1: Detecting Illegal Import
```bash
$ git commit -m "Add canvas zoom"

Running BLoC Integrity Check...
⚠️  Violation in lib/features/canvas/bloc/canvas_bloc.dart

Line 3: import 'package:http/http.dart' as http;
        BLoCs cannot import http directly.

Fix: Create a UseCase that uses a Repository.
See: .agent/skills/ensure-bloc-integrity/resources/clean_bloc_template.dart

Commit blocked. Fix violations and retry.
```

### Example 2: Mutable State Detection
```bash
$ dart .agent/skills/ensure-bloc-integrity/scripts/audit_imports.dart

Analyzing BLoC integrity...
✗ canvas_state.dart:12
  Field 'selectedShapes' is not final
  State must be immutable. Use @freezed or Equatable with final fields.

✗ editor_bloc.dart:45
  BuildContext stored in state
  Never store BuildContext in state. Pass context only in event handlers.

Found 2 violations.
```

## Related Skills

- **state-guardian**: Validates state management patterns
- **test-and-commit**: Ensures BLoC tests exist
- **manage-dependency**: Prevents circular dependencies

## Maintenance

This rule definition should be updated when:
- Flutter/BLoC best practices change
- New architectural patterns are adopted
- Team standards evolve

**Last Updated:** 2026-02-15
**Next Review:** 2026-05-01
