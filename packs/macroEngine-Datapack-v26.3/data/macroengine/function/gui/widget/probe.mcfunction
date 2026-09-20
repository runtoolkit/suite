# macro: $(id) $(fn)     as player
# Non-destructive presence test (count 0), then dispatch. Runs once per click per matching id.
$execute store result score #hit macroengine.gui_tmp run clear @s *[custom_data~{macroengine:{gui:{w:1b,id:"$(id)"}}}] 0
$execute if score #hit macroengine.gui_tmp matches 1.. run function $(fn)
