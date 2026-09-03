# macroengine:api/wand/internal/call_cmd [MACRO]

# SECURITY: central gate — see core/internal/security/check_all.
# No-op (always passes) unless flags.experimental.strict_gating is on.
# NOTE: `function <name> {args}` can only appear after `run` — it cannot
# sit in an `execute if/unless` condition with inline NBT args, so the
# call and the result check are two separate steps here.
scoreboard players set $wcc_gate macroengine.tmp 1
execute store success score $wcc_gate macroengine.tmp run function macroengine:core/internal/security/check_all {required:"sandbox_cmd_min_level"}
execute if score $wcc_gate macroengine.tmp matches 0 run return 0

tellraw @a[tag=macroengine.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
