# dataEngine — API/Entity/Summon
# data_engine:private summon_args storage'a koy:
#   {type: "minecraft:...", position: "x y z", nbt: {...}, init_function: "ns:fn"}
# data_api summon sistemi: global:private summon.output'a yazar, sonra spawn eder.
# Kullanım: storage'ı doldur → bu fn'i çağır.
function data_api:command/summon/main with storage data_engine:private summon_args
