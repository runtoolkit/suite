# macroengine:systems/chat/emit_limit [MACRO]
# Internal — called by api/chat/send. Emits a message styled to match
# the macroengine:rate_limit_notice chat_type (red, to the caller only).
#
# INPUT : $(msg) → plain text content
$tellraw @s ["",{"text":"[LIMIT] ","color":"red"},{"text":"$(msg)","color":"red"}]
