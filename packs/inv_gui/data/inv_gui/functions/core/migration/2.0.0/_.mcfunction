#> inv_gui:core/migration/2.0.0/_
# @within function inv_gui:core/load

# Version setup
    data modify storage inv_gui:data Version set value "2.0.0"


# Storage setup
    data modify storage inv_gui:core GlobalItemInfoMap set value []

# Scoreboard setup
    scoreboard objectives add InvGui dummy
    scoreboard objectives add InvGui.Id dummy
    scoreboard objectives add InvGui.Drop custom:minecraft.drop

# Score holder setup
    scoreboard players set $LocalItemSlotIndex InvGui 0
    scoreboard players set $MinecartIndex InvGui 0

# Constant setup
    scoreboard players set $65536 InvGui 65536
