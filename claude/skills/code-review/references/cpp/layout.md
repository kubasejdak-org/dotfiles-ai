# C++ Layout Rules

## File Header

- If the project defines a standard file header comment (e.g. license or copyright), every file must include it
- License year field must contain only the creation year — no ranges (e.g. `2021`, not `2021–2024` or `2021–present`)

## File Organization

- **One class per file** — file named after the class (e.g., `NetworkHandler.hpp` / `NetworkHandler.cpp`)
- Closely related config structs, aliases, or small helpers may coexist in the same file if tightly coupled to the main
  class; file name still follows the main class
- Small standalone structs / enums / aliases with no clear leading class go in a thematic header: `types.hpp`,
  `config.hpp`, `traits.hpp`, `errors.hpp`, etc.
- Separate declaration (`.hpp`) from definition (`.cpp`); templates and `inline` functions are the exception

## Header Content

- Only declarations in headers — no function body definitions except:
    - Templates
    - `inline` functions where inlining is intentional
- `#pragma once` at the top

## Class Layout (order of sections)

```cpp
class Example {
    // Private type aliases

public:
    // Public type aliases / nested types
    // Constructors, destructor, special member functions
    // Public methods

protected:
    // Protected methods

private:
    // Inner classes / structs / enums

private:
    // Private methods

private:
    // Member variables
};
```

## Declaration Order

- The order of method / function declarations in the header must match the order of their definitions in the
  implementation file
- For template classes, method definitions must appear below the class declaration, not inline inside the class body:

```cpp
template <typename T>
class Foo {
public:
    void bar();
    int baz(T value);
};

template <typename T>
void Foo<T>::bar() { ... }

template <typename T>
int Foo<T>::baz(T value) { ... }
```

## Namespace Layout

- No namespace indentation
- Closing brace annotated: `} // namespace foo`
- Never use `using namespace` at file scope — in headers or implementation files
- Internal-linkage functions and variables in `.cpp` files go in an anonymous namespace, not `static`:

```cpp
namespace {

void helperFunction() { ... }

} // namespace
```
