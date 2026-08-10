# dataEngine — API/Score/ToStorage
# Macro args: {name: string, objective: string, target: string, path: string}
# data_api:command/modify_data/import/from_score imzası: {name, objective}
# Sonucu data_api:private import.from'a yazar, biz oradan hedefe kopyalarız.
$function data_api:command/modify_data/import/from_score {name: "$(name)", objective: "$(objective)"}
$data modify storage $(target) $(path) set from storage data_api:private import.from
