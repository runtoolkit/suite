# dpgen

Config-driven Minecraft datapack generator for the CLI. Point it at a
YAML or JSON file describing your namespaces, functions, advancements,
recipes, loot tables, predicates, and item modifiers, and it builds a
ready-to-use datapack `.zip`.

Targets modern Minecraft (26.x, `min_format`/`max_format` pack.mcmeta).

## Why

Browser-based datapack generators are fine for a single namespace and
a couple of functions, but they don't validate anything, don't scale
past "one tick function, one load function," and produce a config you
can't check into version control. `dpgen` is built to be scripted,
diffed, and reused.

- **Config validation before build** — invalid namespace names,
  duplicate function paths, dangling predicate references, and
  inconsistent `min_format`/`max_format` ranges fail loudly at
  `validate`/`build` time instead of producing a broken pack.
- **Multiple namespaces, multiple tick/load functions** — no
  single-function ceiling; every `tick`/`load` function you declare
  gets merged into the right tag file.
- **Macro function support** — generates the `$(param)` skeleton for
  parameterized functions callable via `function ns:path with storage
  ...`.
- **Structured content generation** — advancements, shaped/shapeless
  recipes, chest/block/entity loot tables, predicates
  (`random_chance`, `entity_properties`, `match_tool`), and item
  modifiers (`set_count`, `enchant_randomly`, `set_name`), including
  gating a modifier behind a predicate via `predicate_ref`.
- **Plain files, plain diffs** — your datapack definition lives in one
  YAML file you can review in a pull request.

## Install

```bash
git clone https://github.com/<your-org>/dpgen.git
cd dpgen
npm install
```

Requires Node.js (no specific minimum enforced, developed against
current LTS).

## Usage

```bash
# Check a config without building anything
node bin/dpgen.js validate examples/example.yaml

# Build a datapack zip
node bin/dpgen.js build examples/example.yaml -o mypack.zip
```

## Config format

```yaml
pack:
  name: "test-pack"
  description: "description"
  min_format: 107            # optional, defaults to 107
  max_format: 107             # optional, defaults to 107
  dependencies:                 # optional, see "Dependencies" below
    - id: someothernamespace
      version: "1.0.0"
      required: true

namespaces:
  - id: testns
    functions:
      - path: main
        tick: true            # added to data/minecraft/tags/function/tick.json
        commands:
          - "say tick running"
      - path: init
        load: true             # added to load.json
      - path: greet
        macro: true             # generates a $(param) skeleton
    advancements:
      - path: root
        title: "Test Root"
        icon: "minecraft:stick"
        reward_function: "testns:init"
    recipes:
      - path: test_item
        type: shapeless          # or shaped (requires pattern + key)
        result: "minecraft:emerald"
        ingredients: ["minecraft:diamond"]
    loot_tables:
      - path: test_chest
        kind: chest               # block | chest | entity
        item: "minecraft:gold_ingot"
        count: 3
    predicates:
      - path: half_chance
        kind: random_chance        # random_chance | entity_properties | match_tool
        chance: 0.5
    item_modifiers:
      - path: bonus_count
        kind: set_count             # set_count | enchant_randomly | set_name
        count_min: 1
        count_max: 3
        predicate_ref: "testns:half_chance"   # optional condition gate
```

See [`examples/example.yaml`](examples/example.yaml) for a minimal
config and [`examples/example-v2.yaml`](examples/example-v2.yaml) for
one covering predicates, item modifiers, and dependencies together.

## Pack format

Since Minecraft snapshot 25w31a, `pack.mcmeta` declares a range via
`min_format` + `max_format` instead of the older `pack_format` +
`supported_formats` pair. Each field accepts either a plain integer
or a `[major, minor]` pair. This tool's schema rejects the legacy
fields outright rather than silently misinterpreting them — a config
still using `pack_format`/`supported_formats` fails validation with a
clear error.

Packs targeting versions before format 82 (pre-25w31a) are outside
this tool's scope, since that requires the legacy field to also be
present.

## Dependencies

Vanilla Minecraft has no real datapack dependency system —
`pack.mcmeta`'s `dependencies` field only affects resource pack
merging, and the datapack loader ignores it. When you declare
`pack.dependencies`, `dpgen` generates a scoreboard-based check
(`__dpgen_deps.mcfunction`, wired into `load`) that warns in chat if
a dependency's own pack hasn't marked itself as loaded under the same
`dpgen_loaded` convention.

This only detects other packs that participate in the same
convention — either built with `dpgen` themselves, or manually
setting `scoreboard players set <id> dpgen_loaded 1` in their own
load function. It cannot detect an unrelated datapack's presence;
treat it as a soft same-ecosystem check, not real dependency
resolution.

## Limits

- No resource pack (`assets/`) generation.
- No validation beyond JSON/config shape — a typo'd item ID or
  enchantment ID won't be caught, only structurally invalid config.
- No legacy `pack_format` support (see "Pack format" above).

## License

_Add a license before publishing — none is currently declared in
`package.json`._
