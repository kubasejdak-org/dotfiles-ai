---
name: readme-init
description: >
    Generates a README.md for a new kubasejdak-org C++ library repository following the established organizational
    format. Use this skill whenever the user asks to initialize, create, or write a README for a new library or
    component — even if they say "scaffold", "bootstrap", "create docs", or "document this repo". Also trigger when the
    user says something like "set up this repo" or "I need a README for my new library".
---

# README Init

This skill creates a `README.md` for a new `kubasejdak-org` C++ library, following the established format used across
the organization.

Read `references/example-readme.md` to see a concrete example of the finished format before generating anything. That
file is the gold standard — use it as a structural template.

## What to Gather First

Before writing, collect the key facts about the library. Ask the user if anything is unclear:

- **Library name** (the repo/CMake target name)
- **One-sentence purpose** — what problem it solves
- **Main features** — 2–5 bullet points
- **Components** — logical parts of the library (e.g., `core`, `utils`, `io`)
- **Technologies** — language standard, build system, any notable dependencies
- **Platform targets** — Linux, baremetal, RTOS, or all?
- **Any special integration steps** — e.g., `find_package` usage, required variables

If the user provides a CLAUDE.md or existing code structure, extract what you can from there rather than asking
redundant questions.

## README Structure

Generate the README in this exact section order:

### 1. Title + one-liner description

```markdown
# <library-name>

<One paragraph: what it is, what platforms it targets, what it provides.>

Main features:

- **<feature>:** <description>,
- **<feature>:** <description>.

> [!IMPORTANT]
>
> <Any hard prerequisite (e.g., requires CMake, requires C++23).>
```

### 2. Architecture

```markdown
## Architecture

### Components

- **`<component>`:**
    - <What it does.>
    - <Any platform-specific behavior or notable sub-features.>

> [!IMPORTANT]
>
> <Any important constraint on how components are selected or built.>

#### `<component>` (detailed section for non-trivial components)

<Prose description of the component's purpose.>

<Mermaid diagram if the component has a non-obvious flow — e.g., a dispatch mechanism, state machine, or multi-step
initialization. Keep it readable, not exhaustive.>

### Technologies

- **Language**: <e.g., C++23, C17>
- **Build System**: CMake (minimum version <X.Y>)
- **Documentation**: <e.g., MkDocs with Material theme>
- **Static Analysis**: <e.g., clang-format, clang-tidy>
- **CI/CD**: <e.g., GitHub Actions>

### Repository Structure

<brief sentence about which layout convention is followed>

<bash code block with annotated tree of top-level dirs and key files>
```

The repository structure tree should use the same style as the example — annotated with `#` comments describing each
directory's role. Keep it to one level deep for most dirs, two for the most important.

### 3. Usage

```markdown
## Usage

<Brief framing sentence.>

### CMake Integration

<FetchContent snippet + find_package usage, with realistic placeholders.>

### Configuration

<Table of CMake variables the user sets to control behavior.>

### Implementing `<entry-point>()` (if applicable)

<Code snippet showing the minimal application-side implementation.>

### Linking

<cmake target_link_libraries snippet.>

> [!TIP]
>
> See [examples/](examples/) for complete, per-platform integration examples.
```

Only include subsections that are relevant to the library. For example, skip "Implementing `appMain()`" if the library
doesn't define an entry-point abstraction.

### 4. Development

```markdown
## Development

> [!NOTE]
>
> This section is relevant when working with `<library>` itself, in standalone way. However presets used to build
> `<library>` tests and examples can be used as a reference for dependent projects.

### Commands

- **Configure:** `cmake --preset <preset-name> . -B out/build/<preset-name>`
- **Build:** `cmake --build out/build/<preset-name> --parallel`
- **Run tests:** `cd out/build/<preset-name>/bin; ./<binary-name>`
- **Reformat code:** `tools/check-clang-format.sh`
- **Run linter:** `cd out/build/<preset-name>; ../../../tools/check-clang-tidy.sh`

### Available CMake Presets

<List the presets relevant to this library. Mirror the structure from the example — Native Linux, Cross-compilation,
Sanitizer variants. Omit categories not applicable to this library.>

> [!NOTE]
>
> For local development use `<recommended-preset>` preset.

### Code Quality

- **Zero Warning Policy:** All warnings treated as errors
- **Code Formatting:** clang-format with project-specific style checked
- **Static Analysis:** clang-tidy configuration checked
- **Coverage:** Code coverage reports generated
- **Valgrind:** Tests and examples run under valgrind
- **Sanitizers:** Address, leak, thread, and undefined behavior sanitizers checked

### Important Notes

<Numbered list of key facts developers need to know when contributing — component structure conventions, testing
requirements, dependency constraints, error handling style, namespace rules. Adapt to the specific library; don't copy
notes that don't apply.>
```

## Style Guidelines

- Keep the tone factual and concise. No marketing language.
- Use backtick code formatting for all identifiers, file paths, and CMake variables.
- Use `> [!IMPORTANT]` and `> [!TIP]` and `> [!NOTE]` callouts sparingly — only for things that would be missed without
  the visual emphasis.
- Mermaid diagrams only where the flow is genuinely non-obvious. Prefer text if a sentence suffices.
- The "Important Notes" section at the end of Development should contain 5–8 numbered points covering component
  structure, testing practices, dependency management, code style, error handling approach, documentation expectations,
  and namespace conventions — adapting each to the actual library's specifics.

## Output

Write the README directly to `README.md` in the repository root (or wherever the user specifies). If a `README.md`
already exists, read it first and offer to either update sections or replace it after confirmation.

After writing, briefly summarize what sections were included and note any information you had to guess or approximate —
so the user knows where to review carefully.
