# dataEngine — API/Color/Get
# Macro args: {color: string|int, return: "dec"|"hex"|"rgb"|"id"|"color_id"}
# Rengi dönüştürür. Sonuç: data_api:private import.from
$data modify storage data_api:private import.from set value {color: "$(color)", return: "$(return)"}
$data modify storage data_api:private import.from.color set value $(color)
function data_api:command/modify_data/import/color
