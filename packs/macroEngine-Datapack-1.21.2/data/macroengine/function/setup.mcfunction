# macroengine:setup
# Manual init entry point. Call with: /function macroengine:setup
# Replaces old LanternMC load-tag dependency. Only this pack's code runs.
# Order: dependencies first → then pack.

# Debug: start
tellraw @a[tag=macroengine.debug] {"text":"[macroengine:setup] Starting setup...","color":"gray"}

# 1) Dependencies – StringLib port
# Note: split / to_lowercase / to_uppercase helpers are broken upstream (see WARNING comments)
tellraw @a[tag=macroengine.debug] {"text":"[macroengine:setup] Loading StringLib (dependency)...","color":"gray"}
function macroengine:core/internal/string/zprivate/load

# 2) Dependencies – PlayerAction port
tellraw @a[tag=macroengine.debug] {"text":"[macroengine:setup] Loading PlayerAction (dependency)...","color":"gray"}
function macroengine:core/internal/player/enumerate
function macroengine:core/internal/player/resolve
function macroengine:core/internal/player/init

# 3) Pack – Core engine (scoreboard / storage / config / backport)
tellraw @a[tag=macroengine.debug] {"text":"[macroengine:setup] Loading core (pack)...","color":"gray"}
function macroengine:core/internal/load/main

# Debug: done
tellraw @a[tag=macroengine.debug] {"text":"[macroengine:setup] Setup complete.","color":"green"}
