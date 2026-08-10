# macro:api/security/allowlist_add [MACRO] [1.20.5 overlay]
# Adds a command prefix to macro:engine security.sandbox_allowlist (compound).
# Compound format: {give:1b, say:1b, ...} — O(1) lookup.
#
# BREAKING CHANGE (v5.1.0): allowlist is now a compound, not a list.
# INPUT: $(prefix) — command prefix string, e.g. "say" or "give"
$data modify storage macro:engine security.sandbox_allowlist merge value {$(prefix):1b}
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"security/allowlist_add ","color":"aqua"},{"text":"$(prefix)","color":"green"}]
