# dataEngine — API/Item/FromLoot
# Macro args: {loot: string}  (loot table adı, e.g. "minecraft:entities/creeper")
# Sonuç: data_api:private import.from = item compound
$function data_api:command/modify_data/import/from_loot {loot: "$(loot)"}
