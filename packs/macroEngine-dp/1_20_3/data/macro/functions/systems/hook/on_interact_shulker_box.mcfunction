# macro:systems/hook/on_interact_shulker_box
# Advancement reward: runs when player opens a shulker box
advancement revoke @s only macro:systems/hook/interact_shulker_box
function macro:systems/hook/internal/on_interact_shulker_box
