# TunnelScript

A small command library for Minecraft data packs. The idea is simple: instead of
copy-pasting the same `execute`/`function` boilerplate everywhere, you hand
TunnelScript a list of things to do and it runs them for you in one go.

I built this because I kept rewriting the same "run a bunch of commands from
storage" helper in every project. So I pulled it out into one pack that other
packs can just call.

Versions follow plain `MAJOR.MINOR.PATCH` (e.g. `1.0.4`). There's a configurable
cooldown and a hard cap on how many actions run per call, and nothing ever loops
on its own.

## Quick start

1. Grab the download that matches your Minecraft version.
2. Put it in your world's `datapacks` folder.
3. `/reload` (or just load the world).
4. Check it loaded with `/function ts:version`.

Everything you call lives under the `ts` namespace, and every call reads its
input from storage `tunnelscript:in`.

## How the pack is laid out

```
data/
├── minecraft/          load + tick tags, nothing else
├── tunnelscript_core/  the internal guts: macros, handlers, iterators
├── ts/                 the public API you actually call
└── ts_util/            small standalone helpers (math, text, etc.)
```

`tunnelscript_core` is private. Don't call into it directly, it can change
between releases. Stick to `ts` and `ts_util`.

## The basics

### Run one command

The raw command macro is kept internal on purpose, so you go through the
wrapper. It accepts `command`, `cmd`, or `func` as the key, because I can never
remember which one I named it:

```mcfunction
data merge storage tunnelscript:in {"command": "say hello"}
function ts:run_command
```

### Run several commands

```mcfunction
data merge storage tunnelscript:in {"commands": ["say one", "say two", "say three"]}
function ts:run_commands
```

### Run a function (optionally with arguments)

This one is backed by the `$function $(func) with $(type) $(val)` macro:

```mcfunction
data merge storage tunnelscript:in {"func": "namespace:path", "type": "storage", "val": "namespace:args"}
function ts:run_function
```

And the no-argument bulk version:

```mcfunction
data merge storage tunnelscript:in {"functions": ["ns:a", "ns:b", "ns:c"]}
function ts:run_functions
```

### Mixed action lists

This is the main event. Give `ts:run` a list of typed actions and it walks them
in order. Keep it on one line, line breaks will break the paste:

```mcfunction
data merge storage tunnelscript:in {"actions":[{"type":"cmd","value":"say start"},{"type":"give","value":"@p minecraft:diamond 64"},{"type":"function","func":"namespace:path"},{"type":"function_with","func":"namespace:path","with":"storage","val":"namespace:args"}]}
function ts:run
```

`type` is just the name of a handler. There are built-in handlers for
`cmd`/`command`/`func` (raw command), `function`, `function_with`, and every
common command in the list below, so `{"type":"give","value":"..."}` works out of
the box. Anything not in the list still works through `cmd`.

### Per-command "multi" wrappers

If you want to fire the same command once per argument, there's a wrapper for
each common command:

```mcfunction
data merge storage tunnelscript:in {"values": ["@p minecraft:diamond 64", "@a minecraft:apple 16"]}
function ts:multi/give
```

Wrappers exist for: advancement, attribute, bossbar, clear, clone, damage, data,
effect, enchant, execute, experience, fill, fillbiome, forceload, gamemode,
gamerule, give, item, kill, loot, particle, place, playsound, recipe, ride,
rotate, say, scoreboard, setblock, spawnpoint, spreadplayers, stopsound, summon,
tag, team, teleport, tellraw, time, title, tp, trigger, weather, worldborder.

Anything else still goes through `ts:run` or `ts:run_commands`.

## New in 1.0.4

Three new ways to run an action list. All of them are still single passes, none
of them loop.

### `ts:run_if` — only run when a condition holds

```mcfunction
data merge storage tunnelscript:in {"if":"score @s deaths matches 1..","actions":[{"type":"cmd","value":"say you have died"}]}
function ts:run_if
```

`if` is whatever you'd type after `execute if`. Want the opposite? Start it with
`unless`, like `"unless block ~ ~-1 ~ minecraft:air"`.

### `ts:run_as` — run as/at some entities

```mcfunction
data merge storage tunnelscript:in {"selector":"@a","actions":[{"type":"cmd","value":"effect give @s minecraft:glowing 5"}]}
function ts:run_as
```

Each matched entity runs the list once, as `@s`, standing where it stands.

### `ts:run_after` — run later, once

