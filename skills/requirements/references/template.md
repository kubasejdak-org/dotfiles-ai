# Requirements Templates

Use the flat format for simple single-component documents and the grouped format for documents spanning distinct
components or categories. Replace illustrative text with project-specific requirements.

## Flat Format

```markdown
# _Project / Component Name_ – Requirements

## Overview

_Brief description of purpose, scope, and objectives._

## Functional Requirements

- [ ] **FR-1**: _Functional requirement description._
    - _Supporting details._

## Non-Functional Requirements

- [ ] **NFR-1**: _Non-functional requirement description._
    - _Specific metrics or benchmarks._

## Technical Constraints and Requirements

- [ ] **TR-1**: _Technical constraint or requirement._
    - _Context or reasoning._
```

## Grouped Format

Number H3 groups sequentially within each H2 section, restarting at 1 per section. Requirement IDs use `N.M`, so an ID
such as `1.1` is scoped to its H2 section.

```markdown
# _Project / Component Name_ – Requirements

## Overview

_Briefly describe the project's or component's purpose, scope, and key objectives. This section provides context for the
requirements below._

## Functional Requirements

### 1. _[Component or Feature Group]_

- [ ] **1.1**: _[Functional requirement description]_
    - _Additional info (details, rationale, or sub-requirements) can be added as indented bullet points._

- [ ] **1.2**: _[Another functional requirement]_
    - _Additional details or examples, if any._

### 2. _[Another Component or Feature Group]_

- [ ] **2.1**: _[Functional requirement description]_
    - _Additional details._

## Non-Functional Requirements

### 1. _[Category, e.g. Performance]_

- [ ] **1.1**: _[Non-functional requirement description]_
    - _Additional info (e.g. specific metric or benchmark to meet)._

- [ ] **1.2**: _[Another non-functional requirement]_
    - _Additional details or context, if needed._

## Technical Constraints and Requirements

### 1. _[Category, e.g. Platform]_

- [ ] **1.1**: _[Technical constraint or requirement]_
    - _Additional context or reasoning (e.g. mandated technology or standard)._

- [ ] **1.2**: _[Another technical constraint]_
    - _Additional details or implications, if any._
```
