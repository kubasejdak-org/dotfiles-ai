# Reviewing Change Objectives

## Scope Discipline

- Flag unrelated changes bundled into a single PR/commit — each change should have one clear purpose
- Opportunistic cleanups are acceptable only if tiny and clearly separated (e.g., a separate commit)
- If a PR touches files unrelated to its stated goal, call it out

## Change Description Match

- The code must do what the PR description / commit message claims — verify the stated goal is actually implemented
- Flag missing parts: if the description says "add X and Y" but only X is present, that is a gap
- Flag over-delivery: if the code does significantly more than described, the description is misleading

## API Completeness

- New public APIs must be fully usable — no half-implemented methods that return stub values or are left as `TODO`
- If a feature is intentionally partial, it must be explicitly scoped in the description and the incomplete parts must
  not be exposed publicly
