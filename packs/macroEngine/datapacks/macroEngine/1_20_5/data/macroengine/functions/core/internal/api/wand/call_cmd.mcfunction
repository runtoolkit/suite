# macroengine:api/wand/internal/call_cmd [MACRO]

# SECURITY: central gate

tellraw @a[tag=macroengine.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
