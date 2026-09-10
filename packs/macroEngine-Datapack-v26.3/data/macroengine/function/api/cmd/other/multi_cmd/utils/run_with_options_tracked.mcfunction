data modify storage macroengine:output multiCommands.executed set value 0b

execute at @s store success storage macroengine:output multiCommands.executed byte 1 unless function macroengine:api/cmd/other/multi_cmd/advanced/run_with_options run return 0
