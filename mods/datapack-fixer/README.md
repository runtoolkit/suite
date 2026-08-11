# Datapack Fixer

A **Fabric 1.21.4 server-safe diagnostic mod** for datapack syntax migration. It deliberately does not rewrite pack files, intercept datapack loading, patch network packets, or change gameplay. It only reads unpacked datapacks when the integrated or dedicated server starts and emits diagnostics to the server log.

## Scope

Supported diagnostics are deliberately narrow and syntax-oriented:

- malformed JSON;
- unbalanced quote, SNBT, or item-component delimiters in `.mcfunction` files;
- legacy plural data directories introduced before 1.21;
- `minecraft:type_specific/slime`, renamed to `minecraft:type_specific/cube_mob` in 26.2;
- `minecraft:alternative`, renamed to `minecraft:any_of`;
- likely pre-1.21.2 recipe ingredient object syntax.

A diagnostic is a suggestion, not an automatic migration. The mod does not claim that a semantically different pack is safe after a textual replacement.

## Multiplayer safety

Install it on a dedicated server or an integrated server. Clients do not need it. It has no mixins, packets, commands, registries, file writes, reload hooks, or client-only entrypoints. Scanning occurs after server startup and is bounded to files smaller than 2 MB.

Only directory datapacks are inspected. ZIP datapacks are intentionally skipped to avoid archive extraction and mutation risks.

## Requirements

- Minecraft Java Edition 1.21.4
- Fabric Loader 0.19.3 or newer
- Fabric API 0.119.4+1.21.4
- Java 21

## Build and test

```sh
./gradlew build
./gradlew runClientGameTest
./gradlew runProductionClientGameTest
```

`build` runs JUnit plus Fabric server GameTests. The included GitHub Actions workflow is configured to run both Fabric server GameTests and production-client Fabric GameTests, then upload logs, reports, and client screenshots.

## Research basis

The migration rules are constrained to documented changes between the requested baseline and 26.2:

- 1.21 singularized most datapack directories; item stacks moved to components in 1.20.5/1.21-era data formats.
- 1.21.2 simplified recipe ingredient representations.
- 26.2 data pack format is 107.1 and renamed the slime type-specific entity sub-predicate to `cube_mob`.
- Modern `pack.mcmeta` formats use `min_format` and `max_format` ranges; this mod reports no automatic pack metadata conversion because changing a compatibility declaration is not a syntax-only repair.

Primary references:

- [Minecraft Java 26.2 release notes](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2)
- [26.2 Snapshot 4 datapack change](https://www.minecraft.net/en-us/article/minecraft-26-2-snapshot-4)
- [Minecraft Java 1.21.2 release notes](https://www.minecraft.net/en-us/article/minecraft-java-edition-1-21-2)
- [Fabric for Minecraft 26.2](https://fabricmc.net/2026/06/15/262.html)
- [Fabric automated testing documentation](https://docs.fabricmc.net/develop/automatic-testing)

## 26.2 migration policy

The source includes narrow 26.2 syntax diagnostics, notably the `minecraft:type_specific/slime` to `minecraft:type_specific/cube_mob` rename. The runnable artifact is pinned to 1.21.4 because the 26.2 official Minecraft mappings were not resolvable by Loom in this build environment. A future 26.2 release must update Minecraft, mappings, Fabric API, and test APIs together after official artifacts are available.

## Repairs and backups

Version 1.2.0 adds an operator-only repair command for directory datapacks:

```mcfunction
/datapackfixer scan
/datapackfixer fix
/reload
```

`fix` requires permission level 4. Before any change, it copies every directory datapack to `world/datapack_fixer_backups/<UTC timestamp>/` and writes an `audit.txt` report there. It never processes ZIP/JAR datapacks.

The current allowlist repairs only deterministic transformations: singular data directory names, the `minecraft:type_specific/slime` and `minecraft:alternative` renames, and a missing 1.21.4 `pack_format` in otherwise valid `pack.mcmeta`. Invalid JSON, ambiguous recipe conversions, legacy NBT/item-component rewrites, and gameplay-semantic migrations are reported but deliberately not guessed or rewritten.
