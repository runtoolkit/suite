# macro:systems/hook/on_trade
# Advancement reward: runs when villager_trade triggers.
# @s = the trading player

advancement revoke @s only macro:systems/hook/trade
scoreboard players add @s macro.hook_traded 1
