#!/bin/bash

# Analyze Changes Script
# Determines which files changed and recommends which tests to run
# Usage: ./analyze_changes.sh [--commit <commit-hash>]

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
cd "$PROJECT_ROOT"

COMMIT=""
COMPARE_TO="HEAD"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --commit)
      COMMIT="$2"
      shift 2
      ;;
    *)
      echo -e "${RED}Unknown argument: $1${NC}"
      echo "Usage: $0 [--commit <commit-hash>]"
      exit 1
      ;;
  esac
done

echo -e "${BLUE}=== Change Analysis ===${NC}"
echo ""

# Determine comparison range
if [ -n "$COMMIT" ]; then
  COMPARE_TO="$COMMIT"
  echo "Analyzing commit: $COMMIT"
else
  echo "Analyzing staged and unstaged changes"
fi
echo ""

# Get changed files
if [ -n "$COMMIT" ]; then
  CHANGED_FILES=$(git diff --name-only "$COMMIT^" "$COMMIT" 2>/dev/null || echo "")
else
  STAGED=$(git diff --cached --name-only 2>/dev/null || echo "")
  UNSTAGED=$(git diff --name-only 2>/dev/null || echo "")
  UNTRACKED=$(git ls-files --others --exclude-standard 2>/dev/null || echo "")
  CHANGED_FILES=$(printf "%s\n%s\n%s" "$STAGED" "$UNSTAGED" "$UNTRACKED" | sort -u | grep -v "^$")
fi

if [ -z "$CHANGED_FILES" ]; then
  echo -e "${YELLOW}No changes detected${NC}"
  exit 0
fi

# Categorize changes
declare -a LIB_FILES
declare -a TEST_FILES
declare -a CONFIG_FILES
declare -a ASSET_FILES
declare -a OTHER_FILES

for file in $CHANGED_FILES; do
  if [[ "$file" == lib/*.dart ]]; then
    LIB_FILES+=("$file")
  elif [[ "$file" == test/*.dart ]]; then
    TEST_FILES+=("$file")
  elif [[ "$file" == pubspec.yaml ]] || [[ "$file" == analysis_options.yaml ]]; then
    CONFIG_FILES+=("$file")
  elif [[ "$file" == assets/* ]] || [[ "$file" == *.png ]] || [[ "$file" == *.jpg ]]; then
    ASSET_FILES+=("$file")
  else
    OTHER_FILES+=("$file")
  fi
done

# Display summary
echo -e "${BLUE}Changed Files Summary:${NC}"
echo "  Library files: ${#LIB_FILES[@]}"
echo "  Test files: ${#TEST_FILES[@]}"
echo "  Config files: ${#CONFIG_FILES[@]}"
echo "  Asset files: ${#ASSET_FILES[@]}"
echo "  Other files: ${#OTHER_FILES[@]}"
echo ""

# Analyze library files
if [ ${#LIB_FILES[@]} -gt 0 ]; then
  echo -e "${BLUE}Library Files Changed:${NC}"

  declare -a MISSING_TESTS
  declare -a EXISTING_TESTS
  declare -a BLOCS_CHANGED
  declare -a MODELS_CHANGED
  declare -a WIDGETS_CHANGED

  for lib_file in "${LIB_FILES[@]}"; do
    # Categorize by type
    if [[ "$lib_file" == *_bloc.dart ]] || [[ "$lib_file" == *_cubit.dart ]]; then
      BLOCS_CHANGED+=("$lib_file")
    elif [[ "$lib_file" == */models/*.dart ]]; then
      MODELS_CHANGED+=("$lib_file")
    elif [[ "$lib_file" == */widgets/*.dart ]] || [[ "$lib_file" == */pages/*.dart ]]; then
      WIDGETS_CHANGED+=("$lib_file")
    fi

    # Find corresponding test
    test_file="test/${lib_file#lib/}"
    test_file="${test_file%.dart}_test.dart"

    if [ -f "$test_file" ]; then
      EXISTING_TESTS+=("$test_file")
      echo -e "  ${GREEN}✓${NC} $lib_file → $(basename "$test_file")"
    else
      MISSING_TESTS+=("$lib_file")
      echo -e "  ${RED}✗${NC} $lib_file → ${YELLOW}NO TEST FOUND${NC}"
    fi
  done
  echo ""

  # Recommendations
  if [ ${#MISSING_TESTS[@]} -gt 0 ]; then
    echo -e "${YELLOW}⚠ Missing Tests (${#MISSING_TESTS[@]} files):${NC}"
    for missing in "${MISSING_TESTS[@]}"; do
      test_path="test/${missing#lib/}"
      test_path="${test_path%.dart}_test.dart"
      echo -e "  Should create: ${BLUE}$test_path${NC}"
    done
    echo ""
  fi

  if [ ${#BLOCS_CHANGED[@]} -gt 0 ]; then
    echo -e "${BLUE}BLoC/Cubit Changes Detected (${#BLOCS_CHANGED[@]}):${NC}"
    echo "  These require comprehensive state/event testing"
    for bloc in "${BLOCS_CHANGED[@]}"; do
      echo "    - $(basename "$bloc")"
    done
    echo ""
  fi
fi

# Analyze test files
if [ ${#TEST_FILES[@]} -gt 0 ]; then
  echo -e "${BLUE}Test Files Changed (${#TEST_FILES[@]}):${NC}"
  for test_file in "${TEST_FILES[@]}"; do
    echo "  - $(basename "$test_file")"
  done
  echo ""
fi

# Analyze config files
if [ ${#CONFIG_FILES[@]} -gt 0 ]; then
  echo -e "${YELLOW}⚠ Configuration Changed:${NC}"
  for config in "${CONFIG_FILES[@]}"; do
    echo "  - $config"
  done
  echo "  ${YELLOW}Recommendation: Run ALL tests${NC}"
  echo ""
fi

# Final recommendations
echo -e "${BLUE}=== Recommendations ===${NC}"

if [ ${#CONFIG_FILES[@]} -gt 0 ]; then
  echo -e "${YELLOW}Run: ./run_tests.sh --all${NC}"
  echo "Reason: Configuration files changed, full test suite recommended"
elif [ ${#MISSING_TESTS[@]} -gt 0 ]; then
  echo -e "${RED}HALT: Missing tests detected${NC}"
  echo "Create tests before committing"
elif [ ${#EXISTING_TESTS[@]} -gt 0 ]; then
  echo -e "${GREEN}Run: ./run_tests.sh --affected${NC}"
  echo "Will run ${#EXISTING_TESTS[@]} affected test(s)"
else
  echo -e "${GREEN}No tests needed (only non-code changes)${NC}"
fi

echo ""

# Exit with appropriate code
if [ ${#MISSING_TESTS[@]} -gt 0 ]; then
  exit 1  # Tests missing
else
  exit 0  # All good
fi
