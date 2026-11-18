# Template changes

Use when existing templates do not fulfill a needed role. Do exactly what the pipeline-templates docs prescribe
(`AGENTS.md`, `docs/contributing.md`); this page only summarizes the flow.

## Ladder (stop at the first rung that works)

1. **Reuse** a `job-*` template with parameters.
2. **Extend** a template that almost fits: add parameters with defaults preserving old behavior; never rename/remove
   parameters or change defaults, artifact names or required variables. Prefer generic mechanisms (parameters, hooks).
3. **Redesign** only when clearly justified (original design is a bad decision). Explain the reasoning and get the
   user's confirmation first. Add the new template alongside, mark the old one `DEPRECATED` (header and
   `docs/templates/deprecated.md`), and list consumers to migrate.
4. **Create new** for recurring problems (also see `docs/known-issues.md`). Keep it generic: no project-specific names.

Modify existing behavior only when really necessary. Every merge to `main` is live for all consumers.

## Flow in `/tmp/pipeline-templates`

1. Branch from up-to-date `main` as `<user>/<topic>`.
2. Implement per `AGENTS.md` (naming, header comment, `matrix`, SSH keys before checkout, no `pool`).
3. Document per `AGENTS.md` rule 7: header, `docs/templates/<domain>.md`, README catalog, examples, `known-issues.md` as
   needed. Use the repo skill `.agents/skills/update-template-docs` (read its `SKILL.md` in the clone).
4. Check that YAML parses.
5. Commit as `<area>: <template>: <change>`. Ask before pushing or opening a PR.

## Consumer side

Temporarily set the `templates` resource to `ref: refs/heads/<branch>` so the change can be tested. Flag clearly that it
must be reverted to `refs/heads/main` after the template PR is merged (merge the template PR first).

## Report

Branch, commits, documentation updated, backward-compatibility reasoning, and how to test old and new usage (two
consumers for widely used templates).
