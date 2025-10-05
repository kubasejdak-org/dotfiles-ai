# Improve Requirements

Analyze and improve existing requirements to ensure they meet quality standards: clear, specific, testable, and
unambiguous. Use @requirements-specialist subagent to enhance requirement quality.

## Context

- Target (file path, or specific requirement ID like "FR-3"): $ARGUMENTS
- Requirements template: @shared/templates/requirements.md
- Quality criteria: SMART requirements (Specific, Measurable, Achievable, Relevant, Testable)

## Workflow

1. Identify target requirements from provided target requirement
   - If file path: analyze all requirements in file
   - If requirement ID: focus on specific requirement(s)
2. Use @requirements-specialist to evaluate each requirement against quality standards
3. For each issue found:
   - Explain the problem (ambiguity, lack of specificity, etc.)
   - Propose improved version
   - Ask for user confirmation
4. Update requirements document with approved refinements
5. Provide summary of improvements made

## Guidelines

- Maintain original intent while improving clarity
- Make requirements more specific and testable
- Remove ambiguity and vague language
- Ensure consistency across related requirements
- Don't change scope - only improve articulation
- Highlight dependencies or conflicts between requirements
