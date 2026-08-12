# Contributing to runtoolkit/suite

Thanks for your interest in contributing to this project.

**Read [NOTICE.md](NOTICE.md) before opening a PR.** It covers the
Gradle/datapack split in this monorepo (what's built by `buildAll` and what
isn't), what a PR should contain, and what will get a PR closed
(obfuscated code, undisclosed behavior, misuse of the macro/command
tooling for griefing or exploit purposes). This guide assumes you've
already read it.

## Getting started

1. Fork or clone the repository.
2. Create a branch for your change:

   ```bash
   git checkout -b your-branch-name
   ```

4. Make your changes.
5. Build and lint before opening a PR:
   ```bash
   ./gradlew buildAll
   ./gradlew lintAll
   ```

## Branch naming

No strict convention is enforced. Use a branch name that describes the change (e.g. `fix-gui-crash`, `add-slot-source-support`).

## Commit messages

Keep commit messages short and descriptive. Reference related issues or PRs where relevant.

## Pull requests

- Open a PR against the `main` branch.
- Make sure `Build all subprojects` and `Lint all subprojects` pass in CI before requesting review.
- Describe what changed and why in the PR description — and whether the change touches `mods/`, `packs/`, or both, since only the former is covered by `buildAll`.
- Run through the checklist at the bottom of [NOTICE.md](NOTICE.md) before requesting review.

## Security

This project follows a security-first development philosophy, particularly around Minecraft datapack macro injection risks and namespace isolation. If you find a security issue, avoid opening a public issue — contact a maintainer directly instead.

## Code style

- Java code should be clear and documented; complex logic should include comments explaining intent.
- Avoid introducing unnecessary dependencies.
- Fabric mod code must remain tick-safe (see project TPS guidelines).

## Questions

Open an issue if something in this guide is unclear or if you need help getting your environment set up.
