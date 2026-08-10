# dataEngine — API/Data/Convert
# data_engine:private convert_args storage'a koy:
#   {input: <value>, return: "string"|"number"|"array"|"compound"|"boolean"|"item"}
# Sonuç: data_api:private convert.input (dönüştürülmüş değer)
# data_api:command/modify_data/convert tam wrapper.
function data_api:command/modify_data/convert \
    with storage data_engine:private convert_args
