data modify storage macro:output multiCommands.executed set value 0b

execute at @s store success storage macro:output multiCommands.executed byte 1 unless function macro:api/cmd/other/multi_cmd/advanced/run_with_options run return 1