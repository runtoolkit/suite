# TunnelScript

A small command-running library for Minecraft data packs. The idea is simple:
instead of copy-pasting the same `execute`/`function` boilerplate everywhere,
you hand TunnelScript a command (or a batch of them) and it runs them for you,
with permission gating, a confirmation step for dangerous actions, and a few
safety rails (cooldowns, an action cap, dry-run preview).

This build targets **Minecraft 1.19.2** (`pack_format: 10`). 1.19.2 predates
function macros (added in 1.20.2), so there's no dynamic `$function $(...)`
dispatch here - commands are captured and run through a command-block-based
runner instead. See "How commands actually run" below.

## Quick start

1. Put the pack in your world's `datapacks` folder.
2. `/reload` (or just load the world).
3. Check it loaded with `/function ts:version`, and see the full API with
   `/function ts:help`.
4. Grant yourself permission for the gated actions (see "Trust and
   confirmation" below): `/execute as @s run function ts:trust/grant`.

Everything you call lives under the `ts` namespace. Most inputs are read from
storage `tunnelscript:in`.

## How the pack is laid out

```
data/
├── minecraft/          load + tick tags, nothing else
├── tunnelscript_core/  the internal guts: the command-block runner, the
│                        minecart input scanner, the gate/trust machinery
├── ts/                 the public API you actually call
└── ts_util/             small standalone helpers (math, data, time)
```

`tunnelscript_core` is private. Don't call into it directly, it can change
between releases. Stick to `ts` and `ts_util`.

## How commands actually run

There's no macro-based dynamic dispatch on 1.19.2, so TunnelScript uses a
command-block minecart as the execution engine: a command is written into a
`command_block_minecart`'s `Command` tag, the minecart runs it, and the result
is read back. This is what backs `ts:run_command`, `ts:run_commands`, and the
minecart input module below.

### Run one command

```mcfunction
data merge storage tunnelscript:in {"command": "say hello"}
function ts:run_command
```

`cmd` also works as an alias for `command`. This is a **gated** action - see
"Trust and confirmation".

### Run several commands

```mcfunction
data merge storage tunnelscript:in {"commands": ["say one", "say two"]}
function ts:run_commands
```

Also gated.

### Typed action lists (`ts:run`)

```mcfunction
data merge storage tunnelscript:in {"actions": [
  {"type": "cmd", "value": "say start"},
  {"type": "command", "value": "say done"}
]}
function ts:run
```

Only the `cmd`/`command` action types are handled on this build - types like
`function`, `function_with`, or per-command shortcuts (`give`, `tp`, ...)
need function macros and only exist on the 1.20.2+ builds. Anything else in
an action list is silently skipped here.

### Command batches (fixed slots)

Save a named list of commands to one of 9 fixed slots, and load or run it
later:

```mcfunction
data merge storage tunnelscript:in {"slot": 1, "name": "starter", "commands": ["say hi", "give @p minecraft:apple"]}
function ts:batch/save

data merge storage tunnelscript:in {"slot": 1}
function ts:batch/load   # loads into tunnelscript:in commands[]
function ts:batch/run    # loads the slot and runs it with ts:run_commands (gated)

function ts:batch/list   # print all 9 slots
function ts:batch/delete # delete a slot (gated)
```

## Trust and confirmation

Anything that can change the world through arbitrary player-supplied commands
is gated behind two layers:

1. **Trust** - the caller needs the `tunnelscript.trusted` tag. An operator
   grants it: `/execute as <player> run function ts:trust/grant`, and revokes
   it with `ts:trust/revoke`.
2. **Confirmation** - a trusted caller's gated request doesn't run
   immediately. It's staged as a pending request, and the same caller (the
   entity tagged `tunnelscript_gate_owner`) has to confirm it:

   ```mcfunction
   function ts:gate/yes      # run the pending action
   function ts:gate/cancel   # discard it - anyone can cancel, as a safety valve
   ```

Gated actions: `ts:run_command`, `ts:run_commands`, `ts:batch/run`,
`ts:batch/delete`, and the destructive reset/clear calls in the input, log,
and dry-run modules (`input/minecart_remove`, `input/clear_history`,
`input/clear_queue`, `input/reset_stats`, `log/clear`, `dryrun/reset_count`).

## Minecart input module

Since 1.19.2 has no way to hand a data pack a string command dynamically,
TunnelScript reads commands out of a tagged command-block minecart's `Command`
field:

```mcfunction
function ts:input/minecart_summon   # spawn a tunnelscript_input-tagged minecart at your position
function ts:input/scan_once         # capture whatever's currently in its Command field
function ts:input/run_next          # run one queued command immediately
function ts:input/minecart_remove   # remove all input minecarts (gated)
```

Scanning and queue processing normally happen every tick; `pause`/`resume`
toggle that:

