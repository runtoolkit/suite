$item replace entity $(target) armor.head  with diamond_helmet[minecraft:enchantments={"minecraft:protection":7,"minecraft:unbreaking":3}] 1
$item replace entity $(target) armor.chest with diamond_chestplate[minecraft:enchantments={"minecraft:protection":7,"minecraft:unbreaking":3}] 1
$item replace entity $(target) armor.legs  with diamond_leggings[minecraft:enchantments={"minecraft:protection":7,"minecraft:unbreaking":3}] 1
$item replace entity $(target) armor.feet  with diamond_boots[minecraft:enchantments={"minecraft:protection":7,"minecraft:unbreaking":3}] 1
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"player.god_armor","color":"#FFAA00"},{"text":"→ ","color":"#AAAAAA"},{"text":"$(target)","color":"white"}]
