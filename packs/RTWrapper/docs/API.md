# RTWrapper API

Namespace: `rtwrapper`
Target: Java Edition 26.2 / pack format 104.

## Storage protocol

Immediate execution uses `storage rtwrapper:api request` plus `rtwrapper:api/run`.

RTWrapper no longer uses a single `$(tail)` catch-all. Generated command wrappers use meaningful command-specific parameter names stored under `params`.

```mcfunction
# /tp @s 0 80 0 immediately
data modify storage rtwrapper:api request set value {cmd:"tp",params:{target:"@s",x:"0",y:"80",z:"0"}}
function rtwrapper:api/run

# /scoreboard players set #smoke rtw.test 1 immediately
data modify storage rtwrapper:api request set value {cmd:"scoreboard",params:{category:"players",action:"set",subject:"#smoke",objective:"rtw.test",value:"1"}}
function rtwrapper:api/run
```

`type` is accepted as an alias for `cmd`:

```mcfunction
data modify storage rtwrapper:api request set value {type:"give",params:{target:"@s",item:"minecraft:stone",count:"1"}}
function rtwrapper:api/run
```

For delayed/autotick execution, enqueue the request instead of running it immediately:

```mcfunction
data modify storage rtwrapper:api request set value {cmd:"say",params:{message:"queued hello"}}
function rtwrapper:api/enqueue
```

Parameter order is command-specific and recorded in `datapack/commands-26.2.json` under `command_params`. Examples:

```json
{
  "tp": ["target", "x", "y", "z", "rotation", "facing_mode", "facing_target", "facing_anchor"],
  "give": ["target", "item", "count"],
  "scoreboard": ["category", "action", "subject", "objective", "value", "operation", "source", "source_objective"]
}
```

Important rule: provide contiguous parameters in that command's order. The dispatcher detects the highest present meaningful name and calls the matching variant, so unused params are not appended to the final command.

The immediate handler flow is:

```text
rtwrapper:api/run
  -> api/enqueue when request exists
  -> core/run/run_actions
    -> core/wrappers/handler/main
      -> proc
        -> dispatch
          -> exec
            -> core/wrappers/internal/<cmd>
              -> core/wrappers/internal/variants/<cmd>_<N>
```

A generated variant looks like:

```mcfunction
$<command> $(meaningful_name_a) $(meaningful_name_b) ...
```

Put one token or one already-formatted Brigadier group in each parameter. For example, JSON/text messages can still be stored as one parameter value if Minecraft expects that parameter as one continuous component.

## Direct API command wrappers

You can also place parameters in `storage rtwrapper:api params` and call a direct API function:

```mcfunction
# /give @s minecraft:stone 1
data modify storage rtwrapper:api params set value {target:"@s",item:"minecraft:stone",count:"1"}
function rtwrapper:api/commands/give
```

The direct API copies `rtwrapper:api params` to runtime storage and invokes `core/wrappers/internal/<command>`, which chooses the correct `<command>_<N>` variant.

## Convenience named wrappers

The datapack still includes named examples for common macro use:

```mcfunction
# $tp $(target) $(x) $(y) $(z)
data modify storage rtwrapper:api params set value {target:"@s",x:"0",y:"80",z:"0"}
function rtwrapper:api/commands/tp_pos

# $tp $(target) $(x) $(y) $(z) $(rotation)
data modify storage rtwrapper:api params set value {target:"@s",x:"0",y:"80",z:"0",rotation:"0 0"}
function rtwrapper:api/commands/tp_pos_rot

# $give $(target) $(item)$(components) $(count)
data modify storage rtwrapper:api params set value {target:"@s",item:"minecraft:stone",components:"",count:"1"}
function rtwrapper:api/commands/give_item
```

For `give_item`, `components:""` is allowed because it is concatenated directly to `item`, not appended as a separate trailing token.

## Runtoolkit loaded-pack registry

RTWrapper includes a shared `runtoolkit` namespace for Runtoolkit datapack discovery:

```text
data/runtoolkit/function/core/load.mcfunction
data/runtoolkit/function/core/tick.mcfunction
data/runtoolkit/function/api/status.mcfunction
data/runtoolkit/advancement/root.json
data/runtoolkit/advancement/packs/rtwrapper.json
```

The visual registry uses advancements with the `minecraft:tick` trigger and does not revoke them. After `/reload`, open **Advancements > Runtoolkit** to see loaded Runtoolkit packs/modules.

Status helper:

```mcfunction
function runtoolkit:api/status
```

Other Runtoolkit datapacks can add themselves by including a child advancement under the shared namespace, for example:

```text
data/runtoolkit/advancement/packs/my_pack.json
```

Use this pattern:

```json
{
  "parent": "runtoolkit:root",
  "display": {
    "icon": {"id": "minecraft:knowledge_book"},
    "title": {"text": "My Pack", "color": "green"},
    "description": {"text": "Loaded: My Pack"},
    "show_toast": false,
    "announce_to_chat": false,
    "hidden": false
  },
  "criteria": {
    "loaded": {"trigger": "minecraft:tick"}
  }
}
```

Do not add revoke functions for this registry; the goal is a persistent loaded-pack marker.

## Debug / silent

```mcfunction
function rtwrapper:api/debug/listen
function rtwrapper:api/debug/on
function rtwrapper:api/silent/off
function rtwrapper:api/status
```

`silent` suppresses RTWrapper's own debug/status tellraw output. It intentionally does not permanently toggle vanilla gamerules.

## Auto tick

Auto tick is disabled by default.

```mcfunction
function rtwrapper:api/autotick/on
function rtwrapper:api/autotick/off
```

Current behavior: autotick processes **one** action per tick by calling `core/run/run_next`. It does not recursively drain the whole queue. This avoids tick spikes and runaway recursion.

Recommended autotick usage for multiple actions:

```mcfunction
function rtwrapper:api/autotick/on

data modify storage rtwrapper:api request set value {cmd:"say",params:{message:"first queued action"}}
function rtwrapper:api/enqueue

data modify storage rtwrapper:api request set value {cmd:"say",params:{message:"second queued action"}}
function rtwrapper:api/enqueue
```

Each queued action will be processed on a later tick, one per tick. If you write a single `rtwrapper:api request` and do not enqueue it, autotick will still consume that one direct request on the next tick; however, multiple producers should use `api/enqueue` to avoid overwriting the shared request storage.

Use `function rtwrapper:api/run` only when you want immediate full drain.

## Security note

Every macro command runs with the permission/context of the function caller. Only write trusted strings into `rtwrapper:api request` or `rtwrapper:api params`.
