# macroengine:systems/color/init
# Called during engine load. Populates the named color lookup table
# at macroengine:engine color._names for O(1) validate checks.
# Also initializes the color namespace in storage.

execute unless data storage macroengine:engine color run data modify storage macroengine:engine color set value {}
execute unless data storage macroengine:engine color.palette run data modify storage macroengine:engine color.palette set value {}
execute unless data storage macroengine:engine color.gradients run data modify storage macroengine:engine color.gradients set value {}

# Named color allowlist — 16 Minecraft text colors
data modify storage macroengine:engine color._names set value {\
 black:1b,\
 dark_blue:1b,\
 dark_green:1b,\
 dark_aqua:1b,\
 dark_red:1b,\
 dark_purple:1b,\
 gold:1b,\
 gray:1b,\
 dark_gray:1b,\
 blue:1b,\
 green:1b,\
 aqua:1b,\
 red:1b,\
 light_purple:1b,\
 yellow:1b,\
 white:1b\
}

tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"color/init ","color":"aqua"},{"text":"named color table loaded (16 entries)","color":"gray"}]
