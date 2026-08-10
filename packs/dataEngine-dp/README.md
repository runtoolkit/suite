# dataEngine

**dataEngine**, [Data API 1.10.3](https://modrinth.com/datapack/data_api/version/1.10.3) üzerine inşa edilmiş tam kapsamlı bir macro engine datapacks'idir. Data API'nin tüm public modüllerini `data_engine:` namespace altında belgelenmiş wrapper fonksiyonlarıyla sunar; bunlara dispatch kuyruğu ve hook sistemi ekler.

---

## Gereksinimler

| Bağımlılık | Sürüm | Kaynak |
|---|---|---|
| **Data API** | 1.10.3 | https://modrinth.com/datapack/data_api/version/1.10.3 |
| Minecraft Java | 26.1.x (1.21.5+) | — |

> **Kurulum:** Data API ve dataEngine'i aynı dünyaya yükleyin. dataEngine, Data API olmadan başlamaz.

---

## Namespace & Storage Anahtarları

```
Namespace : data_engine
Storage   : data_engine:public   — dışa açık state (engine.ready)
            data_engine:private  — iç state (dispatch queue, hooks, geçici)
Objectives: data_engine          — *de_version, *de_update
            de_flags             — geçici hesaplama / flag
            de_tick              — tick tabanlı sayaç
```

---

## Fonksiyon Kataloğu (150 fonksiyon)

### Dispatch

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `dispatch/call` | `{command: string}` | Komutu bir sonraki tick'e kuyruğa ekler |
| `dispatch/call_now` | `{command: string}` | `data_api:command/macro/_` ile anında çalıştırır |
| `dispatch/call_array` | `{commands: [...]}` | Listedeki tüm komutları çalıştırır |
| `dispatch/delay` | `{command: string, delay: string}` | `data_api:public delay` sistemine ekler |

### Hook

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `hook/register` | `{id: string, function: string}` | Hook listesine fonksiyon ekler |
| `hook/unregister` | `{id: string, function: string}` | Listeden fonksiyon siler |
| `hook/clear` | `{id: string}` | Tüm hook listesini temizler |
| `hook/fire` | `{id: string}` | Kayıtlı fonksiyonları `run_function/from_array` ile çalıştırır |

### API / Data

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/data/set` | `{type, target, nbt, value}` | Path'e değer yazar |
| `api/data/get` | `{type, target, nbt}` | `data_api:private import.from`'a çeker |
| `api/data/copy` | `{type, target, nbt, dst_type, dst_target, dst_nbt}` | Path'ten path'e kopyalar |
| `api/data/remove` | `{type, target, nbt}` | Path'i siler |
| `api/data/merge` | `{type, target, nbt, value}` | Compound'u merge eder |
| `api/data/append` | `{type, target, nbt, value}` | Listeye sona ekler |
| `api/data/prepend` | `{type, target, nbt, value}` | Listeye başa ekler |
| `api/data/import` | storage: `data_engine:private import_args` | `data_api import` genel wrapper |
| `api/data/export` | storage: `data_engine:private export_args` | `data_api export` genel wrapper |
| `api/data/type` | `{type, target, nbt}` | Veri tipini tespit eder, nbt'ye yazar |
| `api/data/convert` | storage: `data_engine:private convert_args` | Tipler arası dönüşüm |
| `api/data/convert_components` | — (@s=item_display) | Item component listesini normalize eder |
| `api/data/normalize_range` | `{type, target, nbt}` | Aralık değerini `{min, max}` compound'a normalize eder |

### API / Score

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/score/set` | `{name, objective, value}` | Skor atar |
| `api/score/add` | `{name, objective, value}` | Skora ekler |
| `api/score/remove` | `{name, objective, value}` | Skordan çıkarır |
| `api/score/reset` | `{name, objective}` | Skoru sıfırlar |
| `api/score/to_storage` | `{name, objective, target, path}` | Skoru storage'a yazar |
| `api/score/from_storage` | `{target, path, name, objective}` | Storage'dan skora yükler |

### API / Math

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/math/add` | `{type, target, nbt, value: int}` | nbt += value |
| `api/math/sub` | `{type, target, nbt, value: int}` | nbt -= value |
| `api/math/mul` | `{type, target, nbt, value: float}` | nbt *= value (int output) |
| `api/math/div` | `{type, target, nbt, value: int}` | nbt /= value |
| `api/math/mod` | `{type, target, nbt, value: int}` | nbt %= value |
| `api/math/abs` | `{type, target, nbt}` | Mutlak değer |
| `api/math/sqrt` | `{type, target, nbt}` | Karekök |
| `api/math/square` | `{type, target, nbt}` | Kare |
| `api/math/restrict` | `{type, target, nbt, range: "min..max"}` | Değeri aralıkla kısıtlar |
| `api/math/calculate` | storage: `data_engine:private math_args` | `calculate` tam wrapper (mean/median/mode/range/…) |

### API / String

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/string/to_upper` | `{type, target, nbt}` | Büyük harfe çevirir |
| `api/string/to_lower` | `{type, target, nbt}` | Küçük harfe çevirir |
| `api/string/split` | `{type, target, nbt, chars}` | Karakter bazında böler |
| `api/string/to_array` | `{type, target, nbt}` | Karakter dizisine çevirir |
| `api/string/array_to_string` | `{type, target, nbt}` | Char array → string |
| `api/string/count` | `{type, target, nbt, chars}` | Karakter sayar |
| `api/string/normalize` | `{type, target, nbt}` | Array/string normalize eder |
| `api/string/validate_chars` | `{type, target, nbt, chars: [...]}` | İzinli karakter doğrulama |
| `api/string/unpack` | `{type, target, nbt}` | Escape edilmiş SNBT string'i açar |

### API / Array

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/array/append` | `{type, target, nbt, value}` | Sona ekler |
| `api/array/prepend` | `{type, target, nbt, value}` | Başa ekler |
| `api/array/merge` | `{type, target, nbt, value: [...], action}` | Listeleri birleştirir |
| `api/array/reverse` | `{type, target, nbt}` | Sırayı tersine çevirir |
| `api/array/shuffle` | `{type, target, nbt}` | Karıştırır |
| `api/array/replace` | `{type, target, nbt, index, value}` | Eleman değiştirir |
| `api/array/to_compound` | `{type, target, nbt}` | Listeyi compound'a çevirir |
| `api/array/to_string` | `{type, target, nbt}` | Char listesini string'e birleştirir |
| `api/array/run_each` | `{type, target, nbt}` | Her fn string'ini çalıştırır |
| `api/array/run_commands` | `{type, target, nbt}` | Her komut string'ini çalıştırır |

### API / Compound

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/compound/to_string` | `{type, target, nbt}` | Compound → SNBT string |
| `api/compound/to_case` | `{type, target, nbt, case}` | Compound string değerlerini upper/lower yapar |

### API / Color

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/color/get` | `{color, return: "dec"\|"hex"\|"rgb"\|"id"}` | Renk formatını dönüştürür |
| `api/color/set_item` | `{type, target, slot, value}` | Slot'taki ögenin rengini ayarlar |
| `api/color/dye_item` | storage: `data_engine:private dye_args` | Öge boyama — `dye_item` tam wrapper |

#### API / Color / Convert (14 fonksiyon)

| Fonksiyon | Açıklama |
|---|---|
| `api/color/convert/dec_to_hex` | Decimal → Hex string |
| `api/color/convert/dec_to_rgb` | Decimal → `{r,g,b}` compound |
| `api/color/convert/dec_to_id` | Decimal → Minecraft renk id |
| `api/color/convert/hex_to_dec` | Hex → Decimal |
| `api/color/convert/hex_to_rgb` | Hex → `{r,g,b}` |
| `api/color/convert/hex_to_id` | Hex → Renk id |
| `api/color/convert/rgb_to_dec` | `{r,g,b}` → Decimal |
| `api/color/convert/rgb_to_hex` | `{r,g,b}` → Hex |
| `api/color/convert/rgb_to_id` | `{r,g,b}` → Renk id |
| `api/color/convert/id_to_dec` | Renk id → Decimal |
| `api/color/convert/id_to_hex` | Renk id → Hex |
| `api/color/convert/id_to_rgb` | Renk id → `{r,g,b}` |
| `api/color/convert/normalize_rgb` | `{r,g,b}` değerlerini 0-255'e normalize eder |
| `api/color/convert/get_value` | Renk compound'undan ham değeri çeker |

Tüm `convert/*` fonksiyonları: `{type: string, target: string, nbt: string}` argümanı alır.

### API / Item

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/item/give` | `{output: compound}` | `give` wrapper — item entity spawn eder |
| `api/item/drop` | `{type, target, slot, pickup_delay}` | Slot'tan item düşürür |
| `api/item/drop_all` | `{type, target, nbt}` | Listedeki tüm itemleri düşürür |
| `api/item/return` | `{type, target, path, slot}` | En yakın oyuncuya item geri atar |
| `api/item/revoke` | `{item, return, sound, text}` | @s'den item alır, mesaj verir |
| `api/item/damage` | `{type, target, slot, damage}` | Slot'taki iteme hasar verir |
| `api/item/from_slot` | `{type, target, slot}` | Slot → `data_api:private import.from` |
| `api/item/to_slot` | `{type, target, slot}` | `export.from` → slot |
| `api/item/from_loot` | `{loot: string}` | Loot table → `import.from` |
| `api/item/to_container` | storage: `data_engine:private item_args` | Container'a item doldurur |
| `api/item/to_ender_chest` | storage: `data_engine:private ender_args` | Ender chest'e item yazar |
| `api/item/restore_ender_items` | — (@s olarak) | `player_data.store.EnderItems` → @s ender chest |
| `api/item/convert` | storage: `data_engine:private convert_args` | Item/string/compound dönüşümü |

#### API / Item / Hopper

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/item/hopper/return_all` | `{slot: int}` | Tüm yönlerdeki hopper'lara item gönderir |
| `api/item/hopper/return_top_only` | `{slot: int}` | Yalnızca üstteki hopper'a gönderir |
| `api/item/hopper/return_sides_only` | `{slot: int}` | Yan hopper'lara gönderir |
| `api/item/hopper/insert` | `{pos, slot, hopper_slot}` | Hopper'dan blok container'a item taşır |

### API / Entity

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/entity/summon` | storage: `data_engine:private summon_args` | `data_api summon/main` wrapper |
| `api/entity/summon_at` | `{type, position, nbt, init_function}` | Konuma entity spawn eder |
| `api/entity/set_nbt` | — | summon NBT modülü |
| `api/entity/set_passengers` | — | summon passenger listesi |
| `api/entity/get_id` | `{entity_id: string}` | Entity type → `import.from` |
| `api/entity/list` | — | Entity listesini chat'e basar |

### API / Player

| Fonksiyon | Açıklama |
|---|---|
| `api/player/get_pos` | @s Pos → `player_data.store.Pos` |
| `api/player/restore_pos` | `player_data.store.Pos` → @s TP |
| `api/player/get_rotation` | @s Rotation → `player_data.store.Rotation` |
| `api/player/restore_rotation` | `player_data.store.Rotation` → @s döndür |
| `api/player/get_health` | @s Health → `player_data.store.Health` |
| `api/player/set_health` | `player_data.store.Health` → @s |
| `api/player/get_xp` | @s XpLevel → `player_data.store.XpLevel` |
| `api/player/set_xp` | `player_data.store.XpLevel` → @s |
| `api/player/restore_inventory` | `player_data.store.Inventory` → @s envanteri |
| `api/player/get_dimension` | @s Dimension → `player_data.store.Dimension` |
| `api/player/set_dimension` | `player_data.store.Dimension` → @s boyut TP |
| `api/player/restore_effects` | `player_data.store.active_effects` → @s |
| `api/player/set_respawn` | `player_data.store.respawn` → @s spawn noktası |
| `api/player/modify_slot` | `{path, slot}` | player_data.store.<path> → slot |
| `api/player/modify_array` | storage: `data_engine:private player_modify_args` | Array tabanlı efekt/item yönetimi |
| `api/player/health_schedule` | — | Geçici max_health modifier'ı temizle |
| `api/player/tell` | `{sound, text}` | Actionbar mesaj + ses |

### API / Command

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/command/if_any` | `{commands: [...], conditions: [...]}` | Herhangi koşul true → komutlar çalışır |
| `api/command/ternary` | `{condition, if: [...], unless: [...]}` | if/else komut dalı |
| `api/command/from_pool` | `{commands: [...]}` | Listeden rastgele bir komut seçer ve çalıştırır |
| `api/command/on_item` | `{type, target, slot, command}` | Slot'taki item üzerinde komut çalıştırır |
| `api/command/on_container` | `{type, target, start, stop, command}` | Container slotlarında döngü |
| `api/command/on_inventory` | `{command: string}` | Oyuncu envanterinin tüm slotlarında döngü |
| `api/command/run_with` | `{function, inputs: [...]}` | Her input compound ile fn çağırır |
| `api/command/run_fn_on_container` | `{type, target, start, stop, function, path, context}` | Container slotlarında fn çalıştırır |
| `api/command/run_fn_on_inventory` | `{function, context}` | Oyuncu envanterinde fn çalıştırır |
| `api/command/verify_path` | `{path: string}` | Fonksiyon path'i doğrular |

### API / Block

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `api/block/raycast` | `{command, distance}` | Bakılan blok üzerinde komut çalıştırır |
| `api/block/raycast_entity` | `{command, distance, entity}` | Bakılan entity üzerinde komut çalıştırır |
| `api/block/raycast_both` | `{command, distance, entity}` | Blok veya entity (hangisi önce) |
| `api/block/raycast_with_context` | `{command, distance, context}` | Özel context tag ile blok raycast |
| `api/block/raycast_entity_with_context` | `{command, distance, entity, context}` | Özel context tag ile entity raycast |
| `api/block/on_container` | `{target, start, stop, command}` | Blok container slotlarında döngü |

### API / Macro

Tüm fonksiyonlar `data_api:command/macro/*` tam wrapper'larıdır:

| Fonksiyon | Argümanlar |
|---|---|
| `api/macro/effect` | `{id, amplifier, duration, show_particles, target}` |
| `api/macro/experience` | `{action, amount, type, target}` |
| `api/macro/particle` | `{particle, count, delta, speed, position, target}` |
| `api/macro/playsound` | `{sound_id, channel, target, position, volume, pitch}` |
| `api/macro/loot` | `{loot, type, target, slot}` |
| `api/macro/teleport` | `{target, location}` |
| `api/macro/rotate` | `{target, location}` |
| `api/macro/spawnpoint` | `{target, dimension, location}` |

### Util

| Fonksiyon | Argümanlar | Açıklama |
|---|---|---|
| `util/random` | `{min, max, mode, value}` | Rastgele sayı / şans (`import/from_random`) |
| `util/trim` | storage: `data_engine:private trim_args` | Storage temizliği (`data_api trim`) |
| `util/random_tp` | — | Rastgele TP (`random_teleport`) |
| `util/import` | storage: `data_engine:private util_import_args` | `data_api import` genel wrapper |
| `util/export` | storage: `data_engine:private util_export_args` | `data_api export` genel wrapper |
| `util/set_target_selectors` | storage: `data_engine:private selector_args` | Selector string'lerini çözümler |

---

## Kullanım Örnekleri

### Dispatch — Sıralı Komut Kuyruğu

```mcfunction
# Bir sonraki tick'e kuyruğa ekle
function data_engine:dispatch/call {command: "say merhaba"}

# Birden fazla komut, aynı tick'te çalışır
function data_engine:dispatch/call_array \
    {commands: ["say ilk", "say ikinci"]}

# Geciktir (data_api delay sistemi)
function data_engine:dispatch/delay {command: "say 5 saniye sonra", delay: "5s"}
```

### Hook — Olay Kaydı

```mcfunction
# Load fonksiyonunda kaydet
function data_engine:hook/register \
    {id: "player_join", function: "mynamespace:on_join"}

# Tetikle
function data_engine:hook/fire {id: "player_join"}
```

### Matematik — Doğrudan Storage Üzerinde

```mcfunction
# Storage'daki sayıya 5 ekle (scoreboard gerektirmez)
function data_engine:api/math/add \
    {type: "storage", target: "mypack:state", nbt: "counter", value: 5}

# 0-100 aralığına kısıtla
function data_engine:api/math/restrict \
    {type: "storage", target: "mypack:state", nbt: "counter", range: "0..100"}

# Karmaşık hesaplama: ortalama
data modify storage data_engine:private math_args set value \
    {args: {inputs: [10, 20, 30], operation: "mean", \
            output: {nbt: "result", target: "mypack:out", type: "storage"}}}
function data_engine:api/math/calculate
```

### Renk Dönüşümü

```mcfunction
# Decimal → RGB
function data_engine:api/color/convert/dec_to_rgb \
    {type: "storage", target: "mypack:data", nbt: "skin_color"}

# Oyuncunun kılıcını kırmızıya boya
function data_engine:api/color/set_item \
    {type: "entity", target: "@s", slot: "weapon.mainhand", value: "red"}

# Rastgele renk üret
function data_engine:util/random {min: 0, max: 16777215, mode: "range", value: 0}
# data_api:private import.from = rastgele decimal renk
```

### Hopper Entegrasyonu

```mcfunction
# @s = blok pozisyonunda çalıştır
# Slot 0'daki itemi tüm bağlı hopper'lara geri gönder
execute at @s run function data_engine:api/item/hopper/return_all {slot: 0}
```

### Envanter Tarama

```mcfunction
# Oyuncu envanterindeki her item için fonksiyon çalıştır
execute as @a run function data_engine:api/command/run_fn_on_inventory \
    {function: "mypack:process_item", context: "if entity @s"}

# Tüm envanter slotlarında komut çalıştır
execute as @a run function data_engine:api/command/on_inventory \
    {command: "execute as @s run function mypack:check_slot"}
```

### Raycast

```mcfunction
# Bakılan blok (10 blok, özel context)
function data_engine:api/block/raycast_with_context \
    {command: "function mypack:on_hit", distance: "10", context: "#mypack:raycast"}

# Hem blok hem entity
function data_engine:api/block/raycast_both \
    {command: "function mypack:on_hit", distance: "8", entity: "[tag=mypack.target]"}
```

### String İşleme

```mcfunction
# Unpack — string içindeki SNBT compound'u aç
data modify storage mypack:data nbt_string set value '"{id: \"minecraft:diamond\"}"'
function data_engine:api/string/unpack \
    {type: "storage", target: "mypack:data", nbt: "nbt_string"}

# Split + array üzerinde fonksiyon çalıştır
function data_engine:api/string/split \
    {type: "storage", target: "mypack:data", nbt: "csv_line", chars: ","}
# → mypack:data csv_line = string listesi
function data_engine:api/array/run_each \
    {type: "storage", target: "mypack:data", nbt: "csv_line"}
```

### Player Snapshot

```mcfunction
# Konum + eşyaları kaydet
execute as @a run function data_engine:api/player/get_pos
execute as @a run function data_engine:api/player/get_health
execute as @a run function data_engine:api/player/get_xp

# ... başka şeyler yap ...

# Geri al
execute as @a run function data_engine:api/player/restore_pos
execute as @a run function data_engine:api/player/set_health
execute as @a run function data_engine:api/player/set_xp
```

---

## Data API Bağımlılık Haritası

| dataEngine Modülü | Kullandığı Data API Fonksiyonları |
|---|---|
| dispatch | `command/macro/_`, `delay` |
| hook | `command/run_function/from_array` |
| api/data | `command/modify_data/import`, `command/modify_data/export`, `command/modify_data/return`, `command/modify_data/convert`, `command/modify_data/number/normalize_range` |
| api/score | `command/modify_data/import/from_score`, `command/modify_data/export/to_score` |
| api/math | `command/modify_data/number/*`, `command/calculate` |
| api/string | `command/modify_data/string/*` |
| api/array | `command/modify_data/array/*`, `command/run_function/from_array`, `command/run_command/from_array` |
| api/compound | `command/modify_data/compound/*` |
| api/color | `command/modify_data/import/color`, `command/modify_data/color/*`, `command/set_color`, `command/dye_item` |
| api/item | `command/give`, `command/drop_item`, `command/drop_items`, `command/return_item`, `command/revoke_item`, `command/damage_item`, `command/modify_data/import/from_slot`, `command/modify_data/export/to_slot`, `command/modify_data/import/from_loot`, `command/modify_data/export/to_container`, `command/modify_data/export/to_ender_chest`, `command/modify_data/player/ender_items`, `command/modify_data/convert`, `command/return_item_from_hopper/*` |
| api/entity | `command/summon/main`, `command/summon/nbt`, `command/summon/passengers`, `command/modify_data/import/entity_id`, `command/list_entities` |
| api/player | `command/modify_data/player/*`, `command/tell` |
| api/command | `command/run_command/if_any`, `command/run_command/as_ternary`, `command/run_command/from_pool`, `command/run_command/on_item`, `command/run_command/on_container`, `command/run_command/on_inventory`, `command/run_function/on_container`, `command/run_function/on_inventory`, `command/run_function/with_array`, `command/verify_file_path` |
| api/block | `command/raycast/on_block`, `command/raycast/on_entity`, `command/raycast/on_block_and_entity`, `command/raycast/on_block_with_context`, `command/raycast/on_entity_with_context`, `command/run_command/on_container` |
| api/macro | `command/macro/effect`, `command/macro/experience`, `command/macro/particle`, `command/macro/playsound`, `command/macro/loot`, `command/macro/teleport`, `command/macro/rotate`, `command/macro/spawnpoint` |
| util | `command/modify_data/import/from_random`, `command/modify_data/trim`, `command/random_teleport`, `command/modify_data/import`, `command/modify_data/export`, `command/set_target_selectors` |

---

## Lisans

MIT — bkz. [LICENSE](LICENSE)
