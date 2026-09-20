# macro: $(id)     as player   storage macroengine:gui_p {id:"ns:id"}
# ONE pair of lines per button in your #macroengine:gui/probe listener:
#   data merge storage macroengine:gui_p {id:"demo:ok"}
#   function macroengine:gui/widget/button_probe with storage macroengine:gui_p
# Same presence test as widget/probe, then runs the definition registered under that id.
$execute store result score #hit macroengine.gui_tmp run clear @s *[custom_data~{macroengine:{gui:{w:1b,id:"$(id)"}}}] 0
$execute if score #hit macroengine.gui_tmp matches 1.. run function macroengine:gui/internal/btn_click {id:"$(id)"}
