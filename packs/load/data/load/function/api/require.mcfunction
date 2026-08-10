# RunLoad — api/require  (requires Minecraft 1.20.2+ for macro support)
#
# Checks whether a pack's load.status score meets a minimum version threshold.
#
# INPUT  (call via: function load:api/require with storage load:input {pack:"name",min:1})
#   storage load:input  pack  — fake player name to check (string)
#   storage load:input  min   — minimum acceptable score  (int, default 1)
#
# OUTPUT
#   storage load:output require.success  — 1b if pack score >= min, 0b otherwise
#   scoreboard #runload.require load.init — mirrors result as score (1 / 0)
#
$execute if score $(pack) load.status matches $(min).. \
  run data modify storage load:output require.success set value 1b
$execute unless score $(pack) load.status matches $(min).. \
  run data modify storage load:output require.success set value 0b
