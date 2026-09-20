# macro: $(sound) $(volume) $(pitch)     as player, at player
# `ui` category so it follows the client's "Master" slider only, not music/blocks/hostile.
# `sound` is macro-expanded raw: must come from menu code, never from player input.
# Not gated: playsound to @s cannot run arbitrary commands, only an (already-validated-by-the-game) sound id.
$playsound $(sound) ui @s ~ ~ ~ $(volume) $(pitch)
