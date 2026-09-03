# ─────────────────────────────────────────────────────────────────
# macroengine:api/cmd/other/multi_cmd/utils/get_stats
# Mevcut istatistikleri macroengine:output'a kopyala
# ─────────────────────────────────────────────────────────────────

data modify storage macroengine:output stats set from storage macroengine:engine _mcmd_stats
