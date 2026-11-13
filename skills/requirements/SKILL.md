---
name: requirements
description: >
    Create, update, improve, or restructure software requirements and PRD documents, or derive requirements from
    existing code. Use when the user requests requirements documentation work, rather than implementation of a feature.
---

# Requirements

## Shared Guidance

Select a workflow below from the action requested in the prompt; combine workflows only when requested. Prompts can
include document or code paths, requirement IDs, and changes without special argument syntax.

Read the relevant document or code before editing. Projects may have multiple requirements files; identify the target
from the prompt and project context. Ask focused questions about material ambiguities before dependent changes. Do not
invent business decisions or measurable targets to fill gaps.

Apply clearly requested edits directly. For review-only requests, report findings and proposed wording without editing.
Keep changes within the requested scope and report unrelated issues separately. Summarize changes or findings, including
unresolved assumptions and any ID changes.

Requirements must be specific, achievable, relevant, unambiguous, and testable. They describe **what** the system does
from the user's perspective, not **how** its code implements it. Class, function, method, variable, type, constant, and
internal file names are red flags: translate them into observable behavior. Record mandated technical constraints in the
technical section; do not invent implementation choices.

- Bad: "The ConfigParser::load() method must accept a file path parameter."
- Good: "The system must load its configuration from a file path supplied at startup."

## Document Format

Before creating or restructuring a document, read the matching template and replace its illustrative text:

- [Flat template](references/template-flat.md): simple single-component documents, with `FR-N`, `NFR-N`, and `TR-N` IDs.
- [Grouped template](references/template-grouped.md): distinct components or categories, with `N.M` IDs. Number H3
  groups sequentially, restarting at 1 within each H2 section. Identify requirements by section and ID when a bare ID is
  ambiguous.

Use `requirements.md` for new documents. Preserve existing filenames, including `prd.md`, unless asked to rename them.
Include Overview, Functional Requirements, Non-Functional Requirements, and Technical Constraints and Requirements;
explain any irrelevant section omitted.

Use checkbox requirements with useful supporting details as indented bullets. Preserve completion states and, during
ordinary edits, existing format and IDs. IDs must be unique within their category or section. Assign new requirements
the next number in their category or group, and new groups the next number in their section.

## Workflows

### Create

Example: "Create requirements for a CLI tool that syncs local folders to S3."

1. Extract the goal, target users, scope, and success criteria from the description and project context.
2. Discover missing behavior, business purpose, timing constraints, system boundaries, integrations, and mandated
   technical or performance constraints. If no idea is supplied, begin discovery with the user.
3. Probe vague answers with concrete examples and observable acceptance criteria until the scope is clear, then draft
   the requirements.

### Update

Examples:

- "Add rate limiting and API key authentication to requirements.md."
- "Update FR-4 in docs/prd.md to cover CSV export as well as JSON."

Identify the affected requirements and apply the requested additions, modifications, or removals.

### Adapt

Example: "Adapt docs/old-requirements.txt to the standard requirements template."

1. Read the complete source and categorize its requirements as functional, non-functional, or technical.
2. Separate main requirements from supporting details and restructure using the template, preserving intent, coverage,
   and completion states.
3. Flag ambiguous items rather than silently adding or removing requirements. Improve wording beyond restructuring only
   when requested.

### Improve

Examples:

- "Review requirements.md for clarity and testability."
- "Improve FR-3, FR-7, and NFR-1 in requirements.md."
- "Improve Functional Requirements 1.2 in docs/prd.md."

Evaluate the whole document or requested requirements against the shared quality standards. Explain concrete issues and
formulate clearer wording. Split or merge requirements when the requested improvements require it.

### From Code

Example: "Generate requirements from src/auth/, which handles authentication and roles."

1. Analyze user-facing behavior, inputs and outputs, data flows, validation, errors, edge cases, and external
   integrations within the requested scope.
2. Translate code into observable capabilities and constraints: "What behavior does this enable?"
3. Separate observed behavior from inferred business intent. Note assumptions and clarify material inferences; do not
   present unsupported behavior or performance guarantees as established requirements.
4. Draft requirements without overwriting an existing requirements document unless updating or replacing it was
   requested. Clarify the output target when necessary.

Before reporting completion, verify compliance with the shared guidance and document format.
