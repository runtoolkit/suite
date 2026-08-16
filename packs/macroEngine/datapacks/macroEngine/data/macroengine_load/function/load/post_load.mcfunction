# Stage 4 — post_load: schedule #macroengine:init after DL finishes loading
# macroengine_load:load/all is scheduled at t+16 (from Stage 0 in macroengine_load:main).
# Firing #macroengine:init at t+20 gives 4 ticks of margin after macroengine is fully ready.
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Scheduling #macroengine:init (t+20)...","color":"gray"}]
schedule function #macroengine:init 20t replace
