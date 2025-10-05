# Add Requirements

Guide the user through creating structured software requirements from a rough concept or description. Use the
@requirements-specialist subagent to iteratively refine requirements until they meet professional standards.

## Context

- User input (project/feature description): $ARGUMENTS
- Requirements template: @shared/templates/requirements.md
- Target file: `requirements.md` (or existing project requirements file)

## Workflow

1. Parse initial description from user input
2. Use @requirements-specialist to analyze and identify gaps/ambiguities
3. Ask clarifying questions iteratively until you have:
   - Clear functional requirements
   - Relevant non-functional requirements
   - Technical constraints
4. Generate structured requirements document following template
5. Present for user review and iterate if needed

## Guidelines

- Probe for edge cases and hidden requirements
- Consider all user personas and workflows
- Ensure each requirement is testable and specific
- Don't assume - ask when unclear
- Stop iterating when all requirements meet quality standards
