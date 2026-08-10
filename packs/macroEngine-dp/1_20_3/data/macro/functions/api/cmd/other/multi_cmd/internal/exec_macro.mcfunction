# ─────────────────────────────────────────────────────────────────
# macro:api/cmd/other/multi_cmd/internal/exec_macro [MACRO]
# INPUT: $(cmd)
# ─────────────────────────────────────────────────────────────────

tellraw @a[tag=macro.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
