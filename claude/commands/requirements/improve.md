# Improve Requirements

Use @requirements-specialist subagent to improve existing requirements for compliance with predefined quality standards
and document template format.

## Context

- Target (file path, or specific requirement ID like "FR-3"): $ARGUMENTS
- Requirements template: @shared/templates/requirements.md

## Workflow

1. Identify requirements to check from provided user input
   - If file path: analyze all requirements in file
   - If requirement ID: focus on specific requirement(s)
2. Evaluate each requirement against quality standards
3. For each issue found:
   - Explain the problem (ambiguity, lack of specificity, etc.)
   - Propose improved version
   - Ask for user confirmation
4. Update requirements document with approved refinements
5. Provide summary of improvements made

## Guidelines

- Maintain original intent while improving clarity
- Always explain to the user what is wrong with given requirement and how to address it
- Propose dividing or merging requirements if it makes sense in given case
- Propose adding or removing requirements if something needs clarification or if it does not add any value to the subject
