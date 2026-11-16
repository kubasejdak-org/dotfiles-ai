---
name: dev:azure-pipelines
description:
    Create new Azure Pipelines or adjust existing ones (`.azure/*.yml`) to the standard defined by the OneE
    pipeline-templates repository. Use for creating, migrating, standardizing, or fixing CI pipelines that should use
    shared templates.
---

# Azure Pipelines

The standard is defined by `git@ssh.dev.azure.com:v3/TrumpfCorp/OneE/pipeline-templates`. Its `AGENTS.md` and docs take
precedence over this skill and over general Azure Pipelines habits.

## Setup (always first)

Use `/tmp/pipeline-templates` as the clone location.

- Missing: `git clone git@ssh.dev.azure.com:v3/TrumpfCorp/OneE/pipeline-templates /tmp/pipeline-templates`.
- Present and clean: `git fetch` and move to `origin/main` (`git checkout main && git reset --hard origin/main` only
  when there are no local commits or changes).
- Dirty, has unpushed commits, or is on another branch: do not discard anything; tell the user and ask.

If the clone fails (SSH access), stop and report it. Do not write pipelines from memory.

## Read

In the clone read `AGENTS.md`, `README.md` and `docs/README.md`. Then read what the task needs:

- always: `docs/getting-started.md`, `docs/concepts.md`;
- the matching `docs/templates/<domain>.md` and the closest `docs/examples/*.yml`;
- `docs/infrastructure.md` for pools, variable groups, secure files and registries;
- `docs/known-issues.md` and `docs/templates/deprecated.md` when relevant;
- `docs/contributing.md` before any template change;
- the header comment of every template you intend to use (parameters and implicit variables).

## Inspect the consumer repository

Read `.azure/` (including `config.yml`) and any other pipeline YAML. Derive needs from the build system (CMake presets,
conan, pyproject/uv, package.json, Dockerfile, Yocto/kas, mkdocs).

## Select the workflow

- **adjust** existing pipelines (all or selected) to the standard: read [workflows/adjust.md](workflows/adjust.md).
- **create** a brand new pipeline: read [workflows/create.md](workflows/create.md).

Use both only when requested.

## Templates do not fit

If no template covers a needed role, do not write an inline workaround. Follow the repo's ladder exactly (reuse, extend,
redesign only when clearly justified, create new; modify existing behavior only when really necessary) as described in
[references/template-changes.md](references/template-changes.md).

## Rules

- Edit consumer repository files only; do not commit there unless asked.
- Ask focused questions about material ambiguities; decide the rest yourself.
- For review-only requests, report findings without editing. If everything already complies, say so and change nothing.
- Never print or commit secrets.

## Report

Summarize: template mapping, files changed, template branch and commits (if any), templates-repo documentation updated,
how to test, and open questions or deviations left on purpose.