```mcfunction
data merge storage tunnelscript:in {"delay":"20t","actions":[{"type":"cmd","value":"say 1 second later"}]}
function ts:run_after
```

`delay` is a normal `/schedule` time (`20t`, `5s`, `1d`). It fires a single time.
Only the most recently scheduled list is kept, so this won't pile up, and it
never reschedules itself.

## ts_util — little helpers

These are standalone utilities, separate from the action pipeline. Most of them
read from / write to the shared `tunnelscript.vars` scoreboard or to storage
`tunnelscript:out`. Set the inputs, call the function, read the result.

**Math** (work on fake scores on `tunnelscript.vars`):

```mcfunction
# clamp #in into [#min, #max], result goes to #out
scoreboard players set #in tunnelscript.vars 130
scoreboard players set #min tunnelscript.vars 0
scoreboard players set #max tunnelscript.vars 100
function ts_util:math/clamp
# #out is now 100
```

Also here: `math/min`, `math/max`, `math/abs`, and `math/random` (random int in
`[#min, #max]`).

**Entities:**

```mcfunction
data merge storage tunnelscript:in {"selector":"@e[type=zombie]"}
function ts_util:entity/count        # writes the count to #out

data merge storage tunnelscript:in {"selector":"@e[distance=..5]","tag":"near"}
function ts_util:entity/tag_area     # tags everything in range
```

**Text:** join a list of strings into one, with a separator. Result ends up in
`tunnelscript:out joined`:

```mcfunction
data merge storage tunnelscript:in {"list":["a","b","c"],"sep":", "}
function ts_util:text/join
```

**Storage:** `data/list_length` (length of a list into `#out`) and `data/copy`
(copy `tunnelscript:in from` into `tunnelscript:out copied`).

**Time:** `time/gametime` and `time/daytime` drop the value into `#out`.

## Triggers (works without op)

Players who aren't operators can still drive the API through the `tunnelScript.use`
trigger. Set your storage input first if the action needs it, then:

```mcfunction
/trigger tunnelScript.use set 1
```

| Value | Runs              | Value | Runs               |
| ----- | ----------------- | ----- | ------------------ |
| 1     | `ts:version`      | 9     | `ts:config/reset`  |
| 2     | `ts:help`         | 10    | `ts:run_if`        |
| 3     | `ts:run`          | 11    | `ts:run_as`        |
| 4     | `ts:run_command`  | 12    | `ts:run_after`     |
| 5     | `ts:run_commands` | 13    | `ts:menu`          |
| 6     | `ts:run_function` | 14    | `ts:menu/close`    |
| 7     | `ts:run_functions`| 15    | `ts:dialog/open_dynamic` *(1.21.6)* |
| 8     | `ts:config/get`   |       |                    |

The objective is set up on load and re-armed for you. The tick only reacts when
someone actually pulls the trigger, it never replays anything by itself. Value
15 only does something on the 1.21.6 build, where the dialog API exists.

## Sidebar menu

There's a clickable-ish menu in the scoreboard sidebar. No chat spam (so your log
stays readable), and no written book (whose format keeps shifting between
versions):

```mcfunction
function ts:menu          # show it
function ts:menu/close    # hide it
function ts:menu/rebuild  # rebuild and reshow (after you change labels)
```

Pick an option, no op needed:

```mcfunction
/trigger tunnelScript.menu set 1
```

The numbers match the trigger table above. The menu stays up after you pick, so
you can keep choosing. Score numbers are hidden with `numberformat blank`, and
each row is a tidy space-free holder (`ts.l1`..`ts.l12`) whose visible text comes
from `scoreboard players display name`, which is how you get spaces and colours
without fighting quoted player names.

One thing worth knowing: the `tunnelScript.menu` trigger is only active while the
menu is actually open. Opening it tags you `tsMenuOpen` and enables the trigger;
closing removes the tag and disables it again. So if the menu is closed, the
trigger does nothing.

### Floating label (hologram)

If you want a label floating in the world, there's a small helper. It uses an
invisible marker armor stand (the usual trick) tagged `tunnelscript_menu`:

```mcfunction
execute positioned 100 65 100 run function ts:hologram/spawn
function ts:hologram/remove

# rename it (raw text component; SNBT on 1.21.5+, JSON before that)
data merge storage tunnelscript:in {name:'{text:"Shop",color:"gold"}'}
function ts:hologram/set_name
```

