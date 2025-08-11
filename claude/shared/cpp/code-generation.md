# C++ Code Generation Rules

This document defines the standards for generating high-quality, production-ready C++ code across all C++ agents and
tools.

## Core Principles

### Modern C++ Standards

- **Target C++17/C++20/C++23**: Leverage modern language features appropriately
- **Feature Usage**: Use `auto`, `constexpr`, `consteval`, range-based loops, structured bindings
- **Concepts**: Employ C++20 concepts for template constraints when available
- **Ranges**: Prefer standard library ranges over manual loop constructs
- **Modules**: Use C++20 modules when project structure supports it

## Code Organization

### File Structure

- **Header Guards**: Use `#pragma once` for header files
- **Include Order**: local headers, third-party headers, system headers
- **Forward Declarations**: Use forward declarations to reduce compile times
- **Implementation Files**: Keep implementation details in `.cpp` files

### Code Style

- **Consistency**: Follow existing codebase conventions
- **Operator Alternatives**: Prefer operator overloads over explicit function calls when available for improved
  readability:
  - Use `*optional_value` instead of `optional_value.value()` for optional dereferencing
  - Use `*smart_ptr` instead of `smart_ptr.get()` for pointer dereferencing
  - Use `container[index]` instead of `container.at(index)` when bounds are guaranteed

<!-- 

### Memory Safety

- **RAII First**: Always prefer automatic resource management
- **Smart Pointers**: Use `std::unique_ptr`, `std::shared_ptr`, `std::weak_ptr` over raw pointers
- **Stack Allocation**: Prefer stack-allocated objects when possible
- **No Manual Management**: Avoid `new`/`delete` pairs; use containers and smart pointers
- **Resource Lifetime**: Clearly define ownership semantics

### Type Safety

- **Strong Typing**: Use enum classes, type aliases for semantic meaning
- **Const Correctness**: Apply `const` everywhere possible - parameters, methods, variables
- **Compile-Time Checks**: Use `static_assert`, concepts, and SFINAE for early error detection
- **Explicit Constructors**: Mark single-argument constructors as `explicit`
- **No Implicit Conversions**: Avoid dangerous implicit type conversions

### Exception Safety

- **RAII Guarantee**: All resources managed through RAII
- **Strong Exception Safety**: Operations either succeed completely or leave state unchanged
- **No-Throw Guarantee**: Mark functions `noexcept` when they cannot throw
- **Exception Specifications**: Use `noexcept` appropriately, avoid `throw()` specifications

### Performance

- **Zero-Cost Abstractions**: Write expressive code without runtime overhead
- **Move Semantics**: Implement move constructors and assignment operators when beneficial
- **Perfect Forwarding**: Use universal references and `std::forward` in templates
- **RVO/NRVO**: Design functions to benefit from return value optimization
- **Inline Considerations**: Use `inline` judiciously, prefer header-only templates

### Template Metaprogramming

- **Concepts Over SFINAE**: Use C++20 concepts when available
- **Template Specialization**: Prefer partial specialization over function overloads
- **CRTP**: Use Curiously Recurring Template Pattern for static polymorphism when appropriate
- **Type Traits**: Leverage `std::type_traits` and custom traits
- **Variadic Templates**: Use parameter packs for flexible interfaces

### Concurrency

- **Thread Safety**: Design interfaces to be thread-safe by default or clearly document requirements
- **Atomic Operations**: Use `std::atomic` for lock-free programming when appropriate
- **Synchronization**: Prefer standard library primitives (`std::mutex`, `std::condition_variable`)
- **Async Programming**: Use `std::future`, `std::async`, and task-based parallelism
- **Data Races**: Eliminate data races through proper synchronization or immutability

## API Design Guidelines

### Interface Design

- **Intuitive Names**: Use clear, descriptive function and variable names
- **Hard to Misuse**: Design interfaces that prevent common mistakes
- **Principle of Least Surprise**: Follow established conventions and patterns
- **Minimal Interfaces**: Expose only what clients need
- **Orthogonal Design**: Keep different concerns separate

### Error Handling

- **Exceptions for Exceptional Cases**: Use exceptions for truly exceptional conditions
- **Error Codes**: Consider `std::optional`, `std::expected` (C++23) for recoverable errors
- **Fail Fast**: Detect errors as early as possible
- **Error Context**: Provide meaningful error messages and context

### Documentation

- **Self-Documenting Code**: Choose names that explain intent
- **Invariants**: Document class and function invariants clearly
- **Preconditions/Postconditions**: Specify what functions expect and guarantee
- **Examples**: Provide usage examples for complex interfaces

## Code Organization

### Naming Conventions

- **Classes**: `PascalCase` (e.g., `ThreadSafeQueue`)
- **Functions/Variables**: `snake_case` (e.g., `process_data`, `item_count`)
- **Constants**: `cPascalCase`
- **Namespaces**: `lowercase` (e.g., `namespace utils`)
- **Template Parameters**: `PascalCase` (e.g., `template<typename DataType>`)

### Code Style

- **Readable Formatting**: Use consistent indentation and spacing
- **Line Length**: Keep lines reasonable length (typically 80-120 characters)
- **Braces**: Consistent brace style throughout codebase
- **Comments**: Explain why, not what; focus on intent and rationale

## Quality Assurance

### Static Analysis

- **Compiler Warnings**: Enable high warning levels (`-Wall -Wextra -Werror`)
- **Static Analysis Tools**: Use tools like `clang-tidy`, `cppcheck`
- **Sanitizers**: Use address, thread, and undefined behavior sanitizers during testing

### Testing Considerations

- **Testable Design**: Write code that's easy to test
- **Dependency Injection**: Use dependency injection for better testability
- **Mock Interfaces**: Design interfaces that can be easily mocked
- **Edge Cases**: Consider and handle boundary conditions

### Code Reviews

- **Readability**: Code should be readable by other developers
- **Maintainability**: Consider future modifications and extensions
- **Performance**: Identify potential performance bottlenecks
- **Security**: Review for potential security vulnerabilities

## Common Patterns

### Resource Management

```cpp
// RAII wrapper example
class FileHandle {
public:
    explicit FileHandle(const std::string& filename) 
        : file_(std::fopen(filename.c_str(), "r")) {
        if (!file_) {
            throw std::runtime_error("Failed to open file");
        }
    }
    
    ~FileHandle() { 
        if (file_) std::fclose(file_); 
    }
    
    // Non-copyable, movable
    FileHandle(const FileHandle&) = delete;
    FileHandle& operator=(const FileHandle&) = delete;
    FileHandle(FileHandle&& other) noexcept : file_(other.file_) {
        other.file_ = nullptr;
    }
    
private:
    std::FILE* file_;
};
```

### Template Design

```cpp
// Use concepts for template constraints
template<typename T>
concept Drawable = requires(T t) {
    t.draw();
};

template<Drawable T>
void render(const T& object) {
    object.draw();
}
```

### Error Handling

```cpp
// Use std::optional for optional values
std::optional<int> parse_int(const std::string& str) {
    try {
        return std::stoi(str);
    } catch (const std::exception&) {
        return std::nullopt;
    }
}
```

 -->
