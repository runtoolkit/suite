# dataEngine — API/Data/Import
# data_api:command/modify_data/import tam wrapper.
# Storage'dan okunup başka bir yere yazılır.
# Args: data_api:command/modify_data/import ile aynı imza
#   {from: {nbt,target,type OR nbt,storage OR nbt,entity OR slot,target,type},
#    to:   {nbt,target,type}}
function data_api:command/modify_data/import with storage data_engine:private import_args
