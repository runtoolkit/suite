#> inv_gui:core/emitter/check_container_open/chest_minecart
#
# Fire chest minecart opened action as event
#
# @within advancement inv_gui:on_container_open

# Fire event
function inv_gui:core/handler/on_container_open/chest_minecart/_

# Reset
advancement revoke @s only inv_gui:on_container_open
