# Disabled by default. Enable with: function rtwrapper:api/autotick/on
# Autotick intentionally processes only one action per tick. Use rtwrapper:api/run
# when you explicitly want to drain the whole queue immediately.
execute if score #auto_tick rtw.config matches 1.. run function rtwrapper:core/run/run_next
