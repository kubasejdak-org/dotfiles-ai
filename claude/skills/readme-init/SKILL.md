---
name: readme-init
description: >
    Generates a README.md for a library or project repository following an established organizational format. Supports
    any programming language — C++, Python, Rust, Go, TypeScript, and others. Use when asked to create, initialize, or
    write a README for a new library, tool, or component.
---

# README Init

This skill creates a `README.md` for a library or project repository, following an established organizational format.

## Step 1: Detect Language and Load Reference

Before doing anything else, determine the primary language of the repository. Use whatever the user has provided: file
extensions, build config names (`CMakeLists.txt`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `package.json`), or an
explicit statement.

If the user explicitly specifies a language or a reference file to use, skip detection and use that directly.

Otherwise, load the appropriate language reference file. These files are the gold standard for structure and style —
read the relevant one **before generating anything**:

- **C / C++**: `references/readme-cpp.md`
- **Other / unknown**: use `references/readme-cpp.md` as a structural baseline and adapt section names and tooling
  accordingly

If the language is something not listed, read the closest reference file and adapt: the overall section order (Overview
→ Architecture → Usage → Development) is universal; only the tooling details change.

## Step 2: Extract Info Before Asking

Before asking the user anything, extract as much as possible from what they've already provided:

- Build configs (`CMakeLists.txt`, `pyproject.toml`, `Cargo.toml`, etc.) — mine for: name, dependencies, entry points,
  version constraints.
- Source tree or `CLAUDE.md` — mine for: components, namespace/package structure, platform targets.
- Any description the user has given in the conversation.

Only ask about things you genuinely cannot infer. Present your extracted understanding as a compact summary ("Here's
what I gathered — does this look right?") and ask for corrections or additions before writing.

### Minimum required info (always confirm if not found)

| Field                                                          | What it drives                           |
| -------------------------------------------------------------- | ---------------------------------------- |
| Project / library name                                         | Title, install snippets, import examples |
| One-sentence purpose                                           | Opening paragraph                        |
| Main components or modules (2–5)                               | Architecture section                     |
| Key configuration surface (env vars, config files, build vars) | Configuration section                    |
| Language version + build/package tool + minimum version        | Technologies section                     |
| Platform / environment targets                                 | Opening paragraph, preset/env tables     |
| Namespace, package name, or module path                        | Code snippets, Important Notes           |

### Good-to-have (approximate if missing, note it)

- Actual directory layout (derive from language conventions if unknown)
- Entry-point abstraction, if any
- Available presets, profiles, or run modes
- Version pin / tag for the install snippet — use a placeholder like `<version>` if unknown

## Step 3: Generate the README

Follow the structure from the reference file for the detected language. The universal section order is:

1. **Title + one-liner description** — name, what it does, platforms/environments, main features, hard prerequisites
2. **Architecture** — components, technologies, repository structure
3. **Usage** — integration, configuration, entry-point implementation (if any), linking or importing
4. **Development** — commands, available presets/profiles, code quality policy, important notes

Skip any subsection that clearly doesn't apply to the project. When skipping, don't leave a stub — just omit the heading
entirely. At the end of generation, tell the user which subsections were skipped and why.

### Conditionality rules (apply across all languages)

- Skip **Configuration** if the project has no user-facing variables, env vars, or config files.
- Skip **Implementing `<entry-point>()`** (or equivalent) if the library has no entry-point abstraction.
- Skip per-platform preset/profile tables if the project targets only one environment.
- Skip the `examples/` tip callout if no examples directory exists or is planned.
- Add Mermaid diagrams only for genuinely non-obvious multi-step flows. When in doubt, skip.

### Important Notes — writing guidance

Write 5–8 numbered points at the end of the Development section. Cover these topics, adapted to the project:

| Topic                        | Adapt by…                                                             |
| ---------------------------- | --------------------------------------------------------------------- |
| Module / component structure | Actual directory layout, naming conventions for the language          |
| Testing                      | Framework used, how to run, any fixture or fixture-style conventions  |
| Dependencies                 | How they're managed, any version constraints to watch                 |
| Code style                   | Formatter, linter, enforcement mechanism                              |
| Error handling               | Language-idiomatic approach (exceptions, `Result`, error codes, etc.) |
| Documentation                | What to update, where docs live, docstring expectations               |
| Namespace / package          | The actual import path or namespace hierarchy                         |
| Platform / environment rules | Any isolation or environment-specific conventions                     |

Do **not** copy Important Notes verbatim from the reference file. The reference file shows the _format and topics_, not
boilerplate to paste.

## Style Guidelines (all languages)

- Factual and concise. No marketing language.
- Backtick formatting for all identifiers, file paths, config keys, and commands.
- `> [!IMPORTANT]`, `> [!TIP]`, `> [!NOTE]` callouts sparingly — only where something is genuinely easy to miss.
- Lists in Important Notes should each be 2–4 lines, not one-liners.
- Code snippets should be realistic — use plausible placeholder values, not `<YOUR_VALUE_HERE>` everywhere.

## Step 4: Output and Handoff

Write `README.md` to the repository root (or wherever the user specifies).

If a `README.md` already exists, read it first, then offer to either update specific sections or replace it (ask for
confirmation before overwriting).

After writing, briefly tell the user:

1. Which language reference was used.
2. Which sections were included and which were skipped (and why).
3. What information was approximated or guessed — these are the spots they should review carefully.
4. Any questions that remain open (e.g., actual version pins, entry-point naming, examples directory presence).
