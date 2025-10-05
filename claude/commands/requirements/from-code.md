# Reverse-engineer Requirements from Existing Code

Use @requirements-specialist subagent to analyze code and create matching business-level requirements.

## Context

- Target code (file path, directory, or module name with optional description): $ARGUMENTS
- Requirements template: @shared/templates/requirements.md
- Output: `requirements.md`, unless explicitly asked to use another file

## Workflow

1. Parse initial description from user input
2. Analze referenced codebase, in particular:
   - Identify business functionality (not implementation details)
   - Extract user-facing features and capabilities
   - Identify constraints and non-functional aspects
   - Document technical dependencies
3. Generate requirements document following template
4. Present for user review and iterate if needed

## Guidelines

- Focus on business capabilities, not code structure
- Abstract away implementation details
- Identify implied requirements from code behavior
- Note assumptions made during analysis
- Flag areas where business intent is unclear from code alone
- Consider: What problem does this code solve for users?
