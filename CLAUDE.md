# File-Based Semaphore (TypeScript) / `semats`

Part of the [Tuulbelt](https://github.com/tuulbelt/tuulbelt) collection.

## Quick Reference

- **Language:** TypeScript
- **CLI Short Name:** `semats`
- **CLI Long Name:** `file-semaphore-ts`
- **Tests:** `npm test`
- **Build:** `npm run build`

## Development Commands

```bash
npm install      # Install dependencies
npm test         # Run all tests
npm run build    # Build for distribution
npx tsc --noEmit # Type check only
npm run test:watch  # Watch mode
```

## Code Conventions

- Zero external dependencies (Tuulbelt tools allowed via git URL)
- Result pattern for error handling
- 80%+ test coverage
- ES modules with `node:` prefix for built-ins
- See main repo for full [PRINCIPLES.md](https://github.com/tuulbelt/tuulbelt/blob/main/PRINCIPLES.md)

## Dependencies

This tool does not use other Tuulbelt tools.

## Testing

```bash
npm test                    # Run all tests (160 tests)
npm run test:unit           # Unit tests only
npm run test:integration    # Integration tests
npm run test:security       # Security tests
npm run test:edge           # Edge case tests
npm run test:stress         # Stress tests
./scripts/dogfood-flaky.sh  # Validate test reliability (optional)
./scripts/dogfood-diff.sh   # Prove deterministic outputs (optional)
```

## Security

- No hardcoded secrets
- Input validation on all public APIs
- Path traversal prevention
- Stale lock detection and cleanup
- See [security tests](test/security.test.ts) for examples

## Architecture

Cross-platform file-based semaphore using atomic file operations for process synchronization.

**Key Components:**
- `FileSemaphore` class - Main API for acquiring/releasing locks
- Lock file format - Simple key=value format compatible with Rust version
- Stale lock detection - Automatic cleanup of crashed process locks
- CLI interface - `semats` and `file-semaphore-ts` commands

**File Format:**
```
pid=12345
timestamp=1640000000000
tag=optional-tag-here
```

## Related Tools

- [file-based-semaphore](https://github.com/tuulbelt/file-based-semaphore) - Rust implementation with identical file format

## Issues

Report bugs at: https://github.com/tuulbelt/tuulbelt/issues

## License

MIT - see [LICENSE](LICENSE) file
