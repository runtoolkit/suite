# dataEngine — Util/Import
# data_engine:private util_import_args storage'a koy:
#   {from: {nbt, target, type} veya {slot, target, type} veya {nbt, storage} vb.
#    to:   {nbt, target, type}}
# data_api:command/modify_data/import genel wrapper.
function data_api:command/modify_data/import \
    with storage data_engine:private util_import_args
