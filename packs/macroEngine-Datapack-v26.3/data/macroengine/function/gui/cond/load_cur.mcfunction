# macroengine:gui :: cond/load_cur     copies the condition compound in storage macroengine:gui_cnd cur into macroengine:gui/cond, key by key
# (a root-level `data modify storage X {} set from ...` is avoided on purpose, see README "Validation status").
# Call internal/clear_cond first. Keep this list in sync with internal/clear_cond.
execute if data storage macroengine:gui_cnd cur.type run data modify storage macroengine:gui_cond type set from storage macroengine:gui_cnd cur.type
execute if data storage macroengine:gui_cnd cur.obj run data modify storage macroengine:gui_cond obj set from storage macroengine:gui_cnd cur.obj
execute if data storage macroengine:gui_cnd cur.min run data modify storage macroengine:gui_cond min set from storage macroengine:gui_cnd cur.min
execute if data storage macroengine:gui_cnd cur.max run data modify storage macroengine:gui_cond max set from storage macroengine:gui_cnd cur.max
execute if data storage macroengine:gui_cnd cur.item run data modify storage macroengine:gui_cond item set from storage macroengine:gui_cnd cur.item
execute if data storage macroengine:gui_cnd cur.tag run data modify storage macroengine:gui_cond tag set from storage macroengine:gui_cnd cur.tag
execute if data storage macroengine:gui_cnd cur.mode run data modify storage macroengine:gui_cond mode set from storage macroengine:gui_cnd cur.mode
execute if data storage macroengine:gui_cnd cur.adv run data modify storage macroengine:gui_cond adv set from storage macroengine:gui_cnd cur.adv
execute if data storage macroengine:gui_cnd cur.pred run data modify storage macroengine:gui_cond pred set from storage macroengine:gui_cnd cur.pred
execute if data storage macroengine:gui_cnd cur.not run data modify storage macroengine:gui_cond not set from storage macroengine:gui_cnd cur.not
execute if data storage macroengine:gui_cnd cur.of run data modify storage macroengine:gui_cond of set from storage macroengine:gui_cnd cur.of
