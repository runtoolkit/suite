# ─────────────────────────────────────────────────────────────────
# macroengine:systems/string/pluralize
# Stores the singular or plural form of a word based on count.
# Simple English rule: count == 1 → singular, else → plural.
#
# INPUT : $(count) → integer count
# $(singular) → singular form (e.g. "item")
# $(plural) → plural form (e.g. "items")
# OUTPUT: macroengine:output result → chosen string
# macroengine:output count → original count
#
# EXAMPLE:
# function macroengine:systems/string/pluralize {count:3,singular:"apple",plural:"apples"}
# → macroengine:output result = "apples"
# ─────────────────────────────────────────────────────────────────

$scoreboard players set #plr_c macroengine.tmp $(count)
execute store result storage macroengine:output count int 1 run scoreboard players get #plr_c macroengine.tmp

$data modify storage macroengine:engine _plr_singular set value $(singular)
$data modify storage macroengine:engine _plr_plural set value $(plural)

data modify storage macroengine:output result set from storage macroengine:engine _plr_plural
execute if score #plr_c macroengine.tmp matches 1 run data modify storage macroengine:output result set from storage macroengine:engine _plr_singular

$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"string/pluralize ","color":"aqua"},{"text":"count=$(count) → ","color":"gray"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"}]
