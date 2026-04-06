# C++ Design Rules

## Resource Management (RAII)

- Manage all resources (memory, file handles, sockets, locks) through RAII — tie acquisition to construction, release to
  destruction
- Implement or `= delete` copy operations for resource-owning types; provide move operations where transfer makes sense

## Error Handling

- Do not use exceptions
- Use `std::optional<T>` for values that may legitimately be absent
- Use `std::expected<T, E>` (C++23) or `std::error_code` for recoverable errors where the caller must handle failure
- Provide meaningful error context — error messages should explain what went wrong and where
- Detect errors as early as possible (fail fast); do not silently swallow errors

## API Design

- Design interfaces that are **hard to misuse**: make the common case obvious, the wrong case a compile error
- Follow the **principle of least surprise**: behave consistently with standard library conventions
- Keep interfaces **minimal** — expose only what clients need; prefer private/internal helpers
- Separate **orthogonal concerns** — a class should do one thing well
- Prefer value semantics for small/cheap types; reference semantics for large/polymorphic types

## Concurrency

- Design interfaces to be **thread-safe by default**, or document thread-safety requirements explicitly
- Use `std::atomic<T>` for simple shared state; prefer lock-free programming only when contention is proven
- Use OSAL synchronization primitives: `osal::Mutex`, `osal::Semaphore`, `osal::ScopedLock`
- Eliminate data races through proper synchronization or immutability; never rely on data race "working in practice"
