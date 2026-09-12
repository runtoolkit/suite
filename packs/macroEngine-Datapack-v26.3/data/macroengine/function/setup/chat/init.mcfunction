# macroengine:setup/chat/init [INTERNAL — called via #macroengine:init]
# Registers the global rate limit rule the chat module depends on
# (api/chat/send). 1 hit per 20 ticks (1s) global window; fail-open
# with a warning is the systems/rate_limit default if this never runs,
# so this must complete before api/chat/send is first called.
function macroengine:systems/rate_limit/global/config {key:"chat_send",limit:1,window:20}
