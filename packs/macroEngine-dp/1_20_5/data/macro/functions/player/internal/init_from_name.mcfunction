# macro:player/internal/init_from_name [MACRO]
# Relay: storage macro:names temp {NAME:"<player>"} → macro:player/init
# Called by on_player_join after macro:player/get_name populates macro:names temp.
# Bridges the NAME key to the player key expected by player/init.

$data modify storage macro:engine _pid_init_tmp set value {player:"$(NAME)"}
function macro:player/init with storage macro:engine _pid_init_tmp
data remove storage macro:engine _pid_init_tmp
