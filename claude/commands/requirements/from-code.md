# Reverse-Engineer Requirements From Existing Code

Analyze existing code to extract and document business-level requirements. Use @requirements-specialist subagent to
create requirements that describe WHAT the system does, not HOW it's implemented.

## Context

- Target code (file path, directory, or module name): $ARGUMENTS
- Requirements template: @shared/templates/requirements.md
- Output: `requirements.md` for the analyzed component

## Workflow

1. Analyze specified code/module from provided code reference
2. Use @requirements-specialist to:
   - Identify business functionality (not implementation details)
   - Extract user-facing features and capabilities
   - Identify constraints and non-functional aspects
   - Document technical dependencies
3. Generate requirements document at business level
4. Present findings and ask user to validate interpretation
5. Refine based on feedback

## Guidelines

- Focus on business capabilities, not code structure
- Abstract away implementation details
- Identify implied requirements from code behavior
- Note assumptions made during analysis
- Flag areas where business intent is unclear from code alone
- Consider: What problem does this code solve for users?
