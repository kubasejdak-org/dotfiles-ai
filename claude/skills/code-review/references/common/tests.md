# Reviewing Test Coverage

## Presence

- Any logic change must be accompanied by tests or an explicit justification for why tests are not applicable
- Acceptable justifications: platform/hardware dependency, pure refactor with no behavior change (must be provably so),
  UI-only change
- Flag new public APIs with zero test coverage

## Quality

- Tests must exercise the behaviour claimed — a test that compiles but doesn't assert anything is not a test
- Prefer testing behaviour over implementation detail; tests should survive internal refactors
- Edge cases (empty input, boundary values, error paths) should be explicitly covered when non-obvious
