execute unless function macro:debug/tools/utils/check_all run return 0

# ─────────────────────────────────────────────────────────────────
# SANDBOX GUARD — sandbox modunda tehlikeli komutlar engellenir.
# Aktif:  /data modify storage macro:engine sandbox set value 1b
# Pasif:  /data modify storage macro:engine sandbox set value 0b
# ─────────────────────────────────────────────────────────────────
execute if data storage macro:engine {sandbox:1b} run tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"SANDBOX — cmd/forceload_add engellendi.","color":"red"}]
execute if data storage macro:engine {sandbox:1b} run return 0
execute unless data storage macro:engine {sandbox:1b} run tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"TIP ","color":"yellow","bold":true},{"text":"Sandbox modu önerilir → ","color":"gray"},{"text":"/data modify storage macro:engine sandbox set value 1b","color":"aqua"}]
$forceload add $(x) $(z)
tellraw @a[tag=macro.debug] {"text":"","extra":[{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cmd/forceload_add ","color":"aqua"}]}
