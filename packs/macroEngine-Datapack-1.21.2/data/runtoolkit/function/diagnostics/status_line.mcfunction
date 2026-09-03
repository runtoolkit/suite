# runtoolkit:diagnostics/status_line
# MACRO INPUT (from a registry.subsystems[n] entry):
#   $(name)    -> subsystem id, used to build the score holder "#runtoolkit.packs.$(name).version"
#   $(version) -> the version recorded at registration time (may be stale vs. live score)
#
# Score holder names accept macro substitution directly (no string concat needed).

$execute store result score $diag_ver runtoolkit.tmp run scoreboard players get #runtoolkit.packs.$(name).version macroengine.meta

execute if score $diag_ver runtoolkit.tmp matches 1.. run tellraw @s ["",{"text":"  ","color":"#555555"},{"nbt":"_diag_call.name","storage":"runtoolkit:tmp","color":"white"},{"text":" — ","color":"#555555"},{"text":"loaded","color":"green"},{"text":" (v","color":"#555555"},{"score":{"name":"$diag_ver","objective":"runtoolkit.tmp"},"color":"aqua"},{"text":")","color":"#555555"}]
execute if score $diag_ver runtoolkit.tmp matches ..0 run tellraw @s ["",{"text":"  ","color":"#555555"},{"nbt":"_diag_call.name","storage":"runtoolkit:tmp","color":"white"},{"text":" — ","color":"#555555"},{"text":"disabled","color":"red"}]
