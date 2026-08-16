# cos(x) = sin(x + 90)
$scoreboard players set $cos_d macroengine.tmp $(deg)
scoreboard players add $cos_d macroengine.tmp 90
scoreboard players set $cos_360 macroengine.tmp 360
scoreboard players operation $cos_d macroengine.tmp %= $cos_360 macroengine.tmp
execute if score $cos_d macroengine.tmp matches ..-1 run scoreboard players operation $cos_d macroengine.tmp += $cos_360 macroengine.tmp

scoreboard players set $cos_nf macroengine.tmp 1
execute if score $cos_d macroengine.tmp matches 180..359 run scoreboard players set $cos_nf macroengine.tmp -1
execute if score $cos_d macroengine.tmp matches 180..359 run scoreboard players remove $cos_d macroengine.tmp 180

scoreboard players set $cos_180 macroengine.tmp 180
execute if score $cos_d macroengine.tmp matches 91..179 run scoreboard players operation $cos_180 macroengine.tmp -= $cos_d macroengine.tmp
execute if score $cos_d macroengine.tmp matches 91..179 run scoreboard players operation $cos_d macroengine.tmp = $cos_180 macroengine.tmp

execute if score $cos_d macroengine.tmp matches 0 run scoreboard players set $cos_r macroengine.tmp 0
execute if score $cos_d macroengine.tmp matches 1 run scoreboard players set $cos_r macroengine.tmp 17
execute if score $cos_d macroengine.tmp matches 2 run scoreboard players set $cos_r macroengine.tmp 35
execute if score $cos_d macroengine.tmp matches 3 run scoreboard players set $cos_r macroengine.tmp 52
execute if score $cos_d macroengine.tmp matches 4 run scoreboard players set $cos_r macroengine.tmp 70
execute if score $cos_d macroengine.tmp matches 5 run scoreboard players set $cos_r macroengine.tmp 87
execute if score $cos_d macroengine.tmp matches 6 run scoreboard players set $cos_r macroengine.tmp 105
execute if score $cos_d macroengine.tmp matches 7 run scoreboard players set $cos_r macroengine.tmp 122
execute if score $cos_d macroengine.tmp matches 8 run scoreboard players set $cos_r macroengine.tmp 139
execute if score $cos_d macroengine.tmp matches 9 run scoreboard players set $cos_r macroengine.tmp 156
execute if score $cos_d macroengine.tmp matches 10 run scoreboard players set $cos_r macroengine.tmp 174
execute if score $cos_d macroengine.tmp matches 11 run scoreboard players set $cos_r macroengine.tmp 191
execute if score $cos_d macroengine.tmp matches 12 run scoreboard players set $cos_r macroengine.tmp 208
execute if score $cos_d macroengine.tmp matches 13 run scoreboard players set $cos_r macroengine.tmp 225
execute if score $cos_d macroengine.tmp matches 14 run scoreboard players set $cos_r macroengine.tmp 242
execute if score $cos_d macroengine.tmp matches 15 run scoreboard players set $cos_r macroengine.tmp 259
execute if score $cos_d macroengine.tmp matches 16 run scoreboard players set $cos_r macroengine.tmp 276
execute if score $cos_d macroengine.tmp matches 17 run scoreboard players set $cos_r macroengine.tmp 292
execute if score $cos_d macroengine.tmp matches 18 run scoreboard players set $cos_r macroengine.tmp 309
execute if score $cos_d macroengine.tmp matches 19 run scoreboard players set $cos_r macroengine.tmp 326
execute if score $cos_d macroengine.tmp matches 20 run scoreboard players set $cos_r macroengine.tmp 342
execute if score $cos_d macroengine.tmp matches 21 run scoreboard players set $cos_r macroengine.tmp 358
execute if score $cos_d macroengine.tmp matches 22 run scoreboard players set $cos_r macroengine.tmp 375
execute if score $cos_d macroengine.tmp matches 23 run scoreboard players set $cos_r macroengine.tmp 391
execute if score $cos_d macroengine.tmp matches 24 run scoreboard players set $cos_r macroengine.tmp 407
execute if score $cos_d macroengine.tmp matches 25 run scoreboard players set $cos_r macroengine.tmp 423
execute if score $cos_d macroengine.tmp matches 26 run scoreboard players set $cos_r macroengine.tmp 438
execute if score $cos_d macroengine.tmp matches 27 run scoreboard players set $cos_r macroengine.tmp 454
execute if score $cos_d macroengine.tmp matches 28 run scoreboard players set $cos_r macroengine.tmp 469
execute if score $cos_d macroengine.tmp matches 29 run scoreboard players set $cos_r macroengine.tmp 485
execute if score $cos_d macroengine.tmp matches 30 run scoreboard players set $cos_r macroengine.tmp 500
execute if score $cos_d macroengine.tmp matches 31 run scoreboard players set $cos_r macroengine.tmp 515
execute if score $cos_d macroengine.tmp matches 32 run scoreboard players set $cos_r macroengine.tmp 530
execute if score $cos_d macroengine.tmp matches 33 run scoreboard players set $cos_r macroengine.tmp 545
execute if score $cos_d macroengine.tmp matches 34 run scoreboard players set $cos_r macroengine.tmp 559
execute if score $cos_d macroengine.tmp matches 35 run scoreboard players set $cos_r macroengine.tmp 574
execute if score $cos_d macroengine.tmp matches 36 run scoreboard players set $cos_r macroengine.tmp 588
execute if score $cos_d macroengine.tmp matches 37 run scoreboard players set $cos_r macroengine.tmp 602
execute if score $cos_d macroengine.tmp matches 38 run scoreboard players set $cos_r macroengine.tmp 616
execute if score $cos_d macroengine.tmp matches 39 run scoreboard players set $cos_r macroengine.tmp 629
execute if score $cos_d macroengine.tmp matches 40 run scoreboard players set $cos_r macroengine.tmp 643
execute if score $cos_d macroengine.tmp matches 41 run scoreboard players set $cos_r macroengine.tmp 656
execute if score $cos_d macroengine.tmp matches 42 run scoreboard players set $cos_r macroengine.tmp 669
execute if score $cos_d macroengine.tmp matches 43 run scoreboard players set $cos_r macroengine.tmp 682
execute if score $cos_d macroengine.tmp matches 44 run scoreboard players set $cos_r macroengine.tmp 695
execute if score $cos_d macroengine.tmp matches 45 run scoreboard players set $cos_r macroengine.tmp 707
execute if score $cos_d macroengine.tmp matches 46 run scoreboard players set $cos_r macroengine.tmp 719
execute if score $cos_d macroengine.tmp matches 47 run scoreboard players set $cos_r macroengine.tmp 731
execute if score $cos_d macroengine.tmp matches 48 run scoreboard players set $cos_r macroengine.tmp 743
execute if score $cos_d macroengine.tmp matches 49 run scoreboard players set $cos_r macroengine.tmp 755
execute if score $cos_d macroengine.tmp matches 50 run scoreboard players set $cos_r macroengine.tmp 766
execute if score $cos_d macroengine.tmp matches 51 run scoreboard players set $cos_r macroengine.tmp 777
execute if score $cos_d macroengine.tmp matches 52 run scoreboard players set $cos_r macroengine.tmp 788
execute if score $cos_d macroengine.tmp matches 53 run scoreboard players set $cos_r macroengine.tmp 799
execute if score $cos_d macroengine.tmp matches 54 run scoreboard players set $cos_r macroengine.tmp 809
execute if score $cos_d macroengine.tmp matches 55 run scoreboard players set $cos_r macroengine.tmp 819
execute if score $cos_d macroengine.tmp matches 56 run scoreboard players set $cos_r macroengine.tmp 829
execute if score $cos_d macroengine.tmp matches 57 run scoreboard players set $cos_r macroengine.tmp 839
execute if score $cos_d macroengine.tmp matches 58 run scoreboard players set $cos_r macroengine.tmp 848
execute if score $cos_d macroengine.tmp matches 59 run scoreboard players set $cos_r macroengine.tmp 857
execute if score $cos_d macroengine.tmp matches 60 run scoreboard players set $cos_r macroengine.tmp 866
execute if score $cos_d macroengine.tmp matches 61 run scoreboard players set $cos_r macroengine.tmp 875
execute if score $cos_d macroengine.tmp matches 62 run scoreboard players set $cos_r macroengine.tmp 883
execute if score $cos_d macroengine.tmp matches 63 run scoreboard players set $cos_r macroengine.tmp 891
execute if score $cos_d macroengine.tmp matches 64 run scoreboard players set $cos_r macroengine.tmp 899
execute if score $cos_d macroengine.tmp matches 65 run scoreboard players set $cos_r macroengine.tmp 906
execute if score $cos_d macroengine.tmp matches 66 run scoreboard players set $cos_r macroengine.tmp 914
execute if score $cos_d macroengine.tmp matches 67 run scoreboard players set $cos_r macroengine.tmp 921
execute if score $cos_d macroengine.tmp matches 68 run scoreboard players set $cos_r macroengine.tmp 927
execute if score $cos_d macroengine.tmp matches 69 run scoreboard players set $cos_r macroengine.tmp 934
execute if score $cos_d macroengine.tmp matches 70 run scoreboard players set $cos_r macroengine.tmp 940
execute if score $cos_d macroengine.tmp matches 71 run scoreboard players set $cos_r macroengine.tmp 946
execute if score $cos_d macroengine.tmp matches 72 run scoreboard players set $cos_r macroengine.tmp 951
execute if score $cos_d macroengine.tmp matches 73 run scoreboard players set $cos_r macroengine.tmp 956
execute if score $cos_d macroengine.tmp matches 74 run scoreboard players set $cos_r macroengine.tmp 961
execute if score $cos_d macroengine.tmp matches 75 run scoreboard players set $cos_r macroengine.tmp 966
execute if score $cos_d macroengine.tmp matches 76 run scoreboard players set $cos_r macroengine.tmp 970
execute if score $cos_d macroengine.tmp matches 77 run scoreboard players set $cos_r macroengine.tmp 974
execute if score $cos_d macroengine.tmp matches 78 run scoreboard players set $cos_r macroengine.tmp 978
execute if score $cos_d macroengine.tmp matches 79 run scoreboard players set $cos_r macroengine.tmp 982
execute if score $cos_d macroengine.tmp matches 80 run scoreboard players set $cos_r macroengine.tmp 985
execute if score $cos_d macroengine.tmp matches 81 run scoreboard players set $cos_r macroengine.tmp 988
execute if score $cos_d macroengine.tmp matches 82 run scoreboard players set $cos_r macroengine.tmp 990
execute if score $cos_d macroengine.tmp matches 83 run scoreboard players set $cos_r macroengine.tmp 993
execute if score $cos_d macroengine.tmp matches 84 run scoreboard players set $cos_r macroengine.tmp 995
execute if score $cos_d macroengine.tmp matches 85 run scoreboard players set $cos_r macroengine.tmp 996
execute if score $cos_d macroengine.tmp matches 86 run scoreboard players set $cos_r macroengine.tmp 998
execute if score $cos_d macroengine.tmp matches 87 run scoreboard players set $cos_r macroengine.tmp 999
execute if score $cos_d macroengine.tmp matches 88 run scoreboard players set $cos_r macroengine.tmp 999
execute if score $cos_d macroengine.tmp matches 89 run scoreboard players set $cos_r macroengine.tmp 1000
execute if score $cos_d macroengine.tmp matches 90 run scoreboard players set $cos_r macroengine.tmp 1000

scoreboard players operation $cos_r macroengine.tmp *= $cos_nf macroengine.tmp
execute store result storage macroengine:output result int 1 run scoreboard players get $cos_r macroengine.tmp
$tellraw @a[tag=macroengine.debug] ["",{"text":"[MACROENGINE] ","color":"#00AAAA","bold":true},{"text":"math/cos ","color":"aqua"},{"text":"deg=$(deg) ","color":"gray"},{"text":"→ ","color":"#555555"},{"plain":true ,"storage":"macroengine:output","nbt":"result","color":"green"},{"text":"/1000","color":"#555555"}]
