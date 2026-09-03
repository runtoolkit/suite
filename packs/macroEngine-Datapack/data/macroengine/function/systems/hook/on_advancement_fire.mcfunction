# ─────────────────────────────────────────────────────────────────
# macroengine:systems/hook/on_advancement_fire
# Called from the user's own advancement reward function.
# Fires an event in "advancement:<id>" format.
#
# INPUT (storage macroengine:input):
# advancement → advancement ID (e.g. "story/mine_stone")
#
# KULLANIM:
# 1) Define a function as the reward in your advancement JSON:
# "rewards": {"function": "mypack:advancements/mine_stone"}
#
# 2) Inside that function:
# data modify storage macroengine:input advancement set value "story/mine_stone"
# function macroengine:systems/hook/on_advancement_fire
#
# 3) Hook bind:
# data modify storage macroengine:input event set value "advancement:story/mine_stone"
# data modify storage macroengine:input func set value "mypack:on_first_mine"
# function macroengine:systems/hook/bind
# ─────────────────────────────────────────────────────────────────

function macroengine:core/internal/systems/hook/on_advancement_fire with storage macroengine:input {}
