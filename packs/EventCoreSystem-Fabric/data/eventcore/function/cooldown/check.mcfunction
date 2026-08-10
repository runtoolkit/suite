# Oyuncu cooldown'da mı? 1 = cooldown'da, 0 = değil.
# Kullanım: {player:"Steve",id:"attack"}
$execute store result score #ec_cd_chk ec.sys run data get storage eventcore:cooldown $(player).$(id)
execute if score #ec ec.sys < #ec_cd_chk ec.sys run return 1
return 0
