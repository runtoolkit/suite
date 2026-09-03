
# DL - World Clock Rate Controller
# BACKPORT NOTE (1.21.2): `/time rate <rate>` (and world clocks in general)
# do not exist in 1.21.2 — added in pack format 101.0 (26.1-pre1). There is
# no 1.21.2 equivalent (world clocks are a distinct, newer time-tracking
# system; plain `/time set`/`/time add` don't take a rate). This is now a
# no-op that only reports the situation to debug-tagged staff.
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"clock/rate_updated ","color":"aqua"},{"text":"skipped: ","color":"red"},{"text":"/time rate is not available on 1.21.2 (backport limitation).","color":"gray"}]
