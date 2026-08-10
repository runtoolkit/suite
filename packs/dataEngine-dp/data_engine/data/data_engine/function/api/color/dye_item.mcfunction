# dataEngine — API/Color/DyeItem
# data_engine:private dye_args storage'ına şu alanları koy, sonra bu fn'i çağır:
#   base:   {slot,target,type}  → boyanacak öge
#   inputs: [{color,...}, ...]  → eklenen renkler
# data_api:command/dye_item tam wrapper.
function data_api:command/dye_item with storage data_engine:private dye_args
