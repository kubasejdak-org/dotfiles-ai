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

## Modern C++

- **Target C++17/20/23**: Use modern features where the project standard allows (check all compilers used by project)
- Prefer `auto` for type deduction when the type is verbose or obvious from context
- Use `constexpr` / `consteval` to move computation to compile time where possible
- Prefer range-based `for` loops over index loops unless index is needed
- Use structured bindings (`auto& [a, b] = ...`) to unpack pairs/tuples/structs
- Prefer `std::ranges::*` algorithms over classic `<algorithm>` counterparts
- Use C++20 concepts for template constraints instead of SFINAE (see Template Constraints below)

## Operator Overload Preferences

Prefer operator syntax over named accessor calls when bounds/validity are guaranteed:

- `*opt` instead of `opt.value()` for `std::optional` dereferencing
- `*ptr` instead of `ptr.get()` for smart pointer dereferencing
- `container[i]` instead of `container.at(i)` when bounds are guaranteed

## Type Safety

- Mark single-argument constructors `explicit` to prevent accidental implicit conversions
- Avoid implicit type conversions between unrelated types; require an explicit cast
- Use `static_assert` and concepts for compile-time correctness checks

## Performance

- Implement move constructors and move assignment operators for resource-owning types
- Use `std::forward<T>` in template forwarding functions (universal references)
- Design functions to benefit from RVO/NRVO: return a single named local or a temporary directly
- Avoid unnecessary copies: pass large objects by `const&` or move into owning parameters

## Template Constraints

- Prefer C++20 `concept` constraints over `std::enable_if` / SFINAE
- Use `requires` clauses to express interface expectations clearly
- Leverage `std::type_traits` for conditional logic in pre-C++20 code
- Prefer `typename` over `class` in template parameter lists (`template<typename T>`, not `template<class T>`)
