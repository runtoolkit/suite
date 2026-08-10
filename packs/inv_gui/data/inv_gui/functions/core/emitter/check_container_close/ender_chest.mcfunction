#> inv_gui:core/emitter/check_container_close/ender_chest
#
# Fire ender chest closed action as event
#
# @within tag/function close_detector:on_closed

# Closed chest is an ender chest -> Fire event
execute if predicate open:ender_chest run function inv_gui:core/handler/on_container_close/ender_chest
