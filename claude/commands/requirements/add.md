# Add Requirements

Use @requirements-specialist subagent to create new requirements from the provided description.

## Context

- User input (project/feature description): $ARGUMENTS
- Requirements template: @shared/templates/requirements.md
- Target file: `requirements.md` (or existing project requirements file)

## Workflow

1. Parse initial description from user input
2. Analyze and identify gaps/ambiguities
3. Ask clarifying questions iteratively until you have:
   - Clear functional requirements
   - Relevant non-functional requirements
   - Technical constraints
4. Generate structured requirements document following template
5. Present for user review and iterate if needed

## Guidelines

- Consider all user personas and workflows
- Focus on business logic when creating functional requirements
- Do not include technical solutions in requirements unless explicitly asked
