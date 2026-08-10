## Summary

<!-- What changed and why. If this is a dependency update, link the source issue. -->

## Type of change

- [ ] Dependency update (lock file only)
- [ ] Resolver / script change (`scripts/`)
- [ ] Workflow change (`.github/workflows/`)
- [ ] Example pack / docs
- [ ] Other

## Lock file diff

<!-- Paste `diff datapack_depends.lock.old datapack_depends.lock` output here.
     Leave blank if datapack_depends.lock is unchanged. -->

```diff

```

## Checklist

- [ ] `python scripts/dp-resolve.py check` passes locally
- [ ] `python scripts/dp-resolve.py build --mode prod --output both` succeeds locally
- [ ] If `source: submodule` deps changed, `git submodule update --remote` was run and committed
- [ ] No manual edits to `datapack_depends.lock` (must come from `resolve`)
- [ ] Version bump in `datapack_depends.json` follows semver if this changes a public dependency contract

## Risk / rollback

<!-- What breaks if this is wrong, and how to revert (e.g. "revert this PR, re-run dep-update"). -->
