# Adapt Existing Requirements

Transform an existing requirements document into the standardized template format. Use @requirements-specialist subagent
to preserve content while restructuring format.

## Context

- Input file (path to existing requirements file): $ARGUMENTS
- Requirements template: @shared/templates/requirements.md
- Output: Updated file or new `requirements.md`

## Workflow

1. Read the existing requirements file from provided path
2. Use @requirements-specialist to:
   - Extract all requirements and categorize them (FR/NFR/TR)
   - Map to template structure
   - Preserve requirement IDs if they exist, or create new ones
   - Maintain all essential content
3. Generate adapted document following template
4. Note any requirements that need clarification (don't modify them yet)
5. Present results and suggest running `requirements refine` if needed

## Guidelines

- Preserve original intent and content
- Don't add or remove requirements - only restructure
- Flag ambiguous requirements for later refinement
- Maintain traceability to original document
- If original uses different file name (e.g., prd.md), keep it unless user requests change
