# macroengine:systems/chat/emit_admin [MACRO]
# Internal — called by api/chat/send. Emits a message styled to match
# the macroengine:admin_broadcast chat_type (bold cyan, visible to all).
#
# INPUT : $(msg) → plain text content
$tellraw @a ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"$(msg)","color":"#00AAAA","bold":true}]
