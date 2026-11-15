# Changelog conventions

See [template.md](template.md) for the document structure and category guidance. Replace illustrative content with
actual changes and remove italic guidance when using the template.

- File title: `# Changelog`.
- `## Unreleased` appears first, followed by releases newest first: `## 2.0.1 (2026.11.13)` (no `v`; date `YYYY.MM.DD`).
- Within each section, use only nonempty headings, ordered: `### Added`, `### Changed`, `### Fixed`, `### Removed`.
- Report functional effects visible to users, operators, or clients of the repository's public API. Include substantial
  reliability, safety, diagnostic, or performance changes when their observable impact is clear. Omit internal
  refactoring, docs, CI, tooling, deployment, SHA bumps, and implementation details without observable effect.
- Each main bullet is one short, complete, natural sentence describing the resulting behavior, not the developer action.
  Group related changes into one outcome; use backticks for code identifiers, channel IDs, and event names. Use only
  supplied or verified facts; do not invent details to make an entry more specific.
- Use optional indented sub-bullets for details that help users understand or use the change. Keep the main entry
  understandable on its own and omit unnecessary detail.

Examples (bad → good):

- `Added PDF export.` → `Users can now export reports to PDF.`
- `Implemented configurable voltage limits.` → `Voltage limits can now be configured per output.`
- `Fixed crash when opening empty reports.` → `Opening an empty report no longer crashes the application.`
- `Refactored fan controller.` → omit if behavior is unchanged.
