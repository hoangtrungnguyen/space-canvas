#!/usr/bin/env python3
"""
Checks that BLoC/Cubit state classes have all fields marked as `final`.
Non-final fields in state classes violate the Immutability First principle.

Usage: python3 check_immutability.py [lib_directory]
"""

import os
import re
import sys

# Patterns
# Matches class declarations that look like state classes:
#   - Classes ending with "State"
#   - Classes annotated with @immutable or @freezed
STATE_CLASS_RE = re.compile(
    r'(?:@immutable\s+|@freezed\s+)?'
    r'(?:sealed\s+|abstract\s+)*class\s+(\w+State)\s+'
)

# Matches non-final instance field declarations (not static, not final)
# e.g. "  int count;" or "  String? name;" but NOT "  final int count;"
NON_FINAL_FIELD_RE = re.compile(
    r'^\s+(?!final\b)(?!static\b)(?!const\b)(?!\/\/)(\w[\w<>?,\s]*)\s+(\w+)\s*[;=]'
)

# Matches freezed usage (part '...freezed.dart' or @freezed annotation)
FREEZED_RE = re.compile(r"@freezed|part\s+'[^']*\.freezed\.dart'")


def check_file(file_path):
    """Check a single Dart file for mutable state fields."""
    violations = []

    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    # If file uses freezed, immutability is guaranteed by code gen
    if FREEZED_RE.search(content):
        return violations

    lines = content.split('\n')
    in_state_class = False
    brace_depth = 0
    current_class = ''

    for i, line in enumerate(lines, 1):
        stripped = line.strip()

        # Detect state class start
        match = STATE_CLASS_RE.search(line)
        if match and not in_state_class:
            in_state_class = True
            current_class = match.group(1)
            brace_depth = 0

        if in_state_class:
            brace_depth += line.count('{') - line.count('}')

            # Check for non-final fields
            field_match = NON_FINAL_FIELD_RE.match(line)
            if field_match and not stripped.startswith('//'):
                field_type = field_match.group(1).strip()
                field_name = field_match.group(2).strip()
                # Filter out methods (they have parentheses)
                if '(' not in field_type and field_name not in ('get', 'set', 'operator'):
                    violations.append(
                        f"{file_path}:{i} - {current_class}.{field_name} "
                        f"is NOT final (type: {field_type})"
                    )

            if brace_depth <= 0 and '{' in content[:sum(len(l)+1 for l in lines[:i])]:
                in_state_class = False
                current_class = ''

    return violations


def main():
    root_path = sys.argv[1] if len(sys.argv) > 1 else 'lib'

    if not os.path.isdir(root_path):
        print(f"Error: Directory {root_path} not found.")
        sys.exit(1)

    print(f"Checking state immutability in {root_path}...")

    all_violations = []
    state_file_count = 0

    for root, _, files in os.walk(root_path):
        for file in files:
            # Focus on state files
            if file.endswith('_state.dart') or file.endswith('_states.dart'):
                state_file_count += 1
                full_path = os.path.join(root, file)
                violations = check_file(full_path)
                all_violations.extend(violations)

    print(f"\n--- Immutability Report ---")
    print(f"Scanned {state_file_count} state files.")

    if all_violations:
        print(f"Found {len(all_violations)} mutable field(s):")
        for v in all_violations:
            print(f"  ⚠️  {v}")
        print(f"\nFAILURE: All state fields MUST be `final`.")
        sys.exit(1)
    else:
        print(f"\n✅ SUCCESS: All state fields are immutable.")


if __name__ == "__main__":
    main()
