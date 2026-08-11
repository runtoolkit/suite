# Macro: called with storage rtwrapper:api trigger (fields: objective, action, reset_mode).
# Creates the trigger-type scoreboard objective and appends the registration entry.
$scoreboard objectives add $(objective) trigger
$data modify storage rtwrapper:triggers registry append value {objective:"$(objective)",enabled:1b,reset_mode:"$(reset_mode)",action:$(action)}
$scoreboard players enable @s $(objective)