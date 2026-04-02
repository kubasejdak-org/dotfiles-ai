# C++ Style Rules

**Priority:** If the project has `.clang-format` / `.clang-tidy` configs, those are authoritative — CI enforces them on
every commit. Only flag style issues the author clearly hasn't run the tools on. Rules below are the fallback for
projects without those configs, or for aspects the configs do not cover.

## Formatting

- **Indent:** 4 spaces, no tabs
- **Line length:** 120 columns max
- **Pointer / reference:** left-aligned — `int* ptr`, `int& ref`, not `int *ptr`
- **Qualifier order:** `static constexpr inline const volatile <type>`
- **Max 1 blank line** between any two sections; 1 blank line at EOF
- **Separate blocks with blank line:**
    - between top-level definitions
    - after `if`, `for`, `while`, `switch` expressions
    - between separate logical
    - **exception:** adjacent explicit scopes creatd by curly braces

## Braces

- Function body: opening brace on **new line**
- Class / struct / namespace / enum: opening brace on **same line**
- `catch`, `else`, `while` (do-while): brace on **same line**
- 1-line `if`/`for`/`while` can skip braces
- No short `if`, `for`, `while` on single line

## Includes

Order (clang-format priority, lowest = first):

1. Project headers (`"..."`)
2. System/platform headers with extension (`<stdio.h>`, `<sys/types.h>`)
3. Third-party libraries (`<boost/...>`, `<catch2/...>`, `<fmt/...>`, `<spdlog/...>`, etc.)
4. Standard library headers (`<vector>`, `<string>`, `<thread>`, etc.)

Within each group: sorted case-sensitively.

**Note:** In tests even project headers should use `<...>` to simulate usage by external clients.

## Other

- `#pragma once` (not include guards)
- No trailing whitespace
- LF line endings
- Newline at end of file
