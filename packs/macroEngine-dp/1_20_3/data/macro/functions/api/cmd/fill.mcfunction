execute unless function macro:debug/tools/utils/check_all run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — sandbox modunda tehlikeli komutlar engellenir.
# Aktif:  /data modify storage macro:engine sandbox set value 1b
# Pasif:  /data modify storage macro:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage macro:engine {sandbox:1b} run tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"SANDBOX — cmd/fill engellendi.","color":"red"}]
execute if data storage macro:engine {sandbox:1b} run return 0
execute unless data storage macro:engine {sandbox:1b} run tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"TIP ","color":"yellow","bold":true},{"text":"Sandbox modu önerilir → ","color":"gray"},{"text":"/data modify storage macro:engine sandbox set value 1b","color":"aqua"}]
$fill $(x1) $(y1) $(z1) $(x2) $(y2) $(z2) $(block) $(mode)
$tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/fill ","color":"aqua"},{"text":" → ","color":"#555555"},{"text":"$(mode)","color":"aqua"}]}
