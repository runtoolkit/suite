# ts_util:math/random is not available on the 1.19.2 build: it relies on function macros,
# which Minecraft only added in 1.20.2. This stub explains the limitation and
# points the player at the 1.21.6 build instead (clickable GitHub link).
tellraw @s [{"text":"[TunnelScript] ","color":"aqua"},{"text":"'ts_util:math/random' needs Minecraft 1.20.2+ (function macros). ","color":"gray"},{"text":"The /random command was added in 1.20.2.  ","color":"gray"},{"text":"Click here for the 1.21.6 build.","color":"yellow","underlined":true,"clickEvent":{"action":"open_url","value":"https://github.com/runtoolkit/TunnelScript/tree/1.21.6"},"hoverEvent":{"action":"show_text","value":[{"text":"https://github.com/runtoolkit/TunnelScript/tree/1.21.6","color":"gray"}]}}]
