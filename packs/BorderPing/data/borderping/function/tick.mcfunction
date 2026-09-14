# Runs every tick.
#
# Vanilla has no command that reads the current /worldborder size/center
# into a scoreboard value, so this pack assumes a fixed square border
# centered on 0 0 with a 3000-block half-size (edit the coordinates below
# to match your actual /worldborder settings if they differ).
#
# Warns a player once (bp_warned=1) when they cross into the outer 100
# blocks of that boundary, and resets the warning once they move back to
# within 200 blocks of the boundary.
execute as @a[scores={bp_warned=0},x=-3000,dx=6000,z=-3000,dz=6000] unless entity @s[x=-2900,dx=5800,z=-2900,dz=5800] run function borderping:warn
execute as @a[scores={bp_warned=1}] if entity @s[x=-2800,dx=5600,z=-2800,dz=5600] run scoreboard players set @s bp_warned 0
