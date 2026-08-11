# Compatibility research: 1.21.4 through 26.2

This project intentionally limits itself to deterministic syntax diagnostics. It does not infer game intent, rewrite datapacks, or claim a semantic migration is safe.

## Reviewed changes

| Version range | Relevant change | Datapack Fixer policy |
|---|---|---|
| 1.21 | Most data directories became singular (`functions` → `function`, `loot_tables` → `loot_table`, and equivalent tag folders). | Report the legacy directory, never move it. A move changes pack contents on disk. |
| 1.21.2 | Recipe ingredient values were simplified: item values are ids, tag values are `#` ids. | Warn only when an old object-shaped ingredient is likely present. Schema context is incomplete without decoding every recipe type. |
| 1.21.4 baseline | Legacy packs commonly still contain pre-component item or directory syntax. | Do not bulk-convert NBT or item components. That is a semantic migration, not a syntax repair. |
| 1.21.9 onward | Pack metadata supports `min_format`/`max_format` ranges. | Do not alter `pack.mcmeta`: a compatibility declaration must be chosen by the pack author. |
| 26.2 | Datapack format is 107.1; `minecraft:type_specific/slime` was renamed to `minecraft:type_specific/cube_mob`. | Emit an exact, one-token replacement suggestion. |
| 26.2 | Fabric documentation specifies Loom 1.17, Gradle 9.5.1, Loader 0.19.3, and Java 25. | Pin those toolchain requirements in the build and CI workflow. |

## Primary sources

1. Minecraft Java 26.2 release notes: https://www.minecraft.net/en-us/article/minecraft-java-edition-26-2
2. Minecraft 26.2 Snapshot 4, including the `slime` → `cube_mob` rename: https://www.minecraft.net/en-us/article/minecraft-26-2-snapshot-4
3. Minecraft Java 1.21.2 release notes: https://www.minecraft.net/en-us/article/minecraft-java-edition-1-21-2
4. Fabric 26.2 porting post: https://fabricmc.net/2026/06/15/262.html
5. Fabric automated testing guide: https://docs.fabricmc.net/develop/automatic-testing
6. Fabric Loom Fabric API DSL: https://docs.fabricmc.net/develop/loom/fabric-api

## Safety decision

The scanner runs once at server start and only reads normal files in the world's `datapacks` directory. It skips archives and files larger than 2 MB. The mod has no mixins and does not register networking, commands, reload listeners, or data pack resources. It is therefore server-side optional for clients.

## Build availability constraint

The runnable test target is 1.21.4. The 26.2 migration rules remain documented and tested as scanner rules, but a runtime upgrade requires official 26.2 artifacts, mappings, and matching Fabric API modules. The earlier lock warning was incidental to an interrupted process and was resolved by Loom cache rebuild.
