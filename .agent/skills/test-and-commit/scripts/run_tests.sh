#!/bin/bash

# Test Runner Script for Flutter Projects
# Usage: ./run_tests.sh [--all|--affected|--coverage|--dry-run]

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
TEST_DIR="$PROJECT_ROOT/test"
COVERAGE_DIR="$PROJECT_ROOT/coverage"

# Parse arguments
RUN_ALL=false
RUN_AFFECTED=false
WITH_COVERAGE=false
DRY_RUN=false

for arg in "$@"; do
  case $arg in
    --all)
      RUN_ALL=true
      ;;
    --affected)
      RUN_AFFECTED=true
      ;;
    --coverage)
      WITH_COVERAGE=true
      ;;
    --dry-run)
      DRY_RUN=true
      ;;
    *)
      echo -e "${RED}Unknown argument: $arg${NC}"
      echo "Usage: $0 [--all|--affected|--coverage|--dry-run]"
      exit 1
      ;;
  esac
done

# Default to affected mode if no flags specified
if [ "$RUN_ALL" = false ] && [ "$RUN_AFFECTED" = false ]; then
  RUN_AFFECTED=true
fi

cd "$PROJECT_ROOT"

echo -e "${BLUE}=== Test Runner ===${NC}"
echo "Project: $(basename "$PROJECT_ROOT")"
echo "Mode: $([ "$RUN_ALL" = true ] && echo "ALL TESTS" || echo "AFFECTED TESTS")"
echo "Coverage: $([ "$WITH_COVERAGE" = true ] && echo "ENABLED" || echo "DISABLED")"
echo ""

# Step 1: Run flutter analyze
echo -e "${BLUE}Step 1: Running flutter analyze...${NC}"
if flutter analyze; then
  echo -e "${GREEN}✓ Analysis passed${NC}"
else
  echo -e "${RED}✗ Analysis failed. Fix errors before running tests.${NC}"
  exit 1
fi
echo ""

# Step 2: Determine which tests to run
TESTS_TO_RUN=()

if [ "$RUN_ALL" = true ]; then
  echo -e "${BLUE}Step 2: Discovering all tests...${NC}"
  while IFS= read -r -d '' test_file; do
    TESTS_TO_RUN+=("$test_file")
  done < <(find "$TEST_DIR" -name "*_test.dart" -type f -print0 2>/dev/null)
  echo "Found ${#TESTS_TO_RUN[@]} test files"
else
  echo -e "${BLUE}Step 2: Identifying affected tests...${NC}"

  # Get changed files (staged + unstaged)
  CHANGED_FILES=$(git diff --name-only HEAD 2>/dev/null || echo "")
  STAGED_FILES=$(git diff --cached --name-only 2>/dev/null || echo "")
  ALL_CHANGED="$CHANGED_FILES"$'\n'"$STAGED_FILES"

  if [ -z "$ALL_CHANGED" ]; then
    echo -e "${YELLOW}No changes detected. Running all tests.${NC}"
    RUN_ALL=true
  else
    # For each changed file, find corresponding test
    for changed_file in $ALL_CHANGED; do
      if [[ "$changed_file" == *.dart ]] && [[ "$changed_file" != *_test.dart ]]; then
        # Try to find corresponding test file
        # Example: lib/features/space/domain/models/node.dart
        #       -> test/features/space/domain/models/node_test.dart

        test_file="$TEST_DIR/${changed_file#lib/}"
        test_file="${test_file%.dart}_test.dart"

        if [ -f "$test_file" ]; then
          TESTS_TO_RUN+=("$test_file")
        else
          echo -e "${YELLOW}⚠ No test found for: $changed_file${NC}"
        fi
      elif [[ "$changed_file" == *_test.dart ]]; then
        # Test file itself changed
        if [ -f "$changed_file" ]; then
          TESTS_TO_RUN+=("$changed_file")
        fi
      fi
    done

    # Remove duplicates
    TESTS_TO_RUN=($(printf "%s\n" "${TESTS_TO_RUN[@]}" | sort -u))

    echo "Found ${#TESTS_TO_RUN[@]} affected test files"
  fi
