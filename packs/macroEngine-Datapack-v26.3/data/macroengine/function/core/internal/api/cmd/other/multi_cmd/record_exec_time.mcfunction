# Record execution time for profiling
execute store result score $mcmd_exec_end macroengine.tmp run time query gametime
scoreboard players operation $mcmd_exec_dur macroengine.tmp = $mcmd_exec_end macroengine.tmp
scoreboard players operation $mcmd_exec_dur macroengine.tmp -= $mcmd_exec_start macroengine.tmp

scoreboard players reset $mcmd_exec_start macroengine.tmp
scoreboard players reset $mcmd_exec_end macroengine.tmp
scoreboard players reset $mcmd_exec_dur macroengine.tmp
