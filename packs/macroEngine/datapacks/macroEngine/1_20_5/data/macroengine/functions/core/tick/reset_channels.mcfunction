# macroengine:core/tick/reset_channels — Overwrite channel storage with config file defaults
# WARNING: this discards ALL runtime API changes (enable/disable/set_rate/etc.)
function macroengine:core/tick/config
tellraw @s [{"text":"[DL] ","color":"gold"},{"text":"Tick channels reset to defaults.","color":"green"}]