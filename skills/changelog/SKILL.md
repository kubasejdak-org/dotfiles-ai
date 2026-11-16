---
name: dev:changelog
description:
    Maintain a user-facing CHANGELOG.md. Normalize existing entries or reconcile a changelog section with Git changes,
    including changes in version-pinned dependencies. Use for changelog reviews, normalization, and updates.
---

# Changelog

Select the workflow by intent:

- **normalize**: improve existing entries without discovering new changes. Read
  [workflows/normalize.md](workflows/normalize.md).
- **update**: analyze Git history and reconcile the requested section (default: `Unreleased`) with actual functional
  changes. Read [workflows/update.md](workflows/update.md).

Read `CHANGELOG.md` and follow [references/format.md](references/format.md). If asked only to analyze, check, or
suggest, do not edit files. If asked to normalize or update, apply clear changes and show the resulting diff. Ask before
changes requiring clarification, while preserving unresolved entries.

Change or recommend changing the changelog only when needed to correct a substantive issue or meet these conventions.
Preserve entries that are already accurate, clear, and compliant; do not rephrase them merely to sound different. With
unchanged inputs, repeating the skill should produce no further edits or recommendations. If no changes are needed, say
so and leave the file unchanged.
