# ─────────────────────────────────────────────────────────────────
# macroengine:api/jukebox/give
# Gives the caller a music disc item bound to one of macroEngine's
# registered jukebox_song entries via the jukebox_playable component.
# The item itself is a vanilla music_disc (music_disc_11 chosen as a
# neutral base icon/model) — only the song reference is custom.
#
# INPUT : $(song) → "gate_alert" | "sanctuary_ambient"
#
# Usage:
# function macroengine:api/jukebox/give {song:"gate_alert"}
#
# Caller: macroengine.admin tag required
# ─────────────────────────────────────────────────────────────────

execute unless entity @s[tag=macroengine.admin] run return 0

$give @s minecraft:music_disc_11[minecraft:jukebox_playable={song:"macroengine:$(song)"},minecraft:custom_name={"text":"macroEngine Disc — $(song)","italic":false,"color":"aqua"}] 1
$tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"✔ ","color":"green"},{"text":"Gave disc: ","color":"gray"},{"text":"$(song)","color":"yellow"}]
