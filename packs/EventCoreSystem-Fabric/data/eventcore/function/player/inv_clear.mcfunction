# Belirtilen envanter slotunu temizle.
# Kullanım: {target:"@a",slot:"hotbar.0"}
# slot örnekleri: hotbar.0 .. hotbar.8 | inventory.0..26 | armor.head | armor.chest | offhand
$item replace entity $(target) $(slot) with minecraft:air
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"inv_clear","color":"#FFAA00"},{"text":"target=","color":"#AAAAAA"},{"text":"$(target)","color":"white"},{"text":" slot=","color":"#AAAAAA"},{"text":"$(slot)","color":"white"}]
