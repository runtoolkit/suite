# ─────────────────────────────────────────────────────────────────
# macro:api/security/get_level [MACRO]
# Shows a player's current ame.perm_level to debug admins.
#
# INPUT (macro args):
#   $(player) — exact player name
#
# EXAMPLE:
#   function macro:api/security/get_level {player:"Steve"}
# ─────────────────────────────────────────────────────────────────
$execute as @a[name=$(player),limit=1] run tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"security/get_level ","color":"aqua"},{"text":"$(player)","color":"gold"},{"text":" → ","color":"#555555"},{"score":{"name":"@s","objective":"ame.perm_level"},"color":"green"}]
