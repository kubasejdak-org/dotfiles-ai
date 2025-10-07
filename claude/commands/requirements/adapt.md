# Adapt Existing Requirements

Use @requirements-specialist subagent to migrate an existing requirements document to the standardized template format.

## Context

- Input file (path to existing requirements file): $ARGUMENTS
- Requirements template: @shared/templates/requirements.md
- Output file: same as input file, unless explicitly asked to use a different one

## Workflow

1. Read the existing requirements file from provided path
2. Extract all requirements and categorize them (FR/NFR/TR)
3. Refactor requirements structure to match template (identify main requirement and its additional details/info - bullet
   points section)
4. Generate adapted document following predefined template

## Guidelines

- Preserve original intent and content
- Don't add or remove requirements - only restructure
- Flag ambiguous requirements for later refinement
- Suggest `/requirements:improve` if quality issues are detected
