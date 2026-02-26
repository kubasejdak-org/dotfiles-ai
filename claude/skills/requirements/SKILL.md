---
name: requirements
description: >
    Use this skill for any work involving software requirements or PRD files: creating, updating, improving, migrating
    to standard template, or reverse-engineering from code. Trigger on keywords like "requirements", "PRD", "specs",
    "functional requirements", "acceptance criteria", or "document this feature".
---

# Requirements Skill

A skill for creating, updating, improving, and reverse-engineering software requirements documents following a
standardized template format.

## Template Format

All requirements documents follow this structure (see full template in `references/template.md`):

```markdown
# _Project / Component Name_ – Requirements

## Overview

_Brief description of purpose, scope, and objectives._

## Functional Requirements

- [ ] **FR-1:** [Requirement description]
    - Additional details or sub-requirements as bullet points

## Non-Functional Requirements

- [ ] **NFR-1:** [Non-functional requirement]
    - Specific metrics or benchmarks

## Technical Constraints and Requirements

- [ ] **TR-1:** [Technical constraint or requirement]
    - Context or reasoning
```

**Key rules:**

- Requirement IDs use format `FR-N`, `NFR-N`, `TR-N` (incrementing integers)
- Each requirement is a checkbox `- [ ]`
- Sub-details are indented bullet points under the requirement
- File is named `requirements.md` (or `prd.md` if that already exists in the project)
- Multiple requirements files per project are fine (e.g., per component) — identify the right one

## Workflows

Choose the appropriate workflow based on the user's situation:

---

### A. Create New Requirements (from idea or description)

Use when: User has a vague idea, feature description, or verbal concept with no existing docs.

1. **Parse the initial description** — extract what you can about the goal, users, and scope
2. **Identify gaps** — list what's unclear: Who are the users? What are the boundaries? What does success look like?
3. **Ask clarifying questions iteratively** using the 5W1H framework:
    - **WHO**: Target users, personas, stakeholders
    - **WHAT**: Exact functionality, data handled, system behavior
    - **WHY**: Business value, problem being solved
    - **WHEN**: Timeline constraints, dependencies
    - **WHERE**: System boundaries, integration points, environments
    - **HOW**: Technical constraints, performance needs, existing systems
4. **Never settle for vague answers** — probe with: "Can you give a specific example?", "How would you measure that?",
   "What happens if we don't include this?"
5. **Draft the requirements document** following the template
6. **Present for review** and iterate until confirmed

**Important**: Focus on _what_ the system should do, not _how_ it does it. Avoid prescribing technical solutions unless
explicitly requested.

---

### B. Update or Refine Existing Requirements

Use when: User has an existing `requirements.md` or `prd.md` and wants to add, change, or expand it.

1. **Read the existing file** — understand current structure and requirement IDs
2. **Determine the scope of change**: adding new requirements, modifying existing ones, or both
3. **Assign correct IDs** — continue the existing numbering sequence (e.g., if FR-5 is last, next is FR-6)
4. **Ask clarifying questions** about any ambiguous additions
5. **Apply changes** and present a diff/summary of what changed
6. **Note**: If the file uses a non-standard format (e.g., `prd.md`), preserve the filename and adapt the structure — do
   not rename unless explicitly asked

---

### C. Adapt / Migrate to Standard Template

Use when: User has an existing requirements document in a non-standard format that needs restructuring.

1. **Read the source file** fully
2. **Extract and categorize** all requirements into FR / NFR / TR groups
3. **Identify the main requirement** vs. supporting details (details become indented sub-bullets)
4. **Reconstruct the document** following the template structure
5. **Preserve original intent** — do not add or remove requirements, only restructure
6. **Flag ambiguous items** and note them to the user
7. **Suggest running Workflow D** if quality issues are found during migration

---

### D. Improve Requirement Quality

Use when: User wants to improve clarity, specificity, or testability of existing requirements.

**Quality standards** — each requirement must be:

- **Specific and Clear**: Detailed enough for a developer to implement without asking questions
- **Achievable**: Technically and resource-wise feasible
- **Testable**: Can be validated through testing or review
- **Unambiguous**: Clear to both technical and non-technical stakeholders
- **Relevant**: Aligned with the project's business objectives

**Process:**

1. **Identify target**: Either a whole file or a specific requirement ID (e.g., `FR-3`)
2. **Evaluate each requirement** against the quality standards above
3. **For each issue found**:
    - Explain the specific problem (e.g., "This is vague — 'fast' is not measurable")
    - Propose an improved version
    - Ask for user confirmation before applying
4. **Consider structural changes**: Suggest splitting one requirement into multiple, or merging related ones, if it
   improves clarity
5. **Apply confirmed changes** and summarize improvements

---

### E. Reverse-Engineer from Code

Use when: User wants to generate requirements that reflect what existing code actually does.

1. **Analyze the codebase** — focus on:
    - User-facing functionality and behaviors
    - Inputs, outputs, and data flows
    - Error handling and edge cases
    - External dependencies and integration points
2. **Abstract away implementation** — requirements describe _what_ the system does, not _how_ it's coded
3. **Identify implied requirements** from code behavior (e.g., validation logic implies NFRs around data integrity)
4. **Note assumptions** where business intent is unclear from code alone
5. **Draft the requirements document** following the template
6. **Ask for confirmation** on inferred behaviors before finalizing

---

## Quality Checklist (apply to all workflows)

Before presenting a final document, verify:

- [ ] All requirement IDs are unique and sequential within each category
- [ ] No `{{PLACEHOLDER}}` text remains
- [ ] Each requirement is testable (can you write a test for it?)
- [ ] Functional, Non-Functional, and Technical sections are all present (or explicitly omitted with reason)
- [ ] No technical solutions prescribed in Functional Requirements (unless user asked)
- [ ] Sub-bullets add genuine detail, not just restatements

## Reference Files

- `references/template.md` — The full canonical requirements template to use as the base for all new documents