Heads up: a plain `minecraft:marker` shows nothing, which is why this uses an
invisible armor stand instead. The scoreboard sidebar can't display an entity's
custom name either, that's a separate thing and it's why the menu above uses
score holders, not entities.

## Dialog menus (1.21.6 build only)

The 1.21.6 build hooks into the new `/dialog` command, so you get actual pop-up
windows that can take input (text fields, toggles, sliders, dropdowns).

You write the dialog yourself, inline, as SNBT. There's no bundled example pack.
Here's a small two-button menu where each button just pulls a `/trigger` value,
so it works for everyone with no confirmation popup:

```mcfunction
data merge storage tunnelscript:in {dialog:{type:"minecraft:multi_action",title:"TunnelScript",body:[{type:"minecraft:plain_message",contents:"Choose an option:"}],pause:false,columns:1,actions:[{label:"Version",action:{type:"minecraft:run_command",command:"/trigger tunnelScript.use set 1"}},{label:"Help",action:{type:"minecraft:run_command",command:"/trigger tunnelScript.use set 2"}}]}}
function ts:dialog/open_dynamic

# show it to everyone tagged _dialogMenu.open
function ts:dialog/open_group

function ts:dialog/close
```

If you're already in the sidebar menu and want to jump into a dialog, there's a
shortcut that closes the sidebar (it calls `ts:menu/close`) and then opens the
dialog you put in `tunnelscript:in`:

```mcfunction
function ts:menu/to_dialog
```

Small gotcha that cost me time: a `minecraft:plain_message` body uses `contents`,
not `message`.

### Why inline instead of a registered `ns:path`?

You *can* register dialogs as files and reference them by id, but I'd avoid it:

- If that `ts:*` file ever gets deleted or renamed, the reference just breaks.
  An inline definition carries everything with it, nothing external to lose.
- Registered dialog files flag the pack as using experimental features and you
  get the warning screen. Passing the dialog inline skips that.
- Inline means you can build the title/body/buttons at runtime, which is handy
  for translations or anything dynamic.

The opt-in macro the spec asked for is at `tunnelscript_core:handlers/dialog`:

```mcfunction
$dialog show @a[tag=_dialogMenu.open] $(dialog)
```

### Avoiding the confirmation popup

`minecraft:run_command` buttons run at the *player's* permission level, so a
non-op clicking an op-only command gets the "are you sure" confirmation screen.
The way around it is to point the button at `/trigger` instead, which is
permission level 0 and never asks:

```mcfunction
{type:"minecraft:run_command",command:"/trigger tunnelScript.use set 3"}
```

Since TunnelScript already maps trigger values 1–9 to its functions, your buttons
can drive the whole thing with no popups and no op.

And the obvious caveat: `minecraft:dynamic/custom` only does something if a mod
or plugin is listening for the packet. In plain vanilla it's a no-op, so stick to
`run_command` (ideally via `/trigger`).

## Configuration

```mcfunction
# cooldown between runs, in ticks (0 = off)
data merge storage tunnelscript:in {"ticks": 20}
function ts:config/set_cooldown

# how many actions a single run may process
data merge storage tunnelscript:in {"value": 256}
function ts:config/set_max_actions

function ts:config/get
function ts:config/reset
```

On the "no loops" thing: the pack never re-runs your actions on its own. There's
no tick loop and nothing self-schedules. The cooldown just limits how often *you*
can kick off a run.

## Which version do I download?

Each Minecraft version is its own branch / release:

| Branch   | Minecraft | Pack format |
| -------- | --------- | ----------- |
| `main`   | 1.21.1    | 48          |
| `1.21.6` | 1.21.6    | 80          |
| `1.21.4` | 1.21.4    | 61          |
| `1.20.4` | 1.20.4    | 26          |

The 1.21.6 build uses SNBT text components in its commands, because that's what
1.21.5+ switched `/tellraw`, `/title` and friends over to. Earlier builds use
JSON. Either way, the input you pass in `tunnelscript:in` is the same.

## Notes on safety

No hidden payloads, no telemetry, nothing phoning home. No tokens or secrets are
committed to this repo, and please don't add any. There's more detail in
[SECURITY.md](SECURITY.md) and [.github/SUPPORT.md](.github/SUPPORT.md).

## License

[MIT](LICENSE), © Runtoolkit. See [CHANGELOG.md](CHANGELOG.md) for the version
history.
