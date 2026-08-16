tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━ Active Schedules ","color":"aqua"},{"text":"━━━━━━━━━","color":"#555555"}]
execute if data storage macroengine:engine schedules run tellraw @a[tag=macroengine.debug] ["",{"text":" ","color":"#555555"},{"plain":true ,"storage":"macroengine:engine","nbt":"schedules","interpret":false,"color":"gold"}]
execute unless data storage macroengine:engine schedules run tellraw @a[tag=macroengine.debug] ["",{"text":" ","color":"#555555"},{"text":"(no active schedules)","color":"gray","italic":true}]
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
