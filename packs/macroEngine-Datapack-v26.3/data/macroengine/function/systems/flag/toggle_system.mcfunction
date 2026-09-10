# macroengine:systems/flag/toggle_system — Toggle a built-in tick system on/off [MACRO]
# Usage: function macroengine:systems/flag/toggle_system {system:"time"}
# Valid systems: time | queue | player | hud | admin
# Flips the #sys_<name> macroengine.tick_flags score between 1 and 0.

$function macroengine:systems/flag/toggle_system/exec {system:"$(system)"}
