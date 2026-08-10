#> inv_gui:core/handler/on_select/get_changed_slot/check
# @macro
# @within function inv_gui:core/handler/on_select/get_changed_slot/loop

$execute if data storage inv_gui:temp Contents[{Slot:$(_gcs_slot)b,tag:{inv_gui:{isButton:true}}}] unless data storage inv_gui:temp CurrentContents[{Slot:$(_gcs_slot)b,tag:{inv_gui:{isButton:true}}}] run data modify storage inv_gui:temp Item set from storage inv_gui:temp Contents[{Slot:$(_gcs_slot)b}]
