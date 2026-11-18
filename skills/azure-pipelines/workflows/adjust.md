# Adjust

Align existing pipelines to the pipeline-templates standard.

1. **Scope.** All pipelines in `.azure/` (and other pipeline YAML found), or only those the user named.

2. **Map each pipeline.** Match every job and step to the template that should own it, and list deviations:
    - inline jobs/steps that a template covers;
    - deprecated templates (`quality/*`, `test/job-stm32-run-app.yml`, anything in `deprecated.md`);
    - `step-*` used where a `job-*` fits;
    - `resources.repositories` alias (`templates`), `ref`, and `pool`/demands (`TPLE`);
    - hard-coded docker images instead of `DOCKER_IMAGE_*` in `config.yml`;
    - conventions: file names, stage id/displayName, matrix keys, variable names, one empty line between steps, stage
      layout (one per platform, tests `dependsOn` build).

3. **Preserve behavior.** Keep builds, matrix entries, tests, artifact names consumed downstream, triggers, schedules,
   deploy gates and conditions, variable groups and secrets. Call out any unavoidable change. Ask before renaming or
   moving a pipeline file, since that breaks its Azure DevOps registration.

4. **Gaps.** When a template cannot express something, follow
   [../references/template-changes.md](../references/template-changes.md).

5. **Apply edits.** Check that every changed file parses as YAML and that required implicit variables are still set.
   Leave compliant pipelines untouched; repeating the workflow should produce no further edits.

6. **Report.** A per-pipeline before → after mapping, deviations left on purpose with reasons, and open questions.
