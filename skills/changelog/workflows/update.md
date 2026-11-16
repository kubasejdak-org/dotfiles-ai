# Update

1. **Target and ranges.** Target the explicitly requested changelog section, otherwise `Unreleased`. Create
   `## Unreleased` if missing. Use the user's explicit revision range. Default ranges, excluding prerelease/RC tags:
    - `Unreleased`: latest final release tag on `HEAD`'s ancestry → `HEAD`.
    - A released version: previous final release tag on that version's ancestry → that version's tag.

    A starting revision alone overrides the baseline, keeping the target endpoint above. When the starting revision is
    older than the sections present in the changelog, backfill a section for every final tag between it and `HEAD` (each
    with its own range), plus `Unreleased` for the changes after the latest tag; do not ask. The baseline tag itself
    gets no entries unless the changelog already has a section for it. Ask only if a required tag or baseline is missing
    or ambiguous. Compare the selected endpoints throughout the analysis.

    Decide which release a change belongs to with `git merge-base --is-ancestor <commit> <tag>`, never by commit date,
    merge order, or changelog dates (release branches may omit earlier-dated commits). Changes after the latest tag
    belong to `Unreleased`, which stays in the file even when empty.

2. **Own changes.** Inspect each relevant commit and diff, including merges as needed.

3. **Dependencies (mandatory).** At each range endpoint, read every version-pinned dependency (recipes `SRCREV` and
   `*.inc`, kas `commit`/`refspec`, submodules, manifests, lockfiles) with `git show <tag>:<path>` and compare.
    - Locate each dependency repository: sibling directories of the repository root, a search under the parent
      workspace, then `git ls-remote` and a clone into `/tmp`. Report a dependency as inaccessible only after all three
      failed.
    - For every changed pin, inspect the dependency's commits and diffs between the pinned revisions, and recurse into
      its own changed pins (for example layer → application → component library → FPGA). Report only effects used or
      exposed by this repository.
    - Delegate large ranges (more than about 30 commits) to parallel read-only subagents, one per dependency, giving
      them the tag-to-pin mapping and the range. Prefer the product-facing behavior over internal changes.
    - Dependency changelogs are hints, not proof. Verify against diffs. Binary artifacts that cannot be inspected
      (bitstreams, images): tie claims to the pinned source revision and state the uncertainty.
    - Dependencies pinned at a branch revision after the latest tag contribute to `Unreleased`.

4. **Net behavior.** Evaluate the net behavior at the range endpoints. Consolidate related commits, account for fixes
   and reversions, and exclude changes that did not survive or have no observable functional effect. Do not create one
   entry per commit. Take "before" values from the previous release state, not from assumptions. Drop fixes of things
   introduced in the same release.

5. **Reconcile all existing entries in the target section(s)** against the resulting behavior, not merely append:
    - Add missing functional changes.
    - Replace version-bump entries ("X is updated to Y", "dependency updated") for first-party dependencies with the
      behavior resolved from the dependency history; remove them only when that history shows no observable effect. Keep
      or add "X is updated from A to B" only for third-party dependencies.
    - Rewrite inaccurate, vague, or implementation-oriented descriptions; move entries that belong to another release.
    - Remove entries demonstrably absent from the target state, reversed, duplicated, or purely nonfunctional.
    - For borderline relevance, uncertain evidence, inaccessible dependencies, or entries that might describe work
      outside the chosen range, **ask before removing**; preserve them until resolved.

6. **Independent verification.** After editing, check every bullet of each touched section against diffs and pinned
   dependency history from scratch (use a fresh read-only subagent per release range when the changelog is large). Look
   for wrong, unsupported, misplaced, exaggerated, or invented statements (names, numbers, event IDs, defaults). Apply
   the corrections and repeat once if substantial corrections were made.

7. **Preserve** all other sections unless explicitly requested. Do not move entries into a version merely because a tag
   exists; release finalization requires an explicit request.

8. **Report** additions, rewrites, removals, every dependency comparison (range and status: inspected, partial,
   inaccessible), and remaining uncertainties.
