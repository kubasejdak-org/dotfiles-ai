---
name: code-review
description: >
    Perform a code review imitating the owner's personal review style. Use for reviewing C++ files, diffs, or PRs.
    Trigger on: "review", "code review", "review this", "check this code", "review PR".
---

# Code Review Skill

Performs a structured code review using the owner's personal style rules. Reviews changed files by default (git diff),
or specific files/directories when provided.

## Argument Parsing

Parse `$ARGUMENTS` to extract (all optional):

- **aspect** — one of:
    - Groups: `style` (formatting + naming + layout), `craft` (idioms + design), `intent` (objectives + tests)
    - Individual aspects: `formatting`, `naming`, `layout`, `idioms`, `design`, `objectives`, `tests`
    - If omitted, all aspects are reviewed
- **`--group`** — one of: `severity` (default), `file`, `aspect`
- **paths** — one or more file or directory paths to review. If omitted, use `git diff` to find changed files

Examples:

- _(empty)_ → full review of git diff, grouped by severity
- `style` → formatting + naming + layout review of git diff
- `craft` → idioms + design review of git diff
- `intent` → objectives + tests review of git diff
- `formatting` → formatting-only review of git diff
- `naming src/Foo.cpp` → naming review of that file
- `src/network/ --group=file` → full review of that directory, grouped by file
- `idioms src/Bar.hpp --group=aspect` → idioms review, grouped by aspect

## Step 1: Determine Files to Review

- If paths were given: read those files directly
- Otherwise: run `git diff --name-only HEAD` (or `git diff --cached --name-only` if staged) to get changed files
- If no changed files found, ask the user which files to review

## Step 2: Detect Language

Determine language from file extensions:

- `.cpp`, `.c`, `.cc`, `.cxx`, `.hpp`, `.h`, `.hxx` → C/C++
- Other languages not yet supported. Note this to the user and skip those files

## Step 3: Load Reference Files

If the argument is a **group**, expand it to its constituent aspects:

| Group    | Aspects                    |
| -------- | -------------------------- |
| (none)   | _all aspects_              |
| `style`  | formatting, naming, layout |
| `craft`  | idioms, design             |
| `intent` | objectives, tests          |

Then load files for each aspect using the table below.

**Aspect guide** — which aspect a rule belongs to and which file it loads:

| Aspect       | Guiding question                                      | Common file     | Language file          |
| ------------ | ----------------------------------------------------- | --------------- | ---------------------- |
| `formatting` | How does the code look? (formatting, spacing, braces) | —               | `{lang}/formatting.md` |
| `naming`     | What are identifiers called?                          | —               | `{lang}/naming.md`     |
| `layout`     | Where does code live? (files, classes, namespaces)    | —               | `{lang}/layout.md`     |
| `idioms`     | Which construct or syntax is used on this line?       | —               | `{lang}/idioms.md`     |
| `design`     | How is this class or module structured?               | —               | `{lang}/design.md`     |
| `objectives` | Does this change do what it claims?                   | `objectives.md` | —                      |
| `tests`      | Is the change adequately tested?                      | `tests.md`      | —                      |

`{lang}` maps to:

| Language | Directory |
| -------- | --------- |
| C / C++  | `cpp`     |

## Step 4: Perform the Review

Read each file to review. Apply rules from the loaded reference files. For each finding:

- Identify the exact location (`file:line` or `file:line-line`)
- State what rule is violated
- Give a concrete suggestion or show the corrected form when helpful
- Assign severity:
    - **critical** — correctness bugs, UB, security issues, API contract violations
    - **high** — design issues, maintainability, deviation from project conventions
    - **low** — minor style preferences, optional polish

Focus on the diff/changed lines first, flag pre-existing issues only if they are critical or if the change interacts
with them.

## Step 5: Format Output

### `--group=severity` (default)

```markdown
## Critical

- `src/Foo.cpp:42` — [finding]
- `src/Bar.hpp:10` — [finding]

## High

- `src/Foo.cpp:17` — [finding]

## Low

- `src/Foo.hpp:3` — [finding]
```

### `--group=file`

```markdown
## src/Foo.cpp

- :42 [critical] — [finding]
- :17 [high] — [finding]

## src/Bar.hpp

- :10 [critical] — [finding]
```

### `--group=aspect`

```markdown
## Naming

- `src/Foo.cpp:5` [high] — [finding]

## Idioms

- `src/Bar.hpp:12` [critical] — [finding]
```

If there are no findings in a severity/file/aspect bucket, omit that section entirely.

End with a one-line summary: `N critical, N high, N low findings.` or `No findings.`

## Reference Files

- `references/common/objectives.md` — scope, description match, API completeness
- `references/common/tests.md` — test coverage expectations
- `references/cpp/formatting.md` — formatting and style (from clang-format config)
- `references/cpp/naming.md` — naming conventions (from clang-tidy config)
- `references/cpp/idioms.md` — preferred C++ idioms, constructs, and modern feature usage
- `references/cpp/layout.md` — directory, file and class structure rules
- `references/cpp/design.md` — high-level design: RAII, exception safety, API design, error handling, concurrency
