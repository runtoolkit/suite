# ─────────────────────────────────────────────────────────────────
# macroengine:api/dialog/show [1.21.6+ overlay]
# Shows the dialog stored at macroengine:engine dialog.DIALOG as inline JSON.
# Called by dialog/open after validation.
# Uses show_macro_exec to pipe DIALOG compound as inline dialog.
# ─────────────────────────────────────────────────────────────────

execute if entity @s[tag=macroengine.dialog_opened] at @s run return 0
execute unless data storage macroengine:engine dialog.DIALOG run return 0

execute at @s run function macroengine:player/get_name
data modify storage macroengine:engine dialog.NAME set from storage macroengine:names temp.NAME

function macroengine:api/dialog/show_dialog_exec with storage macroengine:engine dialog

tag @s add macroengine.dialog_opened

function macroengine:api/dialog/notify_admins
