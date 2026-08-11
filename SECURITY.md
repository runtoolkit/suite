# Security Policy

## Reporting a vulnerability

If you find a security issue in any project under this repository (Fabric
mods, datapacks, or helper scripts), please report it privately rather than
opening a public issue.

- Preferred: use [GitHub's private vulnerability reporting](https://github.com/runtoolkit/suite/security/advisories/new)
  for this repo.
- If that's not available to you, open an issue with minimal detail
  (e.g. "possible command injection in X, details sent privately") and we'll
  follow up for the specifics.

Please include:
- Affected project/path (e.g. `packs/RTWrapper`, `mods/...`)
- Steps to reproduce, or a minimal example
- Impact (what an attacker could actually do)
- Minecraft/Fabric/Loom version, if relevant

We'll acknowledge reports as soon as we can and aim to have a fix or
mitigation out within a reasonable timeframe depending on severity. Low-risk
findings in archived/frozen projects (see below) may not get a fix, but will
be documented.

## Scope

This repo consolidates multiple projects with different security postures:

| Area | Status |
|---|---|
| `mods/` | Actively maintained Fabric mods. Compiled, type-safe. |
| `packs/` | Datapacks. Some actively maintained, some archived and frozen (see below). |
| `scripts/` | Helper tooling. Treat as lower trust; review before running. |
| `examples/` | Templates and sample code. Not intended for production use. |
| `archived/` | No longer maintained. Kept for reference only — do not deploy on a live server without review. |

Datapacks and Fabric mods carry different security postures by nature; where
practical, security-sensitive logic lives in a Fabric mod rather than a
datapack. Projects that have stopped receiving updates are frozen and marked
archived rather than left in an inconsistent, partially-hardened state.

## Supported versions

Only the versions/branches actively referenced in each subproject's own
README receive security fixes. Archived projects (see table above) are
provided as-is.

## Third-party forks and converters

If you're using a fork, a "datapack to mod converter" output, or any
derivative of a project in this repo, verify it against the original source
here before trusting it — converted or forked artifacts are not covered by
this policy and may not reflect the same security posture.
