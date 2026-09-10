# RTWrapper generated zero-parameter variant for /save-off.
# NOTE: /save-off is a dedicated-server-console-only command in vanilla Minecraft
# (same restriction as command blocks: /ban, /banlist, /ban-ip, /debug, /deop,
# /kick, /op, /pardon, /pardon-ip, /publish, /reload, /save-all, /save-off,
# /save-on, /stop, /whitelist). It cannot be run from inside a .mcfunction file
# or via /function, only typed directly into the server console.
# This wrapper intentionally reports failure instead of loading a broken command.
# # tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper] ","color":"red"},{"text":"/save-off cannot run from a datapack function (server-console-only command).","color":"gray"}]
