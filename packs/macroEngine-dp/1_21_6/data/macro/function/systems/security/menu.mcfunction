# macro:systems/security/menu  [1.21.6 OVERLAY]
# Dialog-based security menu. Replaces tellraw version on 1.21.6+.
# Requires: ame.perm_level >= security.admin_min_level
#
# NOTE: Dialog cannot read storage/score natively — values are injected
# via macro ($) in menu_build.mcfunction.
execute unless function macro:debug/tools/utils/perm_check run return 0

# Collect dynamic values into macro:input for macro interpolation
data modify storage macro:input sandbox set from storage macro:engine sandbox
data modify storage macro:input trust_players set from storage macro:engine security.trust_players
data modify storage macro:input cmd_min_level set from storage macro:engine security.cmd_min_level
data modify storage macro:input sandbox_lvl set from storage macro:engine security.sandbox_cmd_min_level
data modify storage macro:input admin_min_level set from storage macro:engine security.admin_min_level
data modify storage macro:input admin_override set from storage macro:engine security.admin_can_override
execute store result storage macro:input perm_level int 1 run scoreboard players get @s ame.perm_level

function macro:systems/security/menu_build with storage macro:input {}
