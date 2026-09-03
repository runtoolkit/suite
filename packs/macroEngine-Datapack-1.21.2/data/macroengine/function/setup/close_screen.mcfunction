# macroengine:setup/close_screen [INTERNAL]
# BACKPORT NOTE (1.21.2): original called `dialog clear @s` to close the
# native dialog screen. No dialog system exists in 1.21.2 (see open_screen.mcfunction),
# so there is nothing to clear — the menu was a chat message, not a screen.
tellraw @s {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"Setup screen closed.","color":"gray"}]
