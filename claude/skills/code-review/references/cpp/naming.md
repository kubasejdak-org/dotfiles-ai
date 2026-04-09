# C++ Naming Rules

- **Classes / Structs / Enums / Unions / Type aliases / Typedefs:** `CamelCase`
- **Abstract/interface classes:** `CamelCase` + prefix `I` (e.g., `IHandler`, `ITransport`)
- **Functions / Methods / Variables / Parameters / Public members:** `camelBack`
- **Private / Protected members:** `camelBack` + prefix `m_` (e.g., `m_count`, `m_bufferSize`)
- **Namespaces:** `lower_case`
- **Macros:** `UPPER_CASE`
- **Template type parameters:** `CamelCase` (e.g., `template<typename ValueType>`)
- **Template value parameters:** `camelBack`
- **Enum constants:** `CamelCase`

## Name Quality

- **Descriptive:** name should convey what the thing is or does — a reader should not need to look at the implementation
  to understand the intent
- **Length:** prefer 1–3 words; more than 3 words is a signal the name is doing too much or the scope is too broad
- **No single-letter names** except established loop indices (`i`, `j`, `k`), template parameters and ignored values (`_`)
- **No abbreviations** unless the shortening is widely understood — prefer the full word; common accepted exceptions
  include: `addr`, `idx`, `ptr`, `buff`, `cfg`, `msg`, `err`, `tmp`, `ctx`, and similar domain-standard shortenings
- **Context can relax these rules:** in a very small, self-contained scope (short function, small lambda) a simpler name
  like `size` instead of `blockSize` is acceptable if the context makes meaning obvious

## Common Violations to Flag

- Member variable without `m_` prefix
- Interface class without `I` prefix
- `snake_case` functions or variables
- `UPPER_CASE` or `PascalCase` for namespaces
- Inconsistent parameter name between declaration and definition
