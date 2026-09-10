# macroengine:systems/hook/on_trade
# Advancement reward: runs when villager_trade triggers.
# @s = the trading player

advancement revoke @s only macroengine:systems/hook/trade
scoreboard players add @s macroengine.hook_traded 1
