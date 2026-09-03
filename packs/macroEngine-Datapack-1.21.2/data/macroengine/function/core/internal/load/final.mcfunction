data modify storage macroengine:engine global.version set value "v6.1.0"
scoreboard players set #runtoolkit.packs.macroengine.version macroengine.meta 610

tellraw @a ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"macroEngine v6.1.0 loaded.","color":"green"}]

# (formerly macroengine:core/internal/load/post_load — used to be triggered
# via the load:post_load tag, now the natural final step of the setup flow)
# Hook so other packs/extensions can add to the #macroengine:init tag
# (-> #macroengine:events/on_load) to say "run when macroEngine is fully loaded".
# 20t delay: this final.mcfunction already runs at t+16 (main->all->final
# chain), +4 ticks leaves extra margin.
tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Scheduling #macroengine:init (t+20)...","color":"gray"}]
schedule function #macroengine:init 20t replace
