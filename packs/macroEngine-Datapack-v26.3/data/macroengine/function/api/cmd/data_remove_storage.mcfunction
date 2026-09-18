# Storage removal: applies immediately (no confirmation gate). This command
# can destroy arbitrary storage data (including macroengine's own engine
# state) — callers should be careful with $(path).
#
# INPUT : $(storage) -> storage id, e.g. "macroengine:engine"
#         $(path)    -> NBT path to remove, e.g. "some_field"
$function macroengine:core/internal/cmd/data_remove_storage_apply {storage:"$(storage)",path:"$(path)"}
