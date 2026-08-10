# RTWrapper

RTWrapper is a datapack for Java Edition 26.2.

## Layout

```text
datapack/RTWrapper-Datapack/      Standalone datapack root
datapack/commands-26.2.json       Command wrapper manifest + command parameter names
docs/API.md                       API/storage protocol
```

## Datapack API quick start

Generated command wrappers use meaningful command-specific parameter names. There is no generated catch-all or generic numeric parameter API.

Provide the named parameters in the order listed for that command in `datapack/commands-26.2.json`. The dispatcher calls the exact `<command>_<N>` variant and does not append unused params.

```mcfunction
# /tp @s 0 80 0 via queued handler
data modify storage rtwrapper:api request set value {cmd:"tp",params:{target:"@s",x:"0",y:"80",z:"0"}}
function rtwrapper:api/run

# /give @s minecraft:stone 1 via direct API
data modify storage rtwrapper:api params set value {target:"@s",item:"minecraft:stone",count:"1"}
function rtwrapper:api/commands/give
```

> **Note:** The previous `scoreboard` example in this section used the objective `rtw.test`, which was tied to an external integration and was not sandboxed. That example has been removed and will not work if you try to reuse it as-is — build your own `scoreboard` payload from `datapack/commands-26.2.json` instead.

Named convenience wrapper example:

```mcfunction
# $give $(target) $(item)$(components) $(count)
data modify storage rtwrapper:api params set value {target:"@s",item:"minecraft:stone",components:"",count:"1"}
function rtwrapper:api/commands/give_item
```

Autotick usage:

```mcfunction
function rtwrapper:api/autotick/on

data modify storage rtwrapper:api request set value {cmd:"say",params:{message:"queued hello"}}
function rtwrapper:api/enqueue
```

Autotick processes one queued action per tick. Use `function rtwrapper:api/run` only for immediate full queue drain.

See [`docs/API.md`](docs/API.md) for the full protocol and debug/silent controls.

## Safety

RTWrapper intentionally exposes privileged macro-command execution for trusted datapacks/admins. Do not copy untrusted player-controlled text into `rtwrapper:api request` or `rtwrapper:api params`.

## Known issue

Test functions (`api/commands/test`, `core/wrappers/internal/test`, and the `test_0`–`test_4` variants) were intended to be removed from the shipped datapack — they were loading on a normal client, which is not intended behavior. **This cleanup has not actually happened yet**: the files are still present in `datapack/RTWrapper-Datapack/data/rtwrapper/function/`. Treat them as unfinished/unsupported until they're removed in a future commit; do not rely on them.

These `test` variants are not on the `#minecraft:tick` path by default — they only run if something explicitly queues `cmd:"test"` (e.g. `test_4` drives `/test run ...`). Note that `/test` here is **vanilla Minecraft's own `/test` command** (present on any vanilla server, not exclusive to the GameTest framework), and its `test_block[mode=log]` logging behavior is not something RTWrapper implements — RTWrapper only forwards the macro parameters to it. If autotick is enabled and a caller repeatedly enqueues `cmd:"test"` with `action`/`test_name` params (accidentally or via injected input), each drain can trigger vanilla `/test`'s own tick/log behavior — including `test_block[mode=log]` writes — which is a real TPS and disk-growth risk under sustained/malicious queuing. This is not a default-tick issue; it's an injection/misuse-triggered one, consistent with the macro-injection risk already noted under Safety.