```mcfunction
function ts:input/pause
function ts:input/resume
function ts:input/status            # minecart count, queue length, paused/silent state
```

Every captured command is kept in a history (`storage tunnelscript:minecart
log[]`), viewable with `ts:input/history` and `ts:input/last`.
`ts:input/silent_on` / `silent_off` toggle the capture/execution chat
messages. `ts:input/clear_history`, `clear_queue`, and `reset_stats` are all
gated.

## Dry-run (preview mode)

```mcfunction
function ts:dryrun/on      # commands that reach the runner are printed, not executed
function ts:dryrun/off
function ts:dryrun/status  # on/off + how many commands have been previewed
function ts:dryrun/reset_count  # gated
```

Nothing is placed, no forceload is taken, the world is untouched while dry-run
is on.

## Command log and repeat

```mcfunction
function ts:log/on          # start recording executed commands into storage tunnelscript:log entries[]
function ts:log/off         # stop recording (existing entries are kept)
function ts:log/show        # print entry count / cap / recording state
function ts:log/last        # most recently executed command
function ts:log/clear       # gated
data merge storage tunnelscript:in {"value": 64}
function ts:log/set_max     # cap the log size (default 64)

function ts:repeat          # re-run the most recently executed command (needs the log)
```

## Configuration

```mcfunction
# cooldown between runs, in ticks (0 = off)
data merge storage tunnelscript:in {"ticks": 20}
function ts:config/set_cooldown

# how many actions a single ts:run call may process
data merge storage tunnelscript:in {"value": 256}
function ts:config/set_max_actions

function ts:config/get     # print current cooldown + cap
function ts:config/reset   # back to defaults: cooldown off, 256 actions
```

## Hologram label

A small floating in-world label, using an invisible marker-tagged armor
stand:

```mcfunction
function ts:hologram/spawn
function ts:hologram/remove
data merge storage tunnelscript:in {"name": '[{"text":"Shop","color":"gold"}]'}
function ts:hologram/set_name
```

## ts_util - little helpers

Standalone utilities, separate from the command runner. Most read from /
write to the shared `tunnelscript.vars` scoreboard or storage
`tunnelscript:out`.

**Math** (work on fake scores on `tunnelscript.vars`):

```mcfunction
scoreboard players set #in tunnelscript.vars 130
scoreboard players set #min tunnelscript.vars 0
scoreboard players set #max tunnelscript.vars 100
function ts_util:math/clamp
# #out is now 100
```

Also here: `math/min`, `math/max`, `math/abs`, and `math/random` (random int
in `[#min, #max]`).

**Entities:**

```mcfunction
data merge storage tunnelscript:in {"selector": "@e[type=zombie]"}
function ts_util:entity/count        # writes the count to #out

data merge storage tunnelscript:in {"selector": "@e[distance=..5]", "tag": "near"}
function ts_util:entity/tag_area     # tags everything in range
```

**Text:** join a list of strings into one, with a separator. Result ends up in
`tunnelscript:out joined`:

```mcfunction
data merge storage tunnelscript:in {"list": ["a", "b", "c"], "sep": ", "}
function ts_util:text/join
```

**Storage:** `data/list_length` (length of a list into `#out`) and
`data/copy` (copy `tunnelscript:in from` into `tunnelscript:out copied`).

**Time:** `time/gametime` and `time/daytime` drop the value into `#out`.

## `/trigger` access (works without op)

Non-operators can still reach the core API through the `tunnelScript.use`
trigger. Set your storage input first if the action needs it, then:

```mcfunction
/trigger tunnelScript.use set 1
```

| Value | Runs              |
| ----- | ----------------- |
| 1     | `ts:version`      |
| 2     | `ts:help`         |
| 3     | `ts:run`          |
| 4     | `ts:run_command`  |
| 5     | `ts:run_commands` |
| 6     | `ts:config/get`   |
| 7     | `ts:config/reset` |

The objective is registered on load. Function macro-only features
(`run_function` with arguments, `run_if`, `run_as`, `run_after`, dialog menus)
need Minecraft 1.20.2+ and live on a different build/branch of TunnelScript,
not this one.

## Which build do I want?

This is the **1.19.2** build (`pack_format: 10`). If you're on a newer
Minecraft version, you want a different build/branch of TunnelScript - check
the releases on the project's GitHub page for what's available.

## Notes on safety

No hidden payloads, no telemetry, nothing phoning home. No tokens or secrets
are committed to this repo, and please don't add any. There's more detail in
[SECURITY.md](SECURITY.md) and [.github/SUPPORT.md](.github/SUPPORT.md).

## License

[MIT](LICENSE), © Runtoolkit. See [CHANGELOG.md](CHANGELOG.md) for the version
history.
