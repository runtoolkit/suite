# ─────────────────────────────────────────────────────────────────
# macroengine:api/chat/list
# Prints the chat_type identifiers macroEngine registers and what
# each one is used for. This is a reference/debug function — vanilla
# commands cannot select an arbitrary chat_type at runtime; chat_type
# only applies automatically to signed player chat (the vanilla chat
# pipeline), not to /tellraw or function-issued messages. Use
# macroengine:api/chat/send for a tellraw-based approximation that
# copies a chat_type's style.
#
# Usage:  function macroengine:api/chat/list
# Caller: macroengine.admin tag required
# ─────────────────────────────────────────────────────────────────

execute unless entity @s[tag=macroengine.admin] run return 0

tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━ Registered chat_type ━━━━━━━━","color":"#555555"}]
tellraw @s ["",{"text":" macroengine:admin_broadcast","color":"#00AAAA","bold":true},{"text":"  — bold cyan, admin channel","color":"gray"}]
tellraw @s ["",{"text":" macroengine:gate_log","color":"gray","italic":true},{"text":"        — muted italic, security/gate audit log","color":"gray"}]
tellraw @s ["",{"text":" macroengine:rate_limit_notice","color":"red"},{"text":" — red, throttling/limit warnings","color":"gray"}]
tellraw @s ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
