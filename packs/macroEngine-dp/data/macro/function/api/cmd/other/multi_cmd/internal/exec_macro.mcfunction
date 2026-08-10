# ─────────────────────────────────────────────────────────────────
# macro:api/cmd/other/multi_cmd/internal/exec_macro [MACRO]
# INPUT: $(cmd)
# ─────────────────────────────────────────────────────────────────

# SECURITY: central gate — loaded + perm_level + sandbox checks
execute unless function macro:core/security/cmd_gate run return 0

tellraw @a[tag=macro.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
