---
name: dev:decisions
description:
    Record, amend, supersede, or review decision records in a project's decisions document. Use when a choice with
    lasting consequences or considered alternatives should be documented, rather than for requirements or implementation
    work.
---

# Decisions

Select the workflow by intent: **add**, **change**, or **review**. For review-only requests, report findings and
proposed wording without editing.

## Shared Guidance

Locate the decisions file from the prompt or project docs; otherwise look for `decisions.md` (case-insensitive) next to
other project docs. Read it completely before editing. Preserve an existing filename; create `decisions.md` from
[references/template.md](references/template.md) only if none exists, replacing the placeholder D-001 with the first
real decision (or removing it if there is none yet).

Record a decision when it has lasting consequences, alternatives were considered, it constrains future work, or it would
surprise a new maintainer. Do not record routine implementation details, product behavior (requirements), or release
notes (changelog).

Never invent a reason, alternative, or cost. Ask a focused question when the "why" is unknown; separate stated facts
from inferences. Unlike requirements, entries may name files, settings, and commands when needed to make the decision
concrete, but include only what a future reader needs to understand and verify the choice.

Keep changes within the request and report unrelated issues separately. If nothing needs changing, say so and leave the
file untouched.

## Entry Format

```markdown
## D-NNN — Chosen option, stated briefly

**Date:** YYYY.MM.DD

**Decision:** What was decided and its scope. Concrete and checkable.

**Reason:** Why; constraints or requirements served; accepted costs. Not chosen: alternative (why).
```

- **Date** is when the decision was made or accepted, not when it was written down. Use today's date for decisions made
  in the current session; otherwise ask, and never guess. A new entry carries its own date; superseded or amended
  entries keep theirs. Do not backfill dates on older entries unless asked; report the gap instead.
- IDs use the `D-NNN` form (three digits) and are sequential, one higher than the highest existing ID. In an existing
  file, keep its prefix and zero-padding (for example `ADR-014`). Append entries; never renumber, rename, or reuse IDs.
- The title states the chosen option, not the question.
- Cross-reference other decisions (`D-014`) and, if the project has requirement IDs, requirements by ID. Match the
  file's line wrapping.

## Workflows

### Add

Derive the decision from the prompt, conversation, or current changes (check `git diff`/`git log` when working from
changes). If an existing decision already covers or conflicts with it, use **change** instead. Draft the entry, ask
about missing reasons or alternatives, then append it.

### Change

Past decisions are history. A change in meaning goes into a new entry that states what it supersedes or amends:

- Superseded: append `(superseded by D-NNN)` to the old title.
- Partly amended: keep the title and add an inline `(amended by D-NNN: …)` note at the affected sentence.

Typos, renamed paths, and clarifications that do not change meaning may be edited in place. See the examples in
[references/examples.md](references/examples.md).

### Review

Report, without editing unless asked:

- missing or weak reasons and unrecorded alternatives;
- entries that are really requirements;
- duplicate or conflicting decisions;
- supersede/amend links missing on either side;
- ID gaps, duplicates, or out-of-order entries;
- missing or malformed dates, and dates out of order with IDs;
- entries contradicted by the current code or docs (spot-check the files, settings, and commands they name), with extra
  scrutiny for old entries that may be obsolete.

## Before Finishing

Confirm IDs are unique and sequential, dates are present and not invented, supersede/amend links exist on both sides, no
rationale was invented, and entries match the format.
