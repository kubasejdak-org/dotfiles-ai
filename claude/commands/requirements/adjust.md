# Transform Text into Requirements Document

Use @requirements-specialist subagent to transform rough ideas, concepts, project descriptions, or existing requirements
documents into structured software requirements following @shared/templates/requirements.md format.

## Context

- User input: $ARGUMENTS
  - Eeither project/feature description text or file path to existing requirements
- Requirements file template: @shared/templates/requirements.md

## Task

1. Analyze the input and identify core functionality
2. Transform into structured requirements using predefined file template
   - *For file paths:* read and adapt the existing document to template format
   - *For text descriptions:* generate complete requirements document from scratch
