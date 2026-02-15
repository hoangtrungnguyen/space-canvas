# Agent Skills Quick Start Guide

Get started with your new agent skills in 5 minutes.

---

## 🚀 Quick Test

Try these commands right now:

```bash
# 1. Check your current test coverage
dart .agent/skills/test-and-commit/scripts/validate_test_coverage.dart

# 2. See which tests would run if you committed now
.agent/skills/test-and-commit/scripts/analyze_changes.sh

# 3. Run your existing tests
.agent/skills/test-and-commit/scripts/run_tests.sh --all
```

---

## 📋 Install Pre-Commit Hook (Recommended)

Automatically check tests before every commit:

```bash
# Copy this into .git/hooks/pre-commit
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
echo "🤖 Running agent skills..."

# Check for missing tests
.agent/skills/test-and-commit/scripts/analyze_changes.sh
if [ $? -ne 0 ]; then
  echo "❌ Missing tests. Add tests before committing."
  exit 1
fi

# Run affected tests
.agent/skills/test-and-commit/scripts/run_tests.sh --affected
if [ $? -ne 0 ]; then
  echo "❌ Tests failed. Fix tests before committing."
  exit 1
fi

echo "✅ All checks passed!"
exit 0
EOF

# Make it executable
chmod +x .git/hooks/pre-commit

echo "✅ Pre-commit hook installed!"
```

---

## 🎯 Your First Task: Add a Missing Test

Your project has **125 files without tests**. Let's add one:

### Step 1: Pick a critical file

```bash
# See the most critical missing tests
dart .agent/skills/test-and-commit/scripts/validate_test_coverage.dart | grep "CRITICAL" -A 20
```

### Step 2: Create the test file

Example: Adding a test for `canvas_bloc.dart`

```bash
# Copy the template
cp .agent/skills/test-and-commit/templates/bloc_test_template.dart \
   test/features/space/view/bloc/canvas_layer/canvas_bloc_test.dart

# Open and fill in the TODOs
code test/features/space/view/bloc/canvas_layer/canvas_bloc_test.dart
```

### Step 3: Run the test

```bash
flutter test test/features/space/view/bloc/canvas_layer/canvas_bloc_test.dart
```

---

## 🔍 Understanding the Output

### When you run `analyze_changes.sh`:

```
✓ lib/features/space/bloc/canvas_bloc.dart → canvas_bloc_test.dart
✗ lib/features/space/bloc/toolbar_bloc.dart → NO TEST FOUND
```

- ✓ = Test exists, will be run
- ✗ = No test found, blocks commit

### When you run `validate_test_coverage.dart`:

```
⚠️  CRITICAL: Missing tests for important files:
  ✗ lib/features/space/view/bloc/canvas_bloc.dart
    → Should create: test/features/space/view/bloc/canvas_bloc_test.dart
      Reason: BLoCs require testing all events and states
```

- **CRITICAL** = High-priority files (BLoCs, Commands, Managers)
- **Reason** = Why this file needs a test

---

## 📚 Available Templates

Choose the right template for your test:

| File Type | Template | Use When |
|-----------|----------|----------|
| `*_bloc.dart` or `*_cubit.dart` | `bloc_test_template.dart` | Testing state management |
| Models, Utils, Helpers | `unit_test_template.dart` | Testing pure Dart logic |
| Widgets, Pages | `widget_test_template.dart` | Testing UI components |

---

## ⚙️ Common Commands

```bash
# See what changed and needs testing
.agent/skills/test-and-commit/scripts/analyze_changes.sh

# Run only tests affected by your changes (fast)
.agent/skills/test-and-commit/scripts/run_tests.sh --affected

# Run all tests
.agent/skills/test-and-commit/scripts/run_tests.sh --all

# Run tests with coverage report
.agent/skills/test-and-commit/scripts/run_tests.sh --coverage

# Preview what would run without executing
.agent/skills/test-and-commit/scripts/run_tests.sh --dry-run

# Check coverage status
dart .agent/skills/test-and-commit/scripts/validate_test_coverage.dart

# Check BLoC architecture integrity
dart .agent/skills/ensure-bloc-integrity/scripts/audit_imports.dart
```

---

## 🎓 Tips & Tricks

### Tip 1: Use `--affected` for speed

```bash
# Instead of running all 20 tests (slow)
.agent/skills/test-and-commit/scripts/run_tests.sh --all

# Run only the 3 tests related to your changes (fast)
.agent/skills/test-and-commit/scripts/run_tests.sh --affected
```

### Tip 2: Skip slow tests during development

```dart
@Tags(['slow'])
test('expensive integration test', () {
  // ...
});
```

```bash
# Skip slow tests
flutter test --exclude-tags=slow
```

### Tip 3: Use templates as starting points

Don't write tests from scratch:

```bash
# Copy template
cp .agent/skills/test-and-commit/templates/bloc_test_template.dart \
   test/my_new_test.dart

# Search for TODO and fill them in
grep -n "TODO" test/my_new_test.dart
```

### Tip 4: Focus on critical files first

```bash
# See critical missing tests only
dart .agent/skills/test-and-commit/scripts/validate_test_coverage.dart | \
  grep -A 3 "CRITICAL"
```

---

## 🚨 Troubleshooting

### Problem: "Permission denied" when running scripts

**Solution:**
```bash
chmod +x .agent/skills/test-and-commit/scripts/*.sh
```

### Problem: "Command not found: dart"

**Solution:**
```bash
# Check Flutter/Dart installation
flutter doctor

# If not installed, visit: https://flutter.dev/docs/get-started/install
```

### Problem: Scripts detect wrong files

**Solution:**
Check that git is tracking your changes:
```bash
git status
git add <your-files>
```

### Problem: Tests fail with "package not found"

**Solution:**
```bash
flutter pub get
flutter clean
flutter pub get
```

---

## 📈 Improving Your Coverage

Current baseline: **12% coverage** (17/142 files)

### Goal 1: 50% Coverage (71 files)
**Focus on:** All BLoCs and Commands

### Goal 2: 80% Coverage (114 files)
**Add:** Domain models and managers

### Goal 3: 95% Coverage (135 files)
**Add:** Remaining utilities and helpers

### Track progress:
```bash
# Run weekly
dart .agent/skills/test-and-commit/scripts/validate_test_coverage.dart
```

---

## 🔗 Next Steps

1. ✅ Install pre-commit hook (see above)
2. ✅ Add your first test using a template
3. ✅ Run the test to verify it works
4. ✅ Commit your changes (hook will verify)
5. 📖 Read [IMPLEMENTATION_SUMMARY.md](.agent/IMPLEMENTATION_SUMMARY.md) for details

---

## 💡 Need Help?

- **Detailed docs:** [IMPLEMENTATION_SUMMARY.md](.agent/IMPLEMENTATION_SUMMARY.md)
- **Skill definitions:** `.agent/skills/*/SKILL.md`
- **Templates:** `.agent/skills/test-and-commit/templates/`

---

**Happy Testing!** 🎉
