$effect give $(target) minecraft:instant_health 1 $(amp)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"effect.heal","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"},{"text":" | ","color":"#555555"},{"text":"amp=","color":"#AAAAAA"},{"text":"$(amp)","color":"white"}]
