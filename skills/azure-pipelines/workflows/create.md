# Create

Create a new pipeline based on the pipeline-templates standard.

1. **Clarify the goal.** Concern (build, test, coverage, static analysis, docs, docker, yocto, conan), target platforms
   and triggers. Derive from the repository; ask only about material ambiguities.

2. **Pick templates.** Use `getting-started.md` ("Choosing a template") and the domain pages. Prefer `job-*`. Start from
   the closest `docs/examples/*.yml`.

3. **Write `.azure/<name>.yml`.**
    - File name `lower-case-with-dashes.yml`, as few words as possible.
    - Include `config.yml`; add missing `DOCKER_IMAGE_*` variables there instead of hard-coding images.
    - Declare the `templates` repository resource (`ci-tools` only when a template requires it) and the `TPLE` pool with
      demands.
    - One stage per target platform (`displayName: build x64`, `stage: build_x64`); test stages `dependsOn` the build.
    - Add `trigger`/`pr`/schedules only when the docs say so for this kind of pipeline.
    - Follow the remaining style conventions of `contributing.md`.

4. **Gaps.** When no template fits, follow [../references/template-changes.md](../references/template-changes.md).

5. **Validate.** Check that the YAML parses and every implicit variable required by the used templates is defined.

6. **Report.** Templates used and why, then remind the user to register the pipeline in Azure DevOps and set up any
   variable groups or secure files from `infrastructure.md`.
