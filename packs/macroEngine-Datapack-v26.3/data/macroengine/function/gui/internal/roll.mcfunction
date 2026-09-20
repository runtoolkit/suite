# macro: $(max)   inclusive upper bound, e.g. max:99 -> 0..99 (100 outcomes)
$execute store result score #roll macroengine.gui_tmp run random value 0..$(max)
