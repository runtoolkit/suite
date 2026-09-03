# runtoolkit:killswitch/all_read_version
# MACRO INPUT: $(name) -> subsystem id
# Reads "#runtoolkit.packs.$(name).version" into score $ks_ver runtoolkit.tmp.
$execute store result score $ks_ver runtoolkit.tmp run scoreboard players get #runtoolkit.packs.$(name).version macroengine.meta
