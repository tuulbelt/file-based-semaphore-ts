#!/bin/bash
# Record File-Based Semaphore (TS) demo
source "$(dirname "$0")/lib/demo-framework.sh"

TOOL_NAME="file-based-semaphore-ts"
SHORT_NAME="semats"
LANGUAGE="typescript"

# GIF parameters
GIF_COLS=100
GIF_ROWS=30
GIF_SPEED=1.0
GIF_FONT_SIZE=14

demo_commands() {
  # ═══════════════════════════════════════════
  # File-Based Semaphore (TS) / semats - Tuulbelt
  # ═══════════════════════════════════════════

  # Step 1: Installation
  echo "# Step 1: Install globally"
  sleep 0.5
  echo "$ npm link"
  sleep 1

  # Step 2: View help
  echo ""
  echo "# Step 2: View available commands"
  sleep 0.5
  echo "$ semats --help"
  sleep 0.5
  semats --help
  sleep 3

  # Step 3: Acquire a lock
  echo ""
  echo "# Step 3: Acquire a lock"
  sleep 0.5
  echo "$ semats acquire /tmp/demo.lock --tag \"demo process\""
  sleep 0.5
  semats acquire /tmp/demo.lock --tag "demo process"
  echo "✓ Lock acquired"
  sleep 2

  # Step 4: Check status
  echo ""
  echo "# Step 4: Check lock status"
  sleep 0.5
  echo "$ semats status /tmp/demo.lock"
  sleep 0.5
  semats status /tmp/demo.lock
  sleep 2

  # Step 5: Try to acquire (non-blocking, should fail)
  echo ""
  echo "# Step 5: Try to acquire (non-blocking, should fail)"
  sleep 0.5
  echo "$ semats try-acquire /tmp/demo.lock --tag \"second process\""
  sleep 0.5
  semats try-acquire /tmp/demo.lock --tag "second process" || echo "✓ Lock held by first process"
  sleep 2

  # Step 6: Release lock
  echo ""
  echo "# Step 6: Release lock"
  sleep 0.5
  echo "$ semats release /tmp/demo.lock"
  sleep 0.5
  semats release /tmp/demo.lock
  echo "✓ Lock released"
  sleep 2

  # Step 7: Status with JSON output
  echo ""
  echo "# Step 7: JSON status output"
  sleep 0.5
  echo "$ semats acquire /tmp/demo.lock --tag \"json demo\""
  semats acquire /tmp/demo.lock --tag "json demo"
  sleep 0.5
  echo "$ semats status /tmp/demo.lock --json"
  semats status /tmp/demo.lock --json
  sleep 2
  semats release /tmp/demo.lock

  # Cleanup
  rm -f /tmp/demo.lock

  echo ""
  echo "# Done! Coordinate processes with: semats acquire <path>"
  sleep 1
}

run_demo

# Demo regenerated 2025-12-30
