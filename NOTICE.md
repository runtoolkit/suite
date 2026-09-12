# NOTICE

Read this before opening a pull request. It explains the mixed Gradle/
datapack layout of this monorepo and sets expectations for what a PR
should — and should not — contain.

## Repo layout, in short

This is a **monorepo**, not a single Gradle project with some extra files
next to it:

- `mods/` — Fabric mods. Each subproject is built and linted through the
  root Gradle build (`./gradlew buildAll` / `./gradlew lint`). Changes
  here must build cleanly across **all** subprojects, not just the one you
  touched — a shared dependency bump or API change can silently break a
  sibling mod.
- `packs/` — Datapacks. These are **not** part of the Gradle build. There is
  nothing to compile; validity is checked by loading the pack (or by the
  linting/validation tooling referenced in `SECURITY.md`), not by
  `buildAll`. Don't assume a green Gradle run says anything about a
  datapack change.
- `scripts/` — Helper tooling, lower trust by default. Review before
  running locally.
- `examples/` — Templates and sample code. Not shipped, not covered by the
  same security posture as `mods/` or `packs/`.
- `archived/` — Frozen, reference only.

If your change spans both a mod and a pack (e.g. a Fabric mod that reads
data from a companion datapack), say so explicitly in the PR description —
this is the case most likely to be missed by CI, since `buildAll` only
covers the Gradle side.

## Gradle specifics

- JDK 25, wrapper included — don't add a second build system or bypass the
  wrapper.
- `./gradlew buildAll` and `./gradlew lint` must both pass before you
  request review; CI enforces this on every push and PR (see
  `.github/workflows/build.yml`).
- Building a single subproject during iteration is fine
  (`./gradlew :mods:<subproject-name>:build`), but run the full `buildAll`
  before opening the PR — cross-subproject breakage is the most common
  thing missed by scoped builds.
- Avoid adding dependencies unless necessary; every added dependency is
  shared build surface for the whole monorepo, not just your subproject.

## Datapacks specifics

- Datapacks in `packs/` follow the pack-format and namespace conventions
  documented per-project — check the subproject's own README before
  assuming a version target.
- Namespace isolation matters: don't introduce function/tag names that can
  collide with another pack in this repo or with common third-party packs.
- Macro-heavy or command-generation logic is a known risk area in this
  project (see `SECURITY.md`). If your change touches macro expansion,
  dynamic function generation, or anything that assembles commands from
  external input, call that out explicitly in the PR — it will get closer
  review than an average change.
- Some packs under `packs/` are archived/frozen (see `SECURITY.md`'s scope
  table). Don't submit feature PRs against frozen packs; fixes only, and
  only if the issue is significant.

## Do not misuse this project

This notice exists because of the nature of what's in this repo — datapack
macro systems, command-generation tooling, and Fabric mods that can touch
server/client behavior. To be explicit:

- Do not use anything in this repository to build griefing tools, cheat
  clients/mods, exploit kits, or anything designed to bypass another
  server's protections without authorization.
- Do not submit PRs that add obfuscated code, hidden network calls,
  backdoors, or any behavior not clearly described in the PR itself. A PR
  whose behavior doesn't match its description will be closed without
  further discussion, regardless of technical quality.
- Do not use this repo's macro/command-generation systems to build tooling
  intended to inject unsafe or attacker-controlled input into commands on
  a target server.
- Security-relevant contributions (anything touching namespace isolation,
  macro injection surfaces, or permission handling) should follow the
  private reporting process in `SECURITY.md` for the underlying issue
  first — don't post a working exploit in a public PR description.

Violation of the above is grounds for the PR being closed and, for repeat
or clearly malicious cases, the contributor being blocked from the repo.

## Before opening a PR

- [ ] `./gradlew buildAll` passes
- [ ] `./gradlew lint` passes
- [ ] If you touched `packs/`, you've validated the pack loads correctly
      (Gradle passing does not cover this)
- [ ] PR description explains **what** changed and **why**, and says
      whether the change touches mods, packs, or both
- [ ] No unexplained dependencies, obfuscation, or behavior not covered by
      the description
