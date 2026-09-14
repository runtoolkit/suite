# Runs every tick. Tracks the current in-game day (gameTime / 24000) on
# every online player's db_gameday score, then hands out the bonus to
# anyone whose db_last_day is behind the current day.
#
# Note: this is IN-GAME days (tied to gameTime, which only advances while
# the server is running and the player is online), not real calendar days —
# vanilla has no server-side wall-clock time source available to a datapack.
execute store result score #day db_gameday run time query gametime
scoreboard players operation #day db_gameday /= #const24000 db_gameday
execute as @a if score @s db_last_day < #day db_gameday run function dailybonus:grant
