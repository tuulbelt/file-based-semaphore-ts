#!/usr/bin/env node --import tsx
/**
 * File-Based Semaphore (TypeScript) Benchmarks
 *
 * Measures performance of core operations using tatami-ng for statistical rigor.
 *
 * Run: npm run bench
 *
 * See: /docs/BENCHMARKING_STANDARDS.md
 */

import { bench, baseline, group, run } from 'tatami-ng';
import { Semaphore, acquireLock, releaseLock } from '../src/index.ts';
import { mkdtempSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';

// Prevent dead code elimination
let result: Semaphore | boolean | undefined;
let tempDir: string;
let counter = 0;

// Setup/teardown
function setup() {
  tempDir = mkdtempSync(join(tmpdir(), 'semats-bench-'));
}

function teardown() {
  if (tempDir) {
    rmSync(tempDir, { recursive: true, force: true });
  }
}

// ============================================================================
// Core Operations Benchmarks
// ============================================================================

group('Semaphore Creation', () => {
  setup();

  baseline('create: basic semaphore', () => {
    result = new Semaphore({
      name: `bench-${counter++}`,
      lockDir: tempDir,
    });
  });

  bench('create: with timeout', () => {
    result = new Semaphore({
      name: `bench-${counter++}`,
      lockDir: tempDir,
      timeout: 5000,
    });
  });

  bench('create: with stale threshold', () => {
    result = new Semaphore({
      name: `bench-${counter++}`,
      lockDir: tempDir,
      staleThreshold: 30000,
    });
  });

  teardown();
});

group('Lock Operations', () => {
  setup();
  const lockPath = join(tempDir, 'lock-ops-test');

  baseline('acquire + release: no contention', async () => {
    const name = `lock-${counter++}`;
    result = await acquireLock(name, { lockDir: tempDir });
    await releaseLock(name, { lockDir: tempDir });
  });

  teardown();
});

group('Lock File I/O', () => {
  setup();
  const sem = new Semaphore({
    name: 'io-bench',
    lockDir: tempDir,
  });

  baseline('check: lock exists (cold)', () => {
    result = sem.isLocked();
  });

  teardown();
});

// ============================================================================
// Run Benchmarks
// ============================================================================

await run({
  units: false,
  silent: false,
  json: false,
});
