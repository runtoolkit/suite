# Macro: called with storage rtwrapper:runtime trigger_cur (a single registry entry:
# objective, enabled, reset_mode, action). Executor context (@s) is the polled player.
# Only proceeds if enabled and the executing player HAS a score on that trigger AND it is
# non-zero (i.e. they ran /trigger <objective>). A missing score must not match here -
# `unless score @s <obj> matches 0` would be true both when the score is absent and when
# it's genuinely non-zero, so absence and "not zero" are checked as two separate branches.
execute unless data storage rtwrapper:runtime trigger_cur{enabled:1b} run return 0
$execute if score @s $(objective) matches 1.. run function rtwrapper:core/trigger/poll_fire with storage rtwrapper:runtime trigger_cur
$execute if score @s $(objective) matches ..-1 run function rtwrapper:core/trigger/poll_fire with storage rtwrapper:runtime trigger_cur