fi
echo ""

# Step 3: Show test plan (if dry run)
if [ "$DRY_RUN" = true ]; then
  echo -e "${BLUE}=== Test Plan (Dry Run) ===${NC}"
  if [ ${#TESTS_TO_RUN[@]} -eq 0 ]; then
    echo "No tests to run"
  else
    for test in "${TESTS_TO_RUN[@]}"; do
      echo "  - $(basename "$test")"
    done
  fi
  echo ""
  echo -e "${GREEN}Dry run complete. Use without --dry-run to execute.${NC}"
  exit 0
fi

# Step 4: Run tests
if [ ${#TESTS_TO_RUN[@]} -eq 0 ]; then
  echo -e "${YELLOW}No tests to run${NC}"
  exit 0
fi

echo -e "${BLUE}Step 3: Running tests...${NC}"
TEST_FAILURES=0
FAILED_TESTS=()

# Construct flutter test command
TEST_CMD="flutter test"
if [ "$WITH_COVERAGE" = true ]; then
  TEST_CMD="$TEST_CMD --coverage"
fi

# Run tests
if [ ${#TESTS_TO_RUN[@]} -gt 10 ] || [ "$RUN_ALL" = true ]; then
  # Run all tests in one command (faster)
  echo "Running all tests together..."
  if $TEST_CMD; then
    echo -e "${GREEN}✓ All tests passed${NC}"
  else
    echo -e "${RED}✗ Some tests failed${NC}"
    TEST_FAILURES=1
  fi
else
  # Run tests individually (better error reporting)
  for test in "${TESTS_TO_RUN[@]}"; do
    echo -e "${BLUE}Testing: $(basename "$test")${NC}"
    if $TEST_CMD "$test" 2>&1 | grep -v "^00:"; then
      echo -e "${GREEN}✓ Passed${NC}"
    else
      echo -e "${RED}✗ Failed${NC}"
      FAILED_TESTS+=("$test")
      TEST_FAILURES=$((TEST_FAILURES + 1))
    fi
    echo ""
  done
fi

# Step 5: Coverage report (if enabled)
if [ "$WITH_COVERAGE" = true ] && [ "$TEST_FAILURES" -eq 0 ]; then
  echo -e "${BLUE}Step 4: Generating coverage report...${NC}"

  if [ -f "$COVERAGE_DIR/lcov.info" ]; then
    # Calculate coverage percentage
    TOTAL_LINES=$(grep -c "^DA:" "$COVERAGE_DIR/lcov.info" || echo 0)
    COVERED_LINES=$(grep "^DA:" "$COVERAGE_DIR/lcov.info" | grep -cv ",0$" || echo 0)

    if [ "$TOTAL_LINES" -gt 0 ]; then
      COVERAGE_PERCENT=$((COVERED_LINES * 100 / TOTAL_LINES))
      echo -e "Coverage: ${GREEN}${COVERAGE_PERCENT}%${NC} ($COVERED_LINES/$TOTAL_LINES lines)"

      # Generate HTML report (optional)
      if command -v genhtml &> /dev/null; then
        genhtml "$COVERAGE_DIR/lcov.info" -o "$COVERAGE_DIR/html" &> /dev/null
        echo -e "HTML report: ${BLUE}$COVERAGE_DIR/html/index.html${NC}"
      fi
    fi
  else
    echo -e "${YELLOW}Coverage data not found${NC}"
  fi
  echo ""
fi

# Step 6: Summary
echo -e "${BLUE}=== Summary ===${NC}"
if [ "$TEST_FAILURES" -eq 0 ]; then
  echo -e "${GREEN}✓ All tests passed!${NC}"
  echo "Tests run: ${#TESTS_TO_RUN[@]}"
  exit 0
else
  echo -e "${RED}✗ $TEST_FAILURES test(s) failed${NC}"
  echo ""
  echo "Failed tests:"
  for failed in "${FAILED_TESTS[@]}"; do
    echo -e "  ${RED}✗${NC} $(basename "$failed")"
  done
  exit 1
fi
