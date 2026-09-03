# macroengine:api/trigger/internal/call2 [MACRO]

# SECURITY: central gate

tellraw @a[tag=macroengine.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
