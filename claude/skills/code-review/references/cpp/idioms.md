# C++ Construct Rules

## Memory Management

- No raw `new` / `delete` — use `std::unique_ptr`, `std::shared_ptr`, or stack allocation
- No owning raw pointers; non-owning raw pointers are acceptable when lifetime is clear

## Casts

- No C-style casts `(Type)x` — require `static_cast`, `dynamic_cast`, `const_cast`, or `reinterpret_cast`
- No implicit numeric / type conversions — require explicit cast when converting between types

## Algorithms

- Prefer STL algorithms over raw loops when intent is clearer: `std::transform`, `std::find_if`, `std::any_of`,
  `std::ranges::*`, etc.
- Raw loops are fine when an algorithm would obscure intent or require awkward lambdas

## Enums

- `enum class` required; plain `enum` only when C API compatibility is needed (must be justified) or values are intended
  to be used as integers

## Implementation Details in Headers

- Do not expose internal types, helpers, or implementation details in public headers
- If a type must appear in a header for language reasons (e.g., template), place it in a `detail` namespace:

```cpp
namespace mylib::detail {
    struct InternalHelper { ... };
}
```

- If the detail is large or hurts readability, move it to a `detail/` subdirectory with the same `detail` namespace
