> **⚠️ ARCHIVED / MOVED**
>
> This repository (`runtoolkit/suite`) is **archived** and no longer maintained.
>
> All further development continues at:
> **https://github.com/vortacraftmc/core**
>
> Please open issues, PRs, and use the latest releases from the new repository.
> This repo is kept only as a historical snapshot.

# runtoolkit/suite (ARCHIVED)

Consolidated monorepo for the runtoolkit ecosystem. **This repository is archived.** Development continues at [vortacraftmc/core](https://github.com/vortacraftmc/core).

## Structure

- `mods/`      — Fabric mods
- `packs/`     — Datapacks / resource packs
- `scripts/`   — Helper scripts and tools
- `examples/`  — Templates, example Fabric mods, example datapacks, test files
- `archived/`  — Reserved for projects no longer developed but kept for reference (not currently populated — nothing has been moved here yet)
- `other/`     — Reserved for content that doesn't fit another category (not currently populated)

## Datapack maintenance status

Datapacks under `packs/` are now in maintenance mode. Concretely, that means:

- **In scope:** bug fixes, security hardening, compatibility fixes for new Minecraft versions (pack_format bumps, syntax migrations), and small quality-of-life updates to existing modules.
- **Out of scope:** new modules, new systems, or any feature work that expands what a pack does beyond its current functionality. If a change would require adding a new top-level system (comparable in scope to, say, the rate-limit or hidden-flag modules already in `macroEngine`), it does not belong here.
- **Rationale:** datapacks in this repo (particularly `macroEngine`) have grown large enough that further feature growth trades off against maintainability — see the "hard to scale" point in the FAQ below. Fabric mods under `mods/` remain the intended path for new functionality going forward.

This status applies to `packs/` only; it does not affect `mods/`, `scripts/`, or any other top-level directory.

## Fabric vs. datapacks — FAQ

This repo hosts both Fabric mods (`mods/`) and datapacks (`packs/`). To clear up some misconceptions that circulate between the two:

**"Fabric is a system hackers use" — False.**
Fabric is a standard Minecraft mod loader, in the same category as Forge, NeoForge, and Quilt. It is a loading/injection mechanism, not a piece of software with intent. Thousands of legitimate performance mods (e.g. rendering optimizations), content mods, and server-side utility mods run on Fabric with no connection to cheating. It is true that some cheat clients are built on top of Fabric or Forge, because a mod loader is the mechanism any client-side code — legitimate or not — needs to hook into the game. That does not implicate the loader itself, any more than a knife is "a tool criminals use" because some crimes involve knives. The tool is neutral; what varies is the intent and content of what's built on it. Judge a specific mod by its source and behavior, not by which loader it targets.

**"Datapacks are safe, mods are unsafe" — A false framing.**
There is one real, verifiable technical difference here: datapacks cannot execute arbitrary Java bytecode. They are declarative data (JSON) plus a constrained command language (`mcfunction`), interpreted entirely inside the vanilla server's existing command engine. Mods, by contrast, are compiled Java that runs with the same privileges as the server process itself. That is a genuine difference in attack-surface *shape* — a datapack cannot open a socket, read arbitrary files from disk, or call into the JVM's reflection API, while a mod technically can.

That difference does not translate into "datapacks are safe":
- A datapack can still degrade or crash a server through purely in-game mechanisms: unbounded `function` recursion (stack overflow), runaway entity/marker spawning via `test_block` or summon loops, or unbounded growth of `data storage` (all things this repo's own cleanup work, see `macroEngine`'s `_item_tmp`/`rl_work` scratch-storage fixes, exists specifically to prevent).
- A datapack can corrupt gameplay state (scoreboards, NBT, player data) just as easily as a poorly written mod can, since both ultimately mutate the same world data.
- "Cannot run arbitrary Java" is a ceiling on *what kind* of damage is possible, not a guarantee that no damage is possible.

Nor does it follow that mods are inherently unsafe. A mod's risk is a function of its source, not its mechanism:
- An unsigned mod from an unknown, unmoderated site is high-risk — same as running any unreviewed compiled binary from an untrusted source, regardless of it being for Minecraft.
- A mod distributed through CurseForge or Modrinth, especially one with meaningful download counts, community scrutiny, and a maintained changelog, has had far more independent eyes on it than the average privately-shared datapack ever will.
- Datapacks are not immune to malicious intent either — a `.zip` full of `mcfunction` files can just as easily be shared with obfuscated or hidden destructive logic, and most players have no more ability to audit raw `mcfunction` than they do decompiled Java.

The accurate statement is: datapacks have a narrower *technical ceiling* for what damage is possible, but actual safety in both cases depends overwhelmingly on the trustworthiness of the source, not the format.

**"Mods are hard, datapacks are easy" — Partly true, overstated.**
This one has real substance, more than the other two, but the word "easy" hides an important asymmetry between getting started and building something substantial.

Where it's true:
- Datapacks require no programming language, no build toolchain, and no IDE — a text editor and a `.zip` (or a folder, post-1.20-something) is enough to start.
- The feedback loop is immediate: edit a file, run `/reload`, see the result. There is no compile step.
- JSON and `mcfunction` syntax errors are usually easy to spot and fix even for a non-programmer, since the language surface is small.
- Fabric mod development has a real, non-optional barrier to entry: Java as a language, Gradle/Loom as a build system, Mixins for injecting into vanilla code, and a mental model of the client/server split, event lifecycle, and registries. None of that is optional even for a "simple" mod.

Where "easy" breaks down:
- `mcfunction` is not Turing-complete in the way a general-purpose language is — there are no first-class functions, no real data structures beyond NBT compounds/lists, and control flow is built entirely out of `execute if`/`execute unless` chains and recursive `function` calls. Any logic beyond "if X then do Y" starts fighting the language rather than being expressed naturally in it.
- The practical result, visible in this repo's own `macroEngine` datapack: features that would be a few dozen lines of Java in a mod (a sliding-window rate limiter, a per-item cooldown system, a scratch-storage cleanup routine) become hundreds of lines of `mcfunction` spread across many small files, because every intermediate value needs its own storage path or scoreboard, and every branch needs its own file or `execute` chain.
- Debugging is harder in the opposite direction from writing: a stack trace in a mod tells you exactly which line failed and why; a silently-failing `execute` chain in a datapack just does nothing, with no error message pointing at the cause.
- State management (the exact class of bug this repo's cleanup work — `_item_tmp`, `rl_work`, the removed `test_block` logging system — was fixing) is manual and easy to get wrong in `mcfunction`, whereas a mod's local variables are scoped and garbage-collected automatically by the JVM.

The more accurate framing: datapacks are easier to **start** and easier to **read** at small scale, but harder to **scale** and harder to **maintain correctly** as logic grows, because the language was designed for straightforward data-driven content, not for general-purpose programming. Mods have a much higher entry cost but scale far better once you're past it. Neither format is unconditionally "easier" — it depends on what you're building and how big it's going to get.

---

## Note: Moved from Datapacks to Fabric

This project no longer ships or accepts vanilla datapacks (`.json` / `.mcfunction`
files loaded via `/reload` or `world/datapacks/`). Development has moved to
**Fabric mods** (Java, built with Gradle).

### Why

- Datapacks run inside the vanilla command system and cannot execute native
  code or access the filesystem/network directly — but they *can* still cause
  real problems: server/client lag from unbounded loops (`execute ... run
  function`, large `/fill`/`/clone` regions), world/data corruption via
  `data merge`, or griefing via entity/inventory manipulation. These are hard
  to review at scale and easy to hide inside large command trees.
- Fabric gives us compiled, versioned, statically checkable code, proper
  dependency management, and CI tooling (tests, static analysis, dependency
  scanning) that datapacks don't support.

### What this means for contributors

- New features should be implemented as a Fabric mod under `src/`.
- Datapacks are no longer accepted as pull requests. If you have an existing
  datapack you'd like ported, open an issue and we can help convert the
  logic to a Fabric mixin/command.
- See `gradle-tasks/verifyMod.gradle` for the checks that run in CI, and
  `scripts/datapack_risk_scan.py` if you still need to audit a legacy
  datapack before removing it.

---

## Building

This repo uses Gradle to build all Fabric mod subprojects.

### Requirements

- JDK 25
- Gradle Wrapper (included, no separate Gradle install needed)

### Build all subprojects

```bash
./gradlew buildAll
```

This runs the build task across every subproject under `mods/` and produces mod JARs. Output JARs land in each subproject's `build/libs/` directory.

### Lint all subprojects

```bash
./gradlew lint
```

### Build a single subproject

```bash
./gradlew :mods:<subproject-name>:build
```

### CI

Pushes and pull requests trigger the `build.yml` workflow (Build & Lint), which runs `buildAll` and `lint` across all subprojects and uploads build artifacts. See `.github/workflows/build.yml` for the full pipeline, including the release-publishing job.

## Old repos

The following repos were moved into this monorepo and are now **private**:

- [TunnelScript](https://github.com/runtoolkit/TunnelScript)
- [LeftClickDetection](https://github.com/runtoolkit/LeftClickDetection)
- [dp-depman](https://github.com/runtoolkit/dp-depman)
- [RTWrapper](https://github.com/runtoolkit/RTWrapper)
- [datapack-fixer](https://github.com/runtoolkit/datapack-fixer)
- [itemExampleMod](https://github.com/runtoolkit/itemExampleMod)
- [template-datapack](https://github.com/runtoolkit/template-datapack)
- [InteractionClickDetection](https://github.com/runtoolkit/InteractionClickDetection)
- [cmdTunnel-datapack](https://github.com/runtoolkit/cmdTunnel-datapack)
- [dpgen](https://github.com/runtoolkit/dpgen)
- [TEMPLATE-MOD](https://github.com/runtoolkit/TEMPLATE-MOD)
- [inv_gui](https://github.com/runtoolkit/inv_gui)
- [macroEngine](https://github.com/runtoolkit/macroEngine)
- [guigen](https://github.com/runtoolkit/guigen)

## Skipped repos (empty or inconsistent)

- FunctionPP: only 2 file(s)
- DataLibFabric: 1KB, empty/placeholder (manually confirmed)
- .github: only 2 file(s)
