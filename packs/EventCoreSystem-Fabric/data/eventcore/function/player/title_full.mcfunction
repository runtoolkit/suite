# Title ve subtitle'ı tek seferde göster.
# Kullanım: {target:"@a",title:'{"text":"Başlık"}',subtitle:'{"text":"Alt"}'}
$title $(target) title $(title)
$title $(target) subtitle $(subtitle)
$execute unless data storage eventcore:sys config_call{silent:1} run tellraw @a [{"text":"[EC] ","color":"#55FFFF","bold":true},{"text":"title_full","color":"#FFAA00"},{"text":"target=","color":"#AAAAAA"},{"text":"$(target)","color":"white"}]
