# runtoolkit:killswitch/all_dispatch
# MACRO INPUT (from a registry entry, via "with"):
#   $(name)       -> subsystem id, for the status line
#   $(disable_fn) -> function id to call, e.g. "macroengine:disable"
# The subsystem's own disable_fn handles its gate/confirmation/cleanup;
# this just triggers it and reports.

tellraw @s ["",{"text":"  ","color":"#555555"},{"nbt":"_ks_call.name","storage":"runtoolkit:tmp","color":"white"},{"text":" — ","color":"#555555"},{"text":"disabling…","color":"gold"}]
$function $(disable_fn)
