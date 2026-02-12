---
name: state-guardian
description: Enforces clean state architecture (BLoC). Use for UI logic, data flow, or state-related refactoring.
---

# State Management Guardian Logic

## 🎯 Architectural Principles
1. **Unidirectional Data Flow**: Data moves from Logic -> State -> UI. Events move UI -> Logic.
2. **Immutability First**: Every State class MUST be marked `@immutable` or use `freezed`.
3. **No Business Logic in UI**: Widgets should be "dumb." If a `build()` method has an `if` statement involving business logic, move it to the BLoC/Notifier.
4. **Separate UI Logic**: UI Logic should be in the Widget, not the BLoC/Notifier. 

## 🛠️ Execution Steps
1. **Identify Scope**: Is this Local State (Widget-specific) or Global State (Auth, Theme, Socket)?
   - *Local:* Use `setState` or `ValueNotifier`.
   - *Global:* Use `BLoC`.
2. **Review Context Use**: 
   - Never use `context.read()` inside a `build()` method. 
   - Always use `context.select()` or `BlocSelector` to minimize rebuilds.
3. **Draft State Contract**: Before writing code, list the `States` (Initial, Loading, Success, Error).
4. **Validation**: Run `scripts/check_immutability.py`. If a field isn't `final`, the agent must fix it.

## 🚫 Critical Constraints (Hard Guardrails)
- **NEVER** use `GetX` (marked as high maintenance risk in 2026).
- **NEVER** pass `BuildContext` into a Business Logic class (BLoC/Notifier).
- **ALWAYS** use `sealed classes` for States to ensure exhaustive switch cases in the UI.