# macro:api/toggle/show
# Opens the module toggle dialog (inline, 1.21.6+).
#
# Usage:  function macro:api/toggle/show
# Caller: macro.admin tag required
#
# On submit → dialog calls:
#   /function macro:api/toggle/<Module>/<State>
#   where <State> is "true" (enable) or "false" (disable).
#
# Supported modules: hook, interaction, perm, wand, geo
#
# NOTE: template uses $(Module) and $(2) to match the defined input keys.
#       The original spec used $(1) which does not correspond to any key;
#       $(Module) is the correct substitution for key:"Module".

execute unless entity @s[tag=macro.admin] run return 0

dialog show @s {"type":"minecraft:multi_action","title":"","inputs":[{"type":"minecraft:text","key":"Module","label":"Module Name","label_visible":true,"max_length":64},{"type":"minecraft:boolean","key":"2","label":"Enabled","initial":true,"on_true":"true","on_false":"false"}],"can_close_with_escape":true,"after_action":"close","pause":false,"exit_action":{"label":"Close"},"actions":[{"label":"Apply","action":{"type":"minecraft:dynamic/run_command","template":"/function macro:api/toggle/$(Module)/$(2)"}}]}
