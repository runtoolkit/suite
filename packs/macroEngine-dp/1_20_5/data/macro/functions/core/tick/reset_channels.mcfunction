# macro:core/tick/reset_channels — Overwrite channel storage with config file defaults
# WARNING: this discards ALL runtime API changes (enable/disable/set_rate/etc.)
function macro:core/tick/config
tellraw @s [{"text":"[AME] ","color":"gold"},{"text":"Tick channels reset to defaults.","color":"green"}]