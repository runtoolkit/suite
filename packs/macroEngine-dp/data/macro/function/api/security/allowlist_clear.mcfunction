# macro:api/security/allowlist_clear
# Clears the entire sandbox_allowlist (all prefixes blocked in sandbox mode).
data modify storage macro:engine security.sandbox_allowlist set value {}
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"security/allowlist_clear ","color":"aqua"},{"text":"✔ cleared","color":"green"}]
