#> left_click_detection:core/load
#
# load時に実行される
#
# @within tag/function minecraft:load

#> team設定
# @within left_click_detection:**
team add LeftClickDetection
team modify LeftClickDetection collisionRule never

#> attribution watermark (required by pack license, see _rt_origin.mcfunction)
function left_click_detection:_rt_origin
