# macro:api/security/allowlist_add [MACRO]
# Adds a command prefix to macro:engine security.sandbox_allowlist (compound).
# Compound format: {give:1b, say:1b, ...} — O(1) lookup.
#
# BREAKING CHANGE (v5.1.0): allowlist is now a compound, not a list.
# Enforcement is now ACTIVE — unlisted commands in sandbox mode are blocked + kick.
#
# INPUT (macro args):
#   $(prefix) — command prefix string, e.g. "say" or "give"
#
# EXAMPLE:
#   function macro:api/security/allowlist_add {prefix:"say"}
$data modify storage macro:engine security.sandbox_allowlist merge value {$(prefix):1b}
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"security/allowlist_add ","color":"aqua"},{"text":"$(prefix)","color":"green"}]
