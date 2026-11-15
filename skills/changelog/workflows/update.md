# Update

1. Target the explicitly requested changelog section, otherwise `Unreleased`. Use the user's explicit revision range.
   Default ranges, excluding prerelease/RC tags:
    - `Unreleased`: latest final release tag on `HEAD`'s ancestry → `HEAD`.
    - A released version: previous final release tag on that version's ancestry → that version's tag.

    A starting revision alone overrides the baseline, keeping the target endpoint above. Ask if a required tag or
    baseline is missing or ambiguous. Compare the selected endpoints throughout the analysis.

2. Inspect each relevant commit and diff, including merges as needed. Identify pinned dependency revisions (submodules,
   manifests, recipes, configuration, etc.); for each changed revision, inspect the dependency's corresponding Git
   history and code diff. Follow relevant transitive dependencies when accessible. Dependency changelogs are hints, not
   proof; report only effects used or exposed by this repository. Report dependency comparisons that could not be
   inspected and the resulting uncertainty; do not invent results or discard existing entries merely because they could
   not be verified.
3. Evaluate the net behavior at the range endpoints. Consolidate related commits, account for fixes and reversions, and
   exclude changes that did not survive or have no observable functional effect. Do not create one entry per commit.
4. Reconcile **all existing entries in the target section** against the resulting behavior, not merely append:
    - Add missing functional changes.
    - Rewrite inaccurate, vague, or implementation-oriented descriptions.
    - Remove entries demonstrably absent from the target state, reversed, duplicated, or purely nonfunctional.
    - For borderline relevance, uncertain evidence, inaccessible dependencies, or entries that might describe work
      outside the chosen range, **ask before removing**; preserve them until resolved.
5. Preserve all other sections unless explicitly requested. Do not move entries into a version merely because a tag
   exists; release finalization requires an explicit request.
6. Report additions, rewrites, removals, and any uncertainties.
