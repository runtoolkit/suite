# guigen — Web Tool

Browser port of [runtoolkit/guigenmc](https://github.com/runtoolkit/guigenmc):
JSON → Minecraft inventory GUI datapack, generated entirely client-side.

Single self-contained HTML file. No server, no build step, no install.
Open it in a browser, paste or upload a config, click Generate, download
the `.zip`.

## Use

1. Open `guigen_web_tool.html`.
2. Load a config — either the built-in sample or your own `.json` file
   (**Load JSON**).
3. Edit the config in the left pane if needed.
4. Click **Generate** (or press `Ctrl/Cmd+Enter` in the editor).
5. Browse the output tree on the right, click any file to preview it.
6. Click **Download .zip** to save the datapack.

## What this is

The JSON schema, widget model, and every `.mcfunction`/`.json` file this
tool emits are a line-for-line JavaScript port of the original Python
generator (`models/`, `builders/`, `generators/`). Given the same config,
this tool and `python3 generate.py` produce byte-identical output (the
only difference is a cosmetic Unicode escaping choice in `pack.mcmeta`'s
`description` field — `\u2013` vs. the literal `–` character — which
Minecraft reads identically either way).

No config or generated file ever leaves the browser. Generation, preview,
and zipping all happen locally; the only network request is loading the
JSZip library from a CDN.

## Datapack layout

Same as the original generator:

```
data/<namespace>/function/
  core/load.mcfunction
  core/tick.mcfunction
  menu/<menu_id>/
    open.mcfunction
    close.mcfunction
    fill.mcfunction
    give_opener.mcfunction
    page/0.mcfunction …
    click/<action_id>.mcfunction …
data/minecraft/tags/function/{load,tick}.json
pack.mcmeta
```

## JSON config

Same schema as the original tool. Top-level fields: `namespace`,
`menu_id`, `display_name`, `timer_ticks`, `follow`, `distance_close`,
`container`, `extra_scores`, `pack_description`, `opener_name`,
`opener_lore`, `pages`.

Widget fields: `kind`, `slot`, `item`, `action_id`, `name`, `lore`,
`commands`, `functions`, `sound`, `condition`, `cooldown_ticks`, `cost`.

Widget kinds: `button`, `label`, `separator`, `toggle`, `counter`,
`nav`, `progress`, `close`, `confirm` (aliases: `btn`, `sep`/`filler`/
`pad`, `close_btn`, `navigation`/`page`, `bar`, `stepper`).

### cooldown_ticks
Blocks re-click for N ticks (`return` + scoreboard guard in the handler).

### cost
```json
"cost": {
  "item": "minecraft:coal",
  "count": 3,
  "score": "money",
  "amount": 10,
  "fail_message": { "text": "Not enough!", "color": "red" }
}
```
Item and/or score price, deducted only on a successful click.

### condition
```json
"condition": {
  "type": "item_count_lt",
  "item": "minecraft:diamond",
  "max_count": 5,
  "fail_message": { "text": "Denied", "color": "red" }
}
```
Types: `item_count_lt`, `item_count_gte`, `score`, `has_tag`, `gamemode`.

Containers: `chest_minecart` (27 slots) | `hopper_minecart` (5 slots).

## Errors

Invalid JSON, a missing `namespace`/`menu_id`/`pages`, an unknown widget
`kind`, or a widget missing a kind-specific required field (e.g. `nav`
without `target_page`) all surface as a plain-language error in the
status bar instead of generating a partial or broken datapack.

## Security note

This tool has no concept of who can trigger a widget in-game — it's a
straight port of the original generator, which has none either. Any
`commands` or `functions` attached to a button run for whoever clicks
it. If a config includes op-level effects (giving items, teleporting,
changing world state), review and gate those before shipping the
generated datapack to a real server — e.g. wrap the relevant
`click/<action_id>.mcfunction` with a permission check, or run it
through an allowlist layer like RTWrapper.
