# dataEngine — API/Score/FromStorage
# Macro args: {target: string, path: string, name: string, objective: string}
# data_api:command/modify_data/export/to_score imzası: {name, objective}
# Önce data_api:private export.from'a kopyala.
$data modify storage data_api:private export.from set from $(target) $(path)
$function data_api:command/modify_data/export/to_score {name: "$(name)", objective: "$(objective)"}
