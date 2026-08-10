# Revoke permission to use the gated dangerous actions from the calling
# entity.
tag @s remove tunnelscript.trusted
tellraw @s ["",{"text":"[TunnelScript] ","color":"aqua"},{"text":"Revoked: gated actions are now blocked for you.","color":"gray"}]
