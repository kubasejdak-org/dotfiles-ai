---
name: requirements
description: >
    Create, update, improve, or restructure software requirements and PRD documents, or derive requirements from
    existing code. Use when the user requests requirements documentation work, rather than implementation of a feature.
---

# Requirements

Maintain software requirements that describe observable capabilities and constraints using a consistent template.

## Choose the Workflow

Use the action requested in the prompt to select a workflow. No command syntax or special argument separators are
required. A prompt can include a document path, a code path, requirement IDs, and the requested changes.

- **Create**: Write new requirements from an idea or description.
- **Update**: Add, modify, or remove requirements in an existing document.
- **Adapt**: Restructure an existing document into the standard template without changing its meaning.
- **Improve**: Review or improve clarity, specificity, and testability.
- **From code**: Derive requirements from observed code behavior.

Combine workflows only when the request calls for it. If the intended action or target cannot be determined from the
prompt and project context, ask a focused question.

Apply clearly requested edits directly and summarize the changes. For review-only requests, report findings and proposed
wording without editing files. Ask about material ambiguities before making dependent changes; do not invent business
decisions or measurable targets to fill gaps.

## Shared Document Rules

Read [references/template.md](references/template.md) before creating or restructuring a document.

- Use `requirements.md` for a new document. Preserve an existing filename, including `prd.md`, unless asked to rename
  it.
- Projects may have multiple requirements files; identify the relevant component or document before editing.
- Include Overview, Functional Requirements, Non-Functional Requirements, and Technical Constraints and Requirements.
  Omit an irrelevant section only with an explanation.
- Use flat IDs (`FR-N`, `NFR-N`, `TR-N`) for simple single-component documents. Use grouped IDs (`N.M`) when distinct
  components or categories benefit from grouping. Preserve the existing format for ordinary updates.
- In grouped documents, numbered H3 groups restart at 1 within each H2 section. IDs are unique within a section;
  identify a requirement by section and ID when a bare ID is ambiguous.
- Use checkbox requirements with indented supporting details. Preserve existing completion states and IDs during
  ordinary edits; append new IDs using the next number in the relevant category or group.

Requirements describe **what** the system does from the user's perspective, not **how** its code implements it. Class,
function, method, variable, type, constant, and internal file names are red flags: translate them into observable
behavior. Record mandated technical constraints in the technical section; do not invent implementation choices.

- Bad: "The ConfigParser::load() method must accept a file path parameter."
- Good: "The system must load its configuration from a file path supplied at startup."

## Workflows

### Create

Example: "Create requirements for a CLI tool that syncs local folders to S3."

1. Extract the goal, target users, scope, and success criteria from the description and available project context.
2. Clarify material gaps iteratively: who uses it, what behavior they need, why, relevant timing constraints, system
   boundaries and integrations, and mandated technical or performance constraints.
3. Probe vague answers with concrete examples and observable acceptance criteria until the requested scope is clear.
4. Write the document using the appropriate template format, then summarize it for review and further refinement.

If no idea is supplied, begin discovery with the user before drafting.

### Update

Examples:

- "Add rate limiting and API key authentication to requirements.md."
- "Update FR-4 in docs/prd.md to cover CSV export as well as JSON."

1. Read the existing document and understand the requested change and affected requirements.
2. Clarify ambiguous additions or references. For grouped IDs, use the section name to disambiguate the target.
3. Apply the requested additions, modifications, or removals. Continue existing ID sequences for new requirements; add
   new groups using the next group number in their section.
4. Check changed requirements for clarity and implementation details. Keep unrelated cleanup outside the edit scope and
   report any relevant issues separately.
5. Summarize what changed.

### Adapt

Example: "Adapt docs/old-requirements.txt to the standard requirements template."

1. Read the complete source and categorize its requirements as functional, non-functional, or technical.
2. Separate each main requirement from supporting details, which become indented bullets.
3. Restructure using the template while preserving intent, coverage, and completion states. Preserve the filename.
4. Flag ambiguous items rather than silently adding or removing requirements. Report ID changes when restructuring
   requires them.
5. Report quality issues separately; improve wording beyond restructuring only when requested.

### Improve

Examples:

- "Review requirements.md for clarity and testability."
- "Improve FR-3, FR-7, and NFR-1 in requirements.md."
- "Improve Functional Requirements 1.2 in docs/prd.md."

1. Read the document and identify the whole-file or requirement-specific scope.
2. Evaluate requirements for specificity, feasibility, testability, unambiguous meaning, and business relevance.
3. Explain concrete issues and formulate clearer wording. Ask for missing behavior or measurable targets when needed.
4. Split or merge requirements when requested improvements require it, and explain any resulting ID changes.
5. Apply requested improvements directly. For a review, present findings and suggested revisions without editing.

### From Code

Example: "Generate requirements from src/auth/, which handles authentication and roles."

1. Analyze the requested code scope: user-facing behavior, inputs and outputs, data flows, validation, errors, edge
   cases, and external integrations. If no path is supplied, inspect the project context and clarify scope if needed.
2. Translate implementation into observable capabilities and constraints. Ask of each code artifact: "What behavior does
   this enable?" Write that behavior instead of the artifact's name.
3. Separate observed behavior from inferred business intent. Note assumptions and ask about material inferences; do not
   present unsupported behavior or performance guarantees as established requirements.
4. Write the document using the template. Preserve an existing requirements document unless the user requests updating
   or replacing it; clarify the output target if it would otherwise be overwritten.
5. Summarize coverage and any unresolved assumptions for review.

## Quality Check

Before reporting completion, check that:

- Requirements are specific, achievable, relevant, unambiguous, and testable.
- IDs are unique within their category or section, and new numbering follows the existing sequence.
- Group headings and IDs follow the chosen format; existing IDs and completion states are preserved where applicable.
- Required sections are present or their omission is explained; template placeholders are replaced.
- Supporting bullets add useful details, and requirements describe behavior rather than code internals.
- Changes match the requested scope, and unresolved assumptions are clearly reported.
