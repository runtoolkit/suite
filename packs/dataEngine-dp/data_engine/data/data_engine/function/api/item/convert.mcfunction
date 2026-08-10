# dataEngine — API/Item/Convert
# data_engine:private convert_args storage'a şunları koy:
#   {input: "minecraft:diamond"|{id,components,...}, return: "item"|"string"|"compound"}
# Sonuç: data_api:private convert.input (dönüştürülmüş veri)
function data_api:command/modify_data/convert with storage data_engine:private convert_args
