# ─────────────────────────────────────────────────────────────────
# macroengine:systems/string/truncate
# Displays text in the named player's actionbar, optionally with a
# suffix to indicate truncation. The caller decides whether the text
# needs truncating and passes truncated:1b or truncated:0b.
# Because mcfunction cannot measure string byte-length at runtime,
# length-checking must be done externally.
#
# INPUT : $(player)    → player name
#         $(text)      → string to display
#         $(suffix)    → suffix shown when truncated (e.g. "...")
#         $(truncated) → 1b = append suffix, 0b = show as-is
# OUTPUT: macroengine:output text → stored original text
#
# EXAMPLE:
# function macroengine:systems/string/truncate {player:"Steve",text:"Hello Wor",suffix:"...",truncated:1b}
# → actionbar: "Hello Wor..."
# ─────────────────────────────────────────────────────────────────

$data modify storage macroengine:output text set value $(text)
$data modify storage macroengine:engine _trunc_t set value $(truncated)

scoreboard players set #trunc_flag macroengine.tmp 0
execute store result score #trunc_flag macroengine.tmp run data get storage macroengine:engine _trunc_t

$execute if score #trunc_flag macroengine.tmp matches 0 run title @a[name=$(player),limit=1] actionbar {"plain":true ,"storage":"macroengine:output","nbt":"text"}
$execute if score #trunc_flag macroengine.tmp matches 1.. run title @a[name=$(player),limit=1] actionbar ["",{"plain":true ,"storage":"macroengine:output","nbt":"text"},{"text":"$(suffix)","color":"gray"}]

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"string/truncate ","color":"aqua"},{"text":"$(player) truncated=$(truncated)","color":"gray"}]
