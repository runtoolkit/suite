# Bir eventi isimle storage'a kaydet.
# Kullanım: {label:"my_event",event:{type:"...",data:{...}}}
$data modify storage eventcore:labels $(label) set value $(event)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"label.save","color":"#FFAA00"},{"text":"label=","color":"#AAAAAA"},{"text":"$(label)","color":"white"}]
