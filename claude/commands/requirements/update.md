# Update Requirements

Use the `requirements` skill (Workflow B) to add or modify requirements in an existing document.

## Arguments

`$ARGUMENTS` — Path to the requirements file, followed by a description of the change.

**Format:** `<file-path> | <what to add or change>`

**Examples:**

- `requirements.md | add rate limiting and API key authentication`
- `docs/prd.md | FR-4 should also cover CSV export, not just JSON`
- `requirements.md | *(leave change description empty to describe it interactively)*`
