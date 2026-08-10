#!/usr/bin/env python3
"""TunnelScript datapack generator.

Generates the TunnelScript data pack for a single Minecraft target.
The same logical content is emitted for every supported version. Per target
the following differ:

* pack format ("pack_format").
* the "function"/"functions" directory naming (singular since 1.21).
* the text-component encoding used inside commands: JSON up to 1.21.4, and
  SNBT from 1.21.5 onward (/tellraw, /title and the scoreboard styled number
  format / display names now take SNBT instead of JSON).

Usage:
    python3 tools/build_versions.py <target>

Where <target> is one of: 1.21.6 | 1.21.4 | 1.21.1 | 1.20.4

This tool never stores credentials of any kind and produces deterministic
output so the release branches stay byte-for-byte reproducible.
"""

import json
import os
import shutil
import sys

VERSION = "1.0.4"

# Per game-version build parameters.
# fn      -> directory name used for functions and function tags
# format  -> data pack "pack_format" value for that Minecraft version
# text    -> text-component encoding used inside commands ("json" or "snbt")
TARGETS = {
    "1.21.6": {"fn": "function", "format": 80, "label": "Minecraft 1.21.6", "text": "snbt", "dialog": True},
    "1.21.4": {"fn": "function", "format": 61, "label": "Minecraft 1.21.4", "text": "json"},
    "1.21.1": {"fn": "function", "format": 48, "label": "Minecraft 1.21.1", "text": "json"},
    "1.20.4": {"fn": "functions", "format": 26, "label": "Minecraft 1.20.4", "text": "json"},
}


def write(root, rel_path, content):
    """Write a UTF-8 text file, creating parent directories as needed."""
    path = os.path.join(root, rel_path)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    if not content.endswith("\n"):
        content += "\n"
    with open(path, "w", encoding="utf-8", newline="\n") as handle:
        handle.write(content)


def _snbt(value):
    """Serialize a Python value to SNBT (as used by 1.21.5+ commands)."""
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)):
        return str(value)
    if isinstance(value, str):
        # Single-quote strings; escape backslashes and single quotes.
        return "'" + value.replace("\\", "\\\\").replace("'", "\\'") + "'"
    if isinstance(value, list):
        return "[" + ",".join(_snbt(v) for v in value) + "]"
    if isinstance(value, dict):
        # All component keys here are valid unquoted SNBT identifiers.
        return "{" + ",".join(f"{k}:{_snbt(v)}" for k, v in value.items()) + "}"
    raise TypeError(f"unsupported SNBT value: {value!r}")


def make_tc(text_format):
    """Return a text-component serializer for the given format ('json'/'snbt')."""
    if text_format == "snbt":
        return _snbt

    def _json(value):
        return json.dumps(value, ensure_ascii=False, separators=(",", ":"))

    return _json


def make_tc_nbt(text_format, tc):
    """Serializer for a text component embedded in entity NBT (e.g. CustomName).

    Up to 1.21.4 an entity CustomName holds a STRING that contains JSON, so the
    JSON is wrapped in single quotes. From 1.21.5 CustomName holds an inline
    SNBT component, so it is emitted directly.
    """
    if text_format == "snbt":
        return tc

    def _wrap(value):
        inner = tc(value).replace("\\", "\\\\").replace("'", "\\'")
        return "'" + inner + "'"

    return _wrap


# Commands that get a generated "multi" convenience wrapper in the public API.
# Every other command is still fully supported through ts:run_commands, this is
# only ergonomic sugar for the most frequently batched commands.
MULTI_COMMANDS = [
    "advancement", "attribute", "bossbar", "clear", "clone", "damage",
    "data", "effect", "enchant", "execute", "experience", "fill",
    "fillbiome", "forceload", "gamemode", "gamerule", "give", "item",
    "kill", "loot", "particle", "place", "playsound", "recipe", "ride",
    "rotate", "say", "scoreboard", "setblock", "spawnpoint", "spreadplayers",
    "stopsound", "summon", "tag", "team", "teleport", "tellraw", "time",
    "title", "tp", "trigger", "weather", "worldborder",
]


