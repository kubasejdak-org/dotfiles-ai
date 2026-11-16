# Changelog conventions

See [template.md](template.md) for the document structure and category guidance. Replace illustrative content with
actual changes and remove italic guidance when using the template.

- File title: `# Changelog`.
- `## Unreleased` always appears first, even when it has no entries, followed by releases newest first: `## 2.0.1` (no
  `v`, no date).
- Do not add per-release boilerplate such as "Changes since X".
- Within each section, use only nonempty headings, ordered: `### Added`, `### Changed`, `### Fixed`, `### Removed`.
- Report functional effects visible to users, operators, or clients of the repository's public API. Include substantial
  reliability, safety, diagnostic, or performance changes when their observable impact is clear. Omit internal
  refactoring, docs, CI, tooling, deployment, SHA bumps, and implementation details without observable effect.
- Each main bullet is one short, complete, natural sentence describing the resulting behavior, not the developer action.
  Group related changes into one outcome; use backticks for code identifiers, channel IDs, and event names. Use only
  supplied or verified facts; do not invent details to make an entry more specific.
- Never write version-bump entries ("X is updated to Y") for first-party dependencies. Describe the behavior the bump
  brings, resolved from the dependency's history; see [update workflow](../workflows/update.md). The only exception is a
  third-party dependency, which may be listed as "X is updated from A to B" (plus any known user-visible effect).
- State only what diffs support: names, numbers, event IDs, defaults, and "before" values taken from the previous
  release. Do not infer causes the diff does not show. Mark optional features as optional.
- Do not list a fix for something introduced in the same release.
- Use optional indented sub-bullets for details that help users understand or use the change. Keep the main entry
  understandable on its own and omit unnecessary detail.

Examples (bad → good):

- `Added PDF export.` → `Users can now export reports to PDF.`
- `Implemented configurable voltage limits.` → `Voltage limits can now be configured per output.`
- `Fixed crash when opening empty reports.` → `Opening an empty report no longer crashes the application.`
- `Refactored fan controller.` → omit if behavior is unchanged.
