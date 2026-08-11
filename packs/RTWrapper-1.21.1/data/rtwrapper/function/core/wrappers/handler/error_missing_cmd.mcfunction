scoreboard players add #errors rtw.status 1
execute if score #silent rtw.config matches 0 run tellraw @a[tag=rtwrapper.debug] [{"text":"[RTWrapper] request missing cmd/type","color":"red"}]
