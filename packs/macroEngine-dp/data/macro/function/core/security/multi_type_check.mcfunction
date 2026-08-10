# macro:core/security/multi_type_check
# Validates macro:engine multiCommands.type against security.multi_type_allowlist.
# Called before executing multi_cmd or multi_cmd_adv operations.
#
# Returns 1 → type is valid.
# Returns 0 → type violation fired (log + kick).
data modify storage macro:engine _mcmd_type_tmp set from storage macro:engine multiCommands.type
function macro:core/security/multi_type_check_macro with storage macro:engine {}
data remove storage macro:engine _mcmd_type_tmp
