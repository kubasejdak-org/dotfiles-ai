# Requirements Template Instructions

## Overview

This document provides instructions for using the requirements.md template. **Remove this entire instructions file from your final project documentation.**

## Usage Instructions

### For AI Agents

1. Replace all `{{PLACEHOLDER}}` values with project-specific information
2. Each requirement should be specific, measurable, and testable
3. Focus on clear, actionable descriptions in bullet points
4. Ensure requirements are atomic and well-defined
5. **Expand bullet points as needed**: Each `{{*_DESCRIPTION}}` placeholder can become multiple bullet points or include sub-points
6. **Omit irrelevant sections**: Not all bullet point types are required for every requirement - include only what's relevant

### For Human Users

1. Start by filling in the project name and description
2. Organize requirements by logical domains/modules
3. Use the hierarchical numbering system consistently
4. Each requirement should follow the SMART criteria (Specific, Measurable, Achievable, Relevant, Time-bound)
5. Focus on clear, concise descriptions that avoid ambiguity
6. **Flexible structure**: Break down placeholder bullet points into multiple items or sub-bullets as needed
7. **Skip unnecessary sections**: Only include bullet point types that add value to the specific requirement

## Domain Organization Guidelines

- **Functional Requirements**: Group by feature areas, user workflows, or business domains
- **Non-Functional Requirements**: Group by quality attributes (Performance, Security, Usability, etc.)
- **Technical Requirements**: Group by architectural layers or technology components

## Requirement Quality Checklist

- [ ] Each requirement has a unique ID
- [ ] Description is clear and unambiguous
- [ ] Requirements are specific and measurable
- [ ] Requirement is atomic (single responsibility)
- [ ] Language is concise and avoids jargon

## Examples of Well-Written Requirements

### Functional Requirement Example

#### FR-001 User Authentication

- [ ] The system shall allow users to log in using email and password
- [ ] Login attempts shall be limited to 3 failures before account lockout
  - Account lockout shall last for 15 minutes
  - Users shall be notified of remaining attempts
- [ ] Password requirements: minimum 8 characters, mixed case, numbers

### Non-Functional Requirement Example

#### NFR-001 Response Time Performance

- [ ] API endpoints shall respond within 200ms for 95% of requests
- [ ] Page load time shall not exceed 2 seconds on 3G connections
- [ ] System shall support 1000 concurrent users

### Technical Requirement Example

#### TR-001 Database Technology

- [ ] System shall use PostgreSQL 14+ as the primary database
- [ ] Database connections shall use connection pooling
- [ ] All database queries shall use parameterized statements

## Template Placeholders to Replace

- `{{PROJECT_NAME}}`: Replace with your project name
- `{{PROJECT_DESCRIPTION}}`: Replace with brief project description
- `{{DOMAIN_NAME_*}}`: Replace with specific domain/module names
- `{{REQUIREMENT_NAME}}`: Replace with descriptive requirement names
- `{{*_DESCRIPTION}}` placeholders: Can be expanded into multiple bullet points, sub-bullets, or omitted if not relevant
- **Flexible usage**: Not every requirement needs all bullet point types - use only what's meaningful for that specific requirement

## Final Document Preparation

1. Remove this entire instructions file
2. Replace all placeholders with actual content
3. Ensure all requirement IDs are unique and sequential
4. Review for completeness and clarity