def build(target):
    cfg = TARGETS[target]
    fn = cfg["fn"]
    pack_format = cfg["format"]
    label = cfg["label"]
    tc = make_tc(cfg["text"])
    tc_nbt = make_tc_nbt(cfg["text"], tc)
    has_dialog = cfg.get("dialog", False)

    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

    # Remove any previous build artifacts so each branch is a clean snapshot.
    data_dir = os.path.join(root, "data")
    if os.path.isdir(data_dir):
        shutil.rmtree(data_dir)
    mcmeta = os.path.join(root, "pack.mcmeta")
    if os.path.exists(mcmeta):
        os.remove(mcmeta)

    core = f"data/tunnelscript_core/{fn}"
    api = f"data/ts/{fn}"

    # ------------------------------------------------------------------
    # pack.mcmeta (always a JSON file regardless of in-command text format)
    # ------------------------------------------------------------------
    write(root, "pack.mcmeta", json.dumps({
        "pack": {
            "pack_format": pack_format,
            "description": [
                {"text": "TunnelScript ", "color": "aqua", "bold": True},
                {"text": f"v{VERSION}", "color": "white"},
                {"text": f"\nMulti-action command library ({label})", "color": "gray"},
            ],
        }
    }, indent=2))

    # ------------------------------------------------------------------
    # minecraft load / tick tags
    # ------------------------------------------------------------------
    write(root, f"data/minecraft/tags/{fn}/load.json",
          json.dumps({"values": ["tunnelscript_core:load"]}, indent=2))
    write(root, f"data/minecraft/tags/{fn}/tick.json",
          json.dumps({"values": ["tunnelscript_core:tick"]}, indent=2))

    # ------------------------------------------------------------------
    # Core: bootstrap and reserved tick
    # ------------------------------------------------------------------
    write(root, f"{core}/load.mcfunction", f"""\
# TunnelScript {VERSION} - bootstrap
# Runs once on (re)load. Registers the shared objective and seeds the default
# configuration only when a value has never been set, so user changes survive
# reloads.
scoreboard objectives add tunnelscript.vars dummy
# Public trigger objectives. Players bind actions with:
#   /trigger tunnelScript.use  set <n>   -> run a ts: function directly
#   /trigger tunnelScript.menu set <n>   -> run option <n> from the sidebar menu
scoreboard objectives add tunnelScript.use trigger
scoreboard objectives add tunnelScript.menu trigger
execute unless score #max_actions tunnelscript.vars = #max_actions tunnelscript.vars run scoreboard players set #max_actions tunnelscript.vars 256
execute unless score #cooldown_max tunnelscript.vars = #cooldown_max tunnelscript.vars run scoreboard players set #cooldown_max tunnelscript.vars 0
execute unless score #last_run tunnelscript.vars = #last_run tunnelscript.vars run scoreboard players set #last_run tunnelscript.vars -2000000000
scoreboard players set #neg_one tunnelscript.vars -1
# The sidebar menu is built lazily on first "function ts:menu" -- nothing is
# created or displayed on load, so reloads stay silent.
# Publish version + config to storage so other packs can read it.
data modify storage tunnelscript:meta version set value "{VERSION}"
data modify storage tunnelscript:meta target set value "{label}"
""")

    write(root, f"{core}/tick.mcfunction", """\
# Tick hook. The ONLY per-tick work is event detection for the public triggers:
# tunnelScript.use and tunnelScript.menu. This never re-runs queued actions on
# its own, it only reacts to a player explicitly pulling a trigger. There is no
# looping/repeating of action lists anywhere.
scoreboard players enable @a tunnelScript.use
# The menu trigger is only usable while the menu is open (tag tsMenuOpen).
# Players without the tag have it disabled, so "tag yes -> on, tag no -> off".
scoreboard players enable @a[tag=tsMenuOpen] tunnelScript.menu
scoreboard players reset @a[tag=!tsMenuOpen] tunnelScript.menu
execute as @a[scores={tunnelScript.use=1..}] run function tunnelscript_core:internal/trigger_dispatch
execute as @a[tag=tsMenuOpen,scores={tunnelScript.menu=1..}] run function tunnelscript_core:internal/menu_dispatch
""")

    # Sidebar menu builder. Uses a dummy objective shown in the sidebar slot.
    # Each visible line is a score holder with a clean, space-free name (e.g.
    # "ts.l1"); the holder's *displayed* text is set with "scoreboard players
    # display name", which accepts a full text component (so spaces and colours
    # are supported without relying on quoted names-with-spaces). The score only
    # controls ordering (higher = nearer the top) and is hidden with
    # "numberformat blank". No tellraw is used (logs stay clean) and no book is
    # used (its syntax keeps changing between versions). The display-name text
    # component is encoded per the target's text format (JSON up to 1.21.4,
    # SNBT from 1.21.5).
    #
    # Note: this intentionally does NOT use a marker/armor-stand entity with a
    # CustomName. The sidebar cannot render an entity's CustomName; non-player
    # score holders are shown by their UUID, so that approach would not work.
    def option(num, name):
        return [
            {"text": f"[{num}] ", "color": "yellow"},
            {"text": name, "color": "white"},
        ]

    # One shared list of (trigger value, label). Both the sidebar rows and the
    # ts:menu/to_dialog buttons (1.21.6) are generated from this, so they always
    # match the trigger_dispatch mapping and never drift apart.
    menu_options = [
        (1, "version"),
        (2, "help"),
        (3, "run (actions)"),
        (4, "run_command"),
        (5, "run_commands"),
        (6, "run_function"),
        (7, "run_functions"),
        (8, "config: show"),
        (9, "config: reset"),
        (10, "run_if"),
        (11, "run_as"),
        (12, "run_after"),
    ]
    menu_lines = [option(n, name) for n, name in menu_options]
    menu_lines += [
        {"text": "--------------------", "color": "dark_gray", "strikethrough": True},
        {"text": "select: /trigger tunnelScript.menu set N", "color": "gray"},
        {"text": "close: function ts:menu/close", "color": "gray"},
    ]

    menu_note = ""
    if has_dialog:
        # The dialog bridge only exists on builds that have /dialog (1.21.6+).
        menu_note = (
            "# [NOTE]: ts:menu/to_dialog closes the sidebar (it calls ts:menu/close) and\n"
            "#         then opens a self-contained /dialog that mirrors every sidebar\n"
            "#         option (its own definition, not from storage tunnelscript:in).\n"
        )
    menu_body = (
        "# (Re)build the sidebar menu objective and its lines. This is internal and\n"
        "# is only invoked on demand by ts:menu / ts:menu/rebuild -- it never runs on\n"
        "# load, so reloads stay silent. Removing and re-adding the objective clears\n"
        "# any stale lines from a previous version. This does NOT display the menu.\n"
        + menu_note +
        "scoreboard objectives remove tunnelscript.menu_ui\n"
        f"scoreboard objectives add tunnelscript.menu_ui dummy {tc({'text': 'TunnelScript', 'color': 'aqua', 'bold': True})}\n"
        "scoreboard objectives modify tunnelscript.menu_ui numberformat blank\n"
    )
    total = len(menu_lines)
    for index, component in enumerate(menu_lines):
        holder = f"ts.l{index + 1}"
        order = total - index  # higher score sorts nearer the top
        menu_body += f"scoreboard players set {holder} tunnelscript.menu_ui {order}\n"
        menu_body += f"scoreboard players display name {holder} tunnelscript.menu_ui {tc(component)}\n"
    write(root, f"{core}/internal/menu_build.mcfunction", menu_body)

    # Optional in-world hologram label, built from a marker + tag + CustomName.
    #
    # A literal minecraft:marker renders nothing, so the visible floating label
    # uses an invisible "marker" armor stand (Marker:1b) -- the standard vanilla
    # hologram entity that DOES render its CustomName. It is identified by the
    # tag "tunnelscript_menu", so it can be selected, moved or removed reliably.
    # CustomName is a text component embedded in NBT: a JSON string up to 1.21.4
    # and an inline SNBT component from 1.21.5 onward (handled by tc_nbt).
    hologram_name = tc_nbt([
        {"text": "TunnelScript ", "color": "aqua", "bold": True},
        {"text": "Menu", "color": "white"},
    ])
    write(root, f"{api}/hologram/spawn.mcfunction", f"""\
# Spawn a floating menu label at the command position (e.g. run via
# /execute positioned ...). Removes any previous TunnelScript hologram first so
# duplicates never stack. Tagged "tunnelscript_menu" for later selection.
kill @e[type=armor_stand,tag=tunnelscript_menu]
summon armor_stand ~ ~ ~ {{Tags:["tunnelscript_menu"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,CustomNameVisible:1b,CustomName:{hologram_name}}}
""")

    write(root, f"{api}/hologram/remove.mcfunction", """\
# Remove the in-world menu hologram(s).
kill @e[type=armor_stand,tag=tunnelscript_menu]
""")

    write(root, f"{core}/handlers/hologram_name.mcfunction", """\
# Internal macro: relabel the hologram with the provided "name" component.
$data modify entity @e[type=armor_stand,tag=tunnelscript_menu,limit=1] CustomName set value $(name)
""")

    write(root, f"{api}/hologram/set_name.mcfunction", """\
# Relabel the hologram from storage tunnelscript:in { "name": <text component> }.
# Provide a raw text component (JSON up to 1.21.4, SNBT from 1.21.5), e.g.
#   data merge storage tunnelscript:in {name:'{text:"Shop",color:"gold"}'}   (1.21.5+)
function tunnelscript_core:handlers/hologram_name with storage tunnelscript:in
""")

    # Extra option -> function mappings for values 10 and up.
    # The general "use" trigger gets the full list. The "menu" trigger drops the
    # "open menu" entry (you are already in the menu) and renumbers, so its high
    # values stay contiguous. Dialog only exists on the 1.21.6 build.
    use_extra = [
        (10, "ts:run_if"),
        (11, "ts:run_as"),
        (12, "ts:run_after"),
        (13, "ts:menu"),
        (14, "ts:menu/close"),
    ]
    menu_extra = [
        (10, "ts:run_if"),
        (11, "ts:run_as"),
        (12, "ts:run_after"),
        (13, "ts:menu/close"),
    ]
    if has_dialog:
        use_extra.append((15, "ts:dialog/open_dynamic"))
        menu_extra.append((14, "ts:dialog/open_dynamic"))

    def _extra_lines(options):
        return "".join(
            f"execute if score #sel tunnelscript.vars matches {n} run function {fnid}\n"
            for n, fnid in options
        )

    # Selection dispatcher shared logic, generated for both triggers.
    def dispatch_body(objective, reenable="always", extra=()):
        # reenable="always": re-arm the trigger for everyone (general API).
        # reenable="tsMenuOpen": only re-arm while the player keeps the menu open.
        if reenable == "always":
            rearm = f"scoreboard players enable @s {objective}\n"
        else:
            rearm = (f"execute if entity @s[tag={reenable}] run "
                     f"scoreboard players enable @s {objective}\n")
        return f"""\
execute store result score #sel tunnelscript.vars run scoreboard players get @s {objective}
scoreboard players set @s {objective} 0
{rearm}execute if score #sel tunnelscript.vars matches 1 run function ts:version
execute if score #sel tunnelscript.vars matches 2 run function ts:help
execute if score #sel tunnelscript.vars matches 3 run function ts:run
execute if score #sel tunnelscript.vars matches 4 run function ts:run_command
execute if score #sel tunnelscript.vars matches 5 run function ts:run_commands
execute if score #sel tunnelscript.vars matches 6 run function ts:run_function
execute if score #sel tunnelscript.vars matches 7 run function ts:run_functions
execute if score #sel tunnelscript.vars matches 8 run function ts:config/get
execute if score #sel tunnelscript.vars matches 9 run function ts:config/reset
""" + _extra_lines(extra)

    write(root, f"{core}/internal/menu_dispatch.mcfunction", """\
# Runs as the selecting player. Reads the chosen option, resets and re-arms the
# trigger, then routes to the matching public ts: function. The menu stays open.
# The "open menu" option is omitted here (you are already in it), so the high
# values are: 10 run_if, 11 run_as, 12 run_after, 13 menu/close, 14 dialog*.
# (* dialog entry exists on the 1.21.6 build only)
""" + dispatch_body("tunnelScript.menu", reenable="tsMenuOpen", extra=menu_extra))

    write(root, f"{core}/internal/trigger_dispatch.mcfunction", """\
# Runs as the triggering player. Reads the selected value, resets the trigger,
# then routes to the matching public ts: function.
#   1 -> ts:version          6 -> ts:run_function     11 -> ts:run_as
#   2 -> ts:help             7 -> ts:run_functions    12 -> ts:run_after
#   3 -> ts:run              8 -> ts:config/get        13 -> ts:menu
#   4 -> ts:run_command      9 -> ts:config/reset      14 -> ts:menu/close
#   5 -> ts:run_commands    10 -> ts:run_if           15 -> ts:dialog/open_dynamic*
# (* dialog entry exists on the 1.21.6 build only)
""" + dispatch_body("tunnelScript.use", extra=use_extra))

    # ------------------------------------------------------------------
    # Core: cooldown guard (returns 1 = allowed, 0 = cooling down)
    # ------------------------------------------------------------------
    write(root, f"{core}/internal/guard.mcfunction", """\
# Cooldown gate. Returns 1 when execution is permitted, 0 while cooling down.
# A cooldown_max of 0 (or less) disables the gate entirely.
execute if score #cooldown_max tunnelscript.vars matches ..0 run return 1
execute store result score #now tunnelscript.vars run time query gametime
scoreboard players operation #elapsed tunnelscript.vars = #now tunnelscript.vars
scoreboard players operation #elapsed tunnelscript.vars -= #last_run tunnelscript.vars
execute if score #elapsed tunnelscript.vars < #cooldown_max tunnelscript.vars run return 0
scoreboard players operation #last_run tunnelscript.vars = #now tunnelscript.vars
return 1
""")

    # ------------------------------------------------------------------
    # Core: internal command/function macro handlers
    # ------------------------------------------------------------------
    # The single command macro. Internal on purpose: external packs reach it
    # through the ts: public API. "command", "cmd" and "func" are accepted as
    # action "type" aliases for the exact same behaviour (typo tolerant).
    for alias in ("command", "cmd", "func"):
        write(root, f"{core}/handlers/{alias}.mcfunction", f"""\
# Internal command macro ({alias} alias).
# Executes the raw command string carried in the "value" field.
$$(value)
""")

    # No-argument function action.
    write(root, f"{core}/handlers/function.mcfunction", """\
# Internal function macro. Runs a function id with no arguments.
$function $(func)
""")

    # Function action with arguments. The action element provides:
    #   func -> function id, with -> source kind (storage/entity/block), val -> source id
    write(root, f"{core}/handlers/function_with.mcfunction", """\
# Internal function macro with an argument source.
$function $(func) with $(with) $(val)
""")

    # Generic "<keyword> <arg>" builder used by every multi/* wrapper.
    write(root, f"{core}/handlers/multi_one.mcfunction", """\
# Internal builder macro: emits "<keyword> <arg>" as a single command.
$$(keyword) $(arg)
""")

    # Public single-function macro requested as: $function $(func) with $(type) $(val)
    write(root, f"{core}/handlers/run_function.mcfunction", """\
# Internal macro backing ts:run_function.
$function $(func) with $(type) $(val)
""")

    # Per-command handlers so any command name can be used as an action "type"
    # in ts:run. Each emits "<command> <value>" from the action element.
    # Example: { "type": "give", "value": "@p minecraft:diamond 64" }
    for command in MULTI_COMMANDS:
        write(root, f"{core}/handlers/{command}.mcfunction", f"""\
# Internal action handler for the "{command}" command.
# Emits "{command} <value>" from the action element's "value" field.
${command} $(value)
""")

    # ------------------------------------------------------------------
    # Core: iterators (single bounded pass, no looping)
    # ------------------------------------------------------------------
    write(root, f"{core}/internal/iterate.mcfunction", """\
# Processes storage tunnelscript_core:work actions[] exactly once.
# Stops when the list is empty or the per-run action budget is exhausted.
# This is a finite recursion over a shrinking list, never an auto-repeat.
execute unless data storage tunnelscript_core:work actions[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
data modify storage tunnelscript_core:work current set from storage tunnelscript_core:work actions[0]
data remove storage tunnelscript_core:work actions[0]
scoreboard players remove #counter tunnelscript.vars 1
function tunnelscript_core:internal/dispatch with storage tunnelscript_core:work current
function tunnelscript_core:internal/iterate
""")

    write(root, f"{core}/internal/dispatch.mcfunction", """\
# Routes one action element to handlers/<type>, forwarding the element as args.
# Adding a new action type is as simple as adding a new handler file.
$function tunnelscript_core:handlers/$(type) with storage tunnelscript_core:work current
""")

    write(root, f"{core}/internal/run_commands_iter.mcfunction", """\
# Runs storage tunnelscript_core:work clist[] (raw command strings) once each.
execute unless data storage tunnelscript_core:work clist[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
data modify storage tunnelscript_core:work cone set value {}
data modify storage tunnelscript_core:work cone.value set from storage tunnelscript_core:work clist[0]
data remove storage tunnelscript_core:work clist[0]
scoreboard players remove #counter tunnelscript.vars 1
function tunnelscript_core:handlers/cmd with storage tunnelscript_core:work cone
function tunnelscript_core:internal/run_commands_iter
""")

    write(root, f"{core}/internal/run_functions_iter.mcfunction", """\
# Runs storage tunnelscript_core:work flist[] (function ids) once each.
execute unless data storage tunnelscript_core:work flist[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
data modify storage tunnelscript_core:work fone set value {}
data modify storage tunnelscript_core:work fone.func set from storage tunnelscript_core:work flist[0]
data remove storage tunnelscript_core:work flist[0]
scoreboard players remove #counter tunnelscript.vars 1
function tunnelscript_core:handlers/function with storage tunnelscript_core:work fone
function tunnelscript_core:internal/run_functions_iter
""")

    write(root, f"{core}/internal/multi_iter.mcfunction", """\
# Applies storage tunnelscript_core:work keyword to every entry of vlist[] once.
execute unless data storage tunnelscript_core:work vlist[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
data modify storage tunnelscript_core:work mone set value {}
data modify storage tunnelscript_core:work mone.keyword set from storage tunnelscript_core:work keyword
data modify storage tunnelscript_core:work mone.arg set from storage tunnelscript_core:work vlist[0]
data remove storage tunnelscript_core:work vlist[0]
scoreboard players remove #counter tunnelscript.vars 1
function tunnelscript_core:handlers/multi_one with storage tunnelscript_core:work mone
function tunnelscript_core:internal/multi_iter
""")

    # ------------------------------------------------------------------
    # Public API (ts namespace)
    # ------------------------------------------------------------------
    write(root, f"{api}/run.mcfunction", """\
# Public entry point. Processes a typed action list once (cooldown gated).
# Input: storage tunnelscript:in
#   { "actions": [
#       { "type": "cmd",           "value": "say hello" },
#       { "type": "function",      "func": "namespace:path" },
#       { "type": "function_with", "func": "namespace:path", "with": "storage", "val": "namespace:args" },
#       { "type": "give",          "value": "..." }   // any handler name works as a type
#   ] }
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work actions set from storage tunnelscript:in actions
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/iterate
return 1
""")

    write(root, f"{api}/run_command.mcfunction", """\
# Run a single command. Input: storage tunnelscript:in
#   { "command": "say hi" }   // "cmd" and "func" are accepted aliases too
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work one set value {}
execute if data storage tunnelscript:in command run data modify storage tunnelscript_core:work one.value set from storage tunnelscript:in command
execute if data storage tunnelscript:in cmd run data modify storage tunnelscript_core:work one.value set from storage tunnelscript:in cmd
execute if data storage tunnelscript:in func run data modify storage tunnelscript_core:work one.value set from storage tunnelscript:in func
function tunnelscript_core:handlers/cmd with storage tunnelscript_core:work one
return 1
""")

    write(root, f"{api}/run_commands.mcfunction", """\
# Run many commands in one pass. Input: storage tunnelscript:in
#   { "commands": [ "say one", "say two", "say three" ] }
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work clist set from storage tunnelscript:in commands
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/run_commands_iter
return 1
""")

    write(root, f"{api}/run_function.mcfunction", """\
# Run a single function with an argument source.
# Input: storage tunnelscript:in
#   { "func": "namespace:path", "type": "storage", "val": "namespace:args" }
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
function tunnelscript_core:handlers/run_function with storage tunnelscript:in
return 1
""")

    write(root, f"{api}/run_functions.mcfunction", """\
# Run many functions (no arguments) in one pass. Input: storage tunnelscript:in
#   { "functions": [ "ns:a", "ns:b", "ns:c" ] }
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work flist set from storage tunnelscript:in functions
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/run_functions_iter
return 1
""")

    # Generated multi/* convenience wrappers.
    for command in MULTI_COMMANDS:
        write(root, f"{api}/multi/{command}.mcfunction", f"""\
# Run "{command}" once per argument string. Input: storage tunnelscript:in
#   {{ "values": [ "<args>", "<args>" ] }}
# Example arg for give: "@p minecraft:diamond 64"
execute store result score #allowed tunnelscript.vars run function tunnelscript_core:internal/guard
execute if score #allowed tunnelscript.vars matches 0 run return 0
data modify storage tunnelscript_core:work keyword set value "{command}"
data modify storage tunnelscript_core:work vlist set from storage tunnelscript:in values
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
function tunnelscript_core:internal/multi_iter
return 1
""")

    # Configuration API. Feedback messages use text components encoded per the
    # target's text format (JSON up to 1.21.4, SNBT from 1.21.5).
    cooldown_msg = tc([
        {"text": "[TunnelScript] cooldown = ", "color": "aqua"},
        {"score": {"name": "#cooldown_max", "objective": "tunnelscript.vars"}, "color": "white"},
        {"text": " ticks", "color": "gray"},
    ])
    write(root, f"{api}/config/set_cooldown.mcfunction", f"""\
# Set the run cooldown in game ticks (0 disables it).
# Input: storage tunnelscript:in {{ "ticks": 20 }}
execute store result score #cooldown_max tunnelscript.vars run data get storage tunnelscript:in ticks
tellraw @s {cooldown_msg}
""")

    maxactions_msg = tc([
        {"text": "[TunnelScript] max_actions = ", "color": "aqua"},
        {"score": {"name": "#max_actions", "objective": "tunnelscript.vars"}, "color": "white"},
    ])
    write(root, f"{api}/config/set_max_actions.mcfunction", f"""\
# Set the maximum number of actions processed per run (safety cap).
# Input: storage tunnelscript:in {{ "value": 256 }}
execute store result score #max_actions tunnelscript.vars run data get storage tunnelscript:in value
tellraw @s {maxactions_msg}
""")

    reset_msg = tc({"text": "[TunnelScript] configuration reset to defaults", "color": "green"})
    write(root, f"{api}/config/reset.mcfunction", f"""\
# Restore the default configuration (cooldown off, 256 actions per run).
scoreboard players set #cooldown_max tunnelscript.vars 0
scoreboard players set #max_actions tunnelscript.vars 256
tellraw @s {reset_msg}
""")

    get_msg = tc([
        {"text": "[TunnelScript] cooldown=", "color": "aqua"},
        {"score": {"name": "#cooldown_max", "objective": "tunnelscript.vars"}, "color": "white"},
        {"text": "  max_actions=", "color": "aqua"},
        {"score": {"name": "#max_actions", "objective": "tunnelscript.vars"}, "color": "white"},
    ])
    write(root, f"{api}/config/get.mcfunction", f"""\
# Print the active configuration to the executing player.
tellraw @s {get_msg}
""")

    # ------------------------------------------------------------------
    # New in 1.0.4: conditional / targeted / delayed runs.
    # All three are single bounded passes -- no looping is introduced.
    # ------------------------------------------------------------------

    # ts:run_if -- run an action list only when a condition holds.
    # Input: storage tunnelscript:in
    #   { "if": "<execute sub-clause>", "actions": [ ... ] }
    # The "if" string is whatever you would write after "execute if/unless",
    # e.g. "score @s deaths matches 1.." or "block ~ ~-1 ~ minecraft:stone".
    write(root, f"{core}/handlers/run_if.mcfunction", """\
# Internal macro: run ts:run only when the condition passes.
$execute if $(if) run function ts:run
""")
    write(root, f"{api}/run_if.mcfunction", """\
# Run an action list only if a condition holds. Input: storage tunnelscript:in
#   { "if": "score @s ts.x matches 1..", "actions": [ {"type":"cmd","value":"say ok"} ] }
# "if" is the text you would put after "execute if" (use "unless ..." to negate).
function tunnelscript_core:handlers/run_if with storage tunnelscript:in
""")

    # ts:run_as -- run an action list as/at the selected entities.
    # Input: storage tunnelscript:in
    #   { "selector": "@a", "actions": [ ... ] }
    write(root, f"{core}/handlers/run_as.mcfunction", """\
# Internal macro: run ts:run as and at each selected entity.
$execute as $(selector) at @s run function ts:run
""")
    write(root, f"{api}/run_as.mcfunction", """\
# Run an action list as/at selected entities. Input: storage tunnelscript:in
#   { "selector": "@a", "actions": [ {"type":"cmd","value":"effect give @s glowing"} ] }
# Each matched entity runs the same action list once (as @s, at its position).
function tunnelscript_core:handlers/run_as with storage tunnelscript:in
""")

    # ts:run_after -- run an action list after a delay (single shot, not a loop).
    # Input: storage tunnelscript:in
    #   { "delay": "20t", "actions": [ ... ] }
    # The action list is captured into a holding storage so a later input does
    # not overwrite the queued one, then scheduled with /schedule (one-shot).
    write(root, f"{core}/handlers/run_after.mcfunction", """\
# Internal macro: schedule the deferred runner after the given delay.
# This uses /schedule for a single future run; it never reschedules itself.
$schedule function tunnelscript_core:internal/run_deferred $(delay)
""")
    write(root, f"{core}/internal/run_deferred.mcfunction", """\
# Deferred one-shot: move the queued actions into the live input and run once.
data modify storage tunnelscript:in actions set from storage tunnelscript_core:later actions
function ts:run
""")
    write(root, f"{api}/run_after.mcfunction", """\
# Run an action list after a delay (single shot). Input: storage tunnelscript:in
#   { "delay": "20t", "actions": [ {"type":"cmd","value":"say later"} ] }
# "delay" is a /schedule time like "20t", "5s" or "1d". Only the most recently
# scheduled list is kept. This is one-shot -- it does not repeat.
data modify storage tunnelscript_core:later actions set from storage tunnelscript:in actions
function tunnelscript_core:handlers/run_after with storage tunnelscript:in
""")

    # ------------------------------------------------------------------
    # New in 1.0.4: ts_util namespace -- small, reusable helpers other packs
    # can call directly. These are plain utilities, not part of the action
    # pipeline. All write their results into the shared "tunnelscript.vars"
    # objective or into storage tunnelscript:out.
    # ------------------------------------------------------------------
    util = f"data/ts_util/{fn}"

    # --- math helpers ---
    write(root, f"{util}/math/clamp.mcfunction", """\
# Clamp #in into [#min, #max] (objective tunnelscript.vars); result in #out.
# Set #in, #min and #max on tunnelscript.vars before calling.
scoreboard players operation #out tunnelscript.vars = #in tunnelscript.vars
execute if score #out tunnelscript.vars < #min tunnelscript.vars run scoreboard players operation #out tunnelscript.vars = #min tunnelscript.vars
execute if score #out tunnelscript.vars > #max tunnelscript.vars run scoreboard players operation #out tunnelscript.vars = #max tunnelscript.vars
""")
    write(root, f"{util}/math/min.mcfunction", """\
# #out = min(#a, #b) on tunnelscript.vars.
scoreboard players operation #out tunnelscript.vars = #a tunnelscript.vars
execute if score #b tunnelscript.vars < #out tunnelscript.vars run scoreboard players operation #out tunnelscript.vars = #b tunnelscript.vars
""")
    write(root, f"{util}/math/max.mcfunction", """\
# #out = max(#a, #b) on tunnelscript.vars.
scoreboard players operation #out tunnelscript.vars = #a tunnelscript.vars
execute if score #b tunnelscript.vars > #out tunnelscript.vars run scoreboard players operation #out tunnelscript.vars = #b tunnelscript.vars
""")
    write(root, f"{util}/math/abs.mcfunction", """\
# #out = |#in| on tunnelscript.vars.
scoreboard players operation #out tunnelscript.vars = #in tunnelscript.vars
execute if score #out tunnelscript.vars matches ..-1 run scoreboard players operation #out tunnelscript.vars *= #neg_one tunnelscript.vars
""")
    write(root, f"{util}/math/random.mcfunction", """\
# #out = a random integer in [#min, #max] on tunnelscript.vars.
execute store result score #out tunnelscript.vars run random value 0..2147483646
scoreboard players operation #span tunnelscript.vars = #max tunnelscript.vars
scoreboard players operation #span tunnelscript.vars -= #min tunnelscript.vars
scoreboard players add #span tunnelscript.vars 1
scoreboard players operation #out tunnelscript.vars %= #span tunnelscript.vars
scoreboard players operation #out tunnelscript.vars += #min tunnelscript.vars
""")

    # --- entity/player helpers ---
    write(root, f"{util}/entity/count.mcfunction", """\
# Count entities matching a selector into #out (tunnelscript.vars).
# Input: storage tunnelscript:in { "selector": "@e[type=zombie]" }
function tunnelscript_core:handlers/util_count with storage tunnelscript:in
""")
    write(root, f"{core}/handlers/util_count.mcfunction", """\
# Internal macro backing ts_util:entity/count.
$execute store result score #out tunnelscript.vars if entity $(selector)
""")
    write(root, f"{util}/entity/tag_area.mcfunction", """\
# Add a tag to every entity in a radius around the caller.
# Input: storage tunnelscript:in { "selector": "@e[distance=..5]", "tag": "near" }
function tunnelscript_core:handlers/util_tag_area with storage tunnelscript:in
""")
    write(root, f"{core}/handlers/util_tag_area.mcfunction", """\
# Internal macro backing ts_util:entity/tag_area.
$tag $(selector) add $(tag)
""")

    # --- text/format helpers ---
    # join: write storage tunnelscript:in list[] joined by a separator into
    # storage tunnelscript:out joined (as a string). Bounded single pass.
    write(root, f"{util}/text/join.mcfunction", """\
# Join storage tunnelscript:in list[] (strings) into storage tunnelscript:out
# joined, separated by storage tunnelscript:in sep. Bounded by #max_actions.
data modify storage tunnelscript:out joined set value ""
data modify storage tunnelscript_core:work jlist set from storage tunnelscript:in list
data modify storage tunnelscript_core:work jsep set from storage tunnelscript:in sep
scoreboard players operation #counter tunnelscript.vars = #max_actions tunnelscript.vars
scoreboard players set #jfirst tunnelscript.vars 1
function tunnelscript_core:internal/join_iter
""")
    write(root, f"{core}/internal/join_iter.mcfunction", """\
# Internal: consume jlist[] one item at a time, appending to out.joined.
execute unless data storage tunnelscript_core:work jlist[0] run return 0
execute if score #counter tunnelscript.vars matches ..0 run return 0
scoreboard players remove #counter tunnelscript.vars 1
data modify storage tunnelscript_core:work jone set from storage tunnelscript_core:work jlist[0]
data remove storage tunnelscript_core:work jlist[0]
execute if score #jfirst tunnelscript.vars matches 0 run function tunnelscript_core:handlers/join_sep with storage tunnelscript_core:work
scoreboard players set #jfirst tunnelscript.vars 0
function tunnelscript_core:handlers/join_one with storage tunnelscript_core:work
function tunnelscript_core:internal/join_iter
""")
    write(root, f"{core}/handlers/join_sep.mcfunction", """\
# Internal macro: append the separator to out.joined.
$data modify storage tunnelscript:out joined set value "$(jsep)"
""")
    write(root, f"{core}/handlers/join_one.mcfunction", """\
# Internal macro: append one item to out.joined.
$data modify storage tunnelscript:out joined set value "$(jone)"
""")

    # --- data/storage helpers ---
    write(root, f"{util}/data/list_length.mcfunction", """\
# Store the length of storage tunnelscript:in list[] into #out (tunnelscript.vars).
execute store result score #out tunnelscript.vars run data get storage tunnelscript:in list
""")
    write(root, f"{util}/data/copy.mcfunction", """\
# Copy storage tunnelscript:in from_path -> storage tunnelscript:out value.
# Input: storage tunnelscript:in { "from": <any data>, ... } ; result in :out copied.
data modify storage tunnelscript:out copied set from storage tunnelscript:in from
""")

    # --- time/cooldown helpers ---
    write(root, f"{util}/time/gametime.mcfunction", """\
# Store the world game time (ticks) into #out (tunnelscript.vars).
execute store result score #out tunnelscript.vars run time query gametime
""")
    write(root, f"{util}/time/daytime.mcfunction", """\
# Store the time of day (0..23999) into #out (tunnelscript.vars).
execute store result score #out tunnelscript.vars run time query daytime
""")

    # Sidebar menu controls. The menu is built lazily here on first use, so
    # nothing is created or shown until a player actually runs ts:menu.
    write(root, f"{api}/menu.mcfunction", """\
# Open the TunnelScript sidebar menu. No tellraw / chat spam is used; the menu
# lives in the sidebar display slot. Pick an option with:
#   /trigger tunnelScript.menu set <n>
# Close it again with: function ts:menu/close
# Build the menu UI only the first time it is opened (idempotent thereafter).
execute unless score #menu_built tunnelscript.vars matches 1 run function tunnelscript_core:internal/menu_build
execute unless score #menu_built tunnelscript.vars matches 1 run scoreboard players set #menu_built tunnelscript.vars 1
# Tag this player as "menu open" so the menu trigger is enabled for them only.
# ts:menu/close removes the tag and disables the trigger again.
tag @s add tsMenuOpen
scoreboard players enable @s tunnelScript.menu
scoreboard objectives setdisplay sidebar tunnelscript.menu_ui
""")

    write(root, f"{api}/menu/close.mcfunction", """\
# Hide the sidebar menu (clears the sidebar display slot) and disable the menu
# trigger for this player (tag removed -> trigger off, per the tick gate).
tag @s remove tsMenuOpen
scoreboard players reset @s tunnelScript.menu
scoreboard objectives setdisplay sidebar
""")

    write(root, f"{api}/menu/rebuild.mcfunction", """\
# Rebuild and re-open the menu (useful after changing language/labels).
function tunnelscript_core:internal/menu_build
scoreboard players set #menu_built tunnelscript.vars 1
scoreboard objectives setdisplay sidebar tunnelscript.menu_ui
""")

    # ------------------------------------------------------------------
    # Dialog system (1.21.6+ only). Uses the /dialog command to show modal
    # menus that can collect input. Two modes:
    #   * registered:  /dialog show <targets> <namespace:path>
    #   * inline/dynamic: /dialog show <targets> <inline JSON definition>
    # The inline mode is what makes menus dynamic -- titles, bodies, lists and
    # buttons can be built at runtime (e.g. for language support) instead of
    # being fixed in a ns:path file.
    # ------------------------------------------------------------------
    if has_dialog:
        # Macro requested by the spec. Players opted in carry the tag
        # "_dialogMenu.open"; the dialog (a registered id or an inline
        # definition) is substituted from the action's "dialog" field.
        write(root, f"{core}/handlers/dialog.mcfunction", """\
# Internal dialog macro (1.21.6+). Shows $(dialog) -- a registered id or an
# inline definition -- to every player tagged _dialogMenu.open.
$dialog show @a[tag=_dialogMenu.open] $(dialog)
""")

        # Macro for showing to a specific @s (used by the per-player API).
        write(root, f"{core}/handlers/dialog_self.mcfunction", """\
# Internal dialog macro: show $(dialog) to the executing player.
$dialog show @s $(dialog)
""")

        # Public: show a dialog to every player tagged _dialogMenu.open.
        # Recommended: pass an inline SNBT definition (robust, no experimental
        # warning). A registered "ns:path" also works but is fragile.
        # (Opt in with: tag <player> add _dialogMenu.open)
        write(root, f"{api}/dialog/open_group.mcfunction", """\
# Show a dialog to every player tagged _dialogMenu.open. Input:
#   storage tunnelscript:in { "dialog": { "type": ... } }   (inline, recommended)
#   storage tunnelscript:in { "dialog": "ns:path" }          (registered, fragile)
# Tip: point dialog buttons at "/trigger tunnelScript.use set <n>" so non-op
# players get no confirmation prompt (trigger is permission level 0).
function tunnelscript_core:handlers/dialog with storage tunnelscript:in
""")

        # Public: dynamic dialog for the runner. The caller supplies a full
        # inline SNBT definition in storage tunnelscript:in "dialog", enabling
        # runtime titles/bodies/lists/buttons and easy localization. Inline is
        # preferred over a registered ns:path: it cannot break if a ts:* dialog
        # file is removed, and it avoids the experimental-feature warning.
        write(root, f"{api}/dialog/open_dynamic.mcfunction", """\
# Open a dialog for the runner. Input: storage tunnelscript:in
#   { "dialog": { "type":"minecraft:multi_action", "title":"...", ... } }
# The "dialog" value is an inline dialog definition, so titles, bodies, lists
# and buttons can be built at runtime (great for translations). Inline SNBT is
# recommended over a registered { "dialog": "ns:path" } (which is fragile).
# Tip: dialog buttons running "/trigger tunnelScript.use set <n>" need no
# confirmation (trigger is permission level 0, open to all players).
function tunnelscript_core:handlers/dialog_self with storage tunnelscript:in
""")

        write(root, f"{api}/dialog/close.mcfunction", """\
# Close any open dialog for the runner.
dialog clear @s
""")

        # Bridge: close the sidebar menu (via ts:menu/close) and then open the
        # dialog window. Handy for jumping from the sidebar into a /dialog.
        # Provide the dialog in storage tunnelscript:in "dialog" first.
        # Build a self-contained dialog whose buttons mirror the whole sidebar
        # menu. This does NOT depend on storage tunnelscript:in -- it carries its
        # own definition, so it works even if no dialog was set up beforehand.
        td_actions = [
            {
                "label": f"[{n}] {name}",
                "action": {
                    "type": "minecraft:run_command",
                    "command": f"/trigger tunnelScript.use set {n}",
                },
            }
            for n, name in menu_options
        ]
        td_dialog = {
            "type": "minecraft:multi_action",
            "title": "TunnelScript",
            "body": [{"type": "minecraft:plain_message", "contents": "Choose an action:"}],
            "pause": False,
            "columns": 2,
            "actions": td_actions,
        }
        write(root, f"{api}/menu/to_dialog.mcfunction", f"""\
# Close the sidebar menu, then open a self-contained dialog that mirrors every
# sidebar option. Buttons use /trigger tunnelScript.use (permission level 0), so
# no operator status and no confirmation prompt are needed. This carries its own
# dialog definition and does not read storage tunnelscript:in.
function ts:menu/close
dialog show @s {tc(td_dialog)}
""")

    # Help and version.
    version_msg = tc([
        {"text": "TunnelScript ", "color": "aqua", "bold": True},
        {"text": f"v{VERSION}", "color": "white"},
        {"text": f" ({label})", "color": "gray"},
    ])
    write(root, f"{api}/version.mcfunction", f"""\
# Print the installed version.
tellraw @s {version_msg}
""")

    help_lines = [
        {"text": "TunnelScript - public API", "color": "aqua", "bold": True},
        {"text": "ts:run            -> process { actions:[...] } from storage tunnelscript:in", "color": "gray"},
        {"text": "ts:run_command    -> { command|cmd|func }", "color": "gray"},
        {"text": "ts:run_commands   -> { commands:[...] }", "color": "gray"},
        {"text": "ts:run_function   -> { func, type, val }", "color": "gray"},
        {"text": "ts:run_functions  -> { functions:[...] }", "color": "gray"},
        {"text": "ts:multi/<command>-> { values:[...] }", "color": "gray"},
        {"text": "ts:run_if         -> { if, actions:[...] }   (1.0.4)", "color": "gray"},
        {"text": "ts:run_as         -> { selector, actions:[...] } (1.0.4)", "color": "gray"},
        {"text": "ts:run_after      -> { delay, actions:[...] }  (1.0.4)", "color": "gray"},
        {"text": "ts:config/*       -> set_cooldown, set_max_actions, get, reset", "color": "gray"},
        {"text": "ts:menu           -> open sidebar menu  (ts:menu/close to hide)", "color": "gray"},
        {"text": "ts:hologram/*     -> spawn, remove, set_name (in-world marker label)", "color": "gray"},
        {"text": "ts_util:*         -> math, entity, text, data, time helpers (1.0.4)", "color": "gray"},
        {"text": "/trigger tunnelScript.use set <n>  -> run option directly", "color": "gray"},
        {"text": "/trigger tunnelScript.menu set <n> -> run option from the open menu", "color": "gray"},
        {"text": "   1 version, 2 help, 3 run, 4 run_command, 5 run_commands,", "color": "gray"},
        {"text": "   6 run_function, 7 run_functions, 8 config/get, 9 config/reset", "color": "gray"},
    ]
    if has_dialog:
        help_lines.append({"text": "ts:dialog/*       -> open_dynamic, open_group, close (1.21.6 /dialog)", "color": "gray"})
    help_body = "# Print a short overview of the public API.\n"
    help_body += "".join(f"tellraw @s {tc(line)}\n" for line in help_lines)
    write(root, f"{api}/help.mcfunction", help_body)

    print(f"Built TunnelScript {VERSION} for {label} "
          f"(pack_format {pack_format}, dir '{fn}', text {cfg['text']}).")


def main():
    if len(sys.argv) != 2 or sys.argv[1] not in TARGETS:
        print(__doc__)
        sys.exit(1)
    build(sys.argv[1])


if __name__ == "__main__":
    main()
