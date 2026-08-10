#> inv_gui:core/api/setup/_
# @within function inv_gui:api/setup

# Forceload setup
forceload add 10000 10000


# Shulker box setup
## For input/output
setblock 10000 0 10000 minecraft:orange_shulker_box{Lock:"inv_gui"}

## For item storage
setblock 10000 1 10000 minecraft:orange_shulker_box{Lock:"inv_gui"}

## For menu creation
setblock 10000 2 10000 minecraft:orange_shulker_box{Lock:"inv_gui"}
