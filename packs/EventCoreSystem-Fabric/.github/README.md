<h1 align="center">🎮 EventCore Sistemi</h1>

<p align="center">
  <b>Gelişmiş • Modüler • Vanilla Dostu</b><br>
  Minecraft Event Yönetim Sistemi
</p>

<p align="center">
  <img src="https://img.shields.io/badge/versiyon-2.4.0-green" alt="versiyon">
  <img src="https://img.shields.io/badge/Minecraft-1.21.6%2B-blue" alt="minecraft">
  <img src="https://img.shields.io/badge/pack--format-94-orange" alt="pack format">
</p>

<p align="center">
  <a href="https://github.com/asn44nb/EventCoreSystem-Datapack/">
    🔗 GitHub Deposu
  </a>
</p>

---

## ⚠️ Arşivlendi

Bu depo arşivlenmiştir ve artık geliştirilmeyecektir.

Son dönemde dijital içerikler ve güvenlik konularına yönelik tartışmalar nedeniyle önlem amaçlı arşivlenmiştir.

Kodlar referans ve eğitim amaçlı olarak erişilebilir durumda bırakılmıştır.


---

## 📌 Genel Bakış

**EventCore**, Minecraft 1.21.6+ için tasarlanmış, tek bir merkezden çalışan **event tetikleme altyapısıdır**.
Tüm işlemler `eventcore:trigger` fonksiyonu üzerinden yönlendirilir.

- ✔ Vanilla uyumlu
- ✔ Modüler yapı
- ✔ Genişletilebilir mimari
- ✔ Okunabilir sözdizimi
- ✔ Tek çağrıda çoklu eylem desteği (`events:[]`)
- ✔ Gecikmeli yürütme (`config:{delay:N}`)
- ✔ Ayarlanabilir config sistemi

---

## 📋 İçindekiler

- [Hakkında](#hakkında)
- [Özellikler](#özellikler)
- [Kurulum](#kurulum)
- [Hızlı Başlangıç](#hızlı-başlangıç)
- [Trigger Sözdizimi](#trigger-sözdizimi)
- [Config Sistemi](#config-sistemi)
- [Örnekler](#örnekler)
- [Proje Yapısı](#proje-yapısı)
- [Katkıda Bulunma](#katkıda-bulunma)
- [Lisans](#lisans)

---

## Hakkında

**EventCore**, aşağıdaki sistemleri kapsayan birleşik bir event çekirdeğidir:

- `message` — broadcast, whisper, msg, title, subtitle, actionbar, title_times, title_clear, title_reset
- `sound` — playsound, particle
- `player` — tp, gamemode, kick, freeze, attribute
- `effect` — effect_add, effect_clear, heal
- `item` — give, give_raw, clear, enchant
- `xp`
- `score` — score_set, score_add, score_remove, score_reset, score_obj_add, score_obj_remove
- `bossbar` — bossbar_new, bossbar_set, bossbar_del
- `entity` — summon, remove, data_merge, modify
- `waypoint` — waypoint_create, waypoint_tp, waypoint_delete, waypoint_get
- `timer` — delay, repeat, stop
- `cmd` / `cmds` — ham komut çalıştırma
- `func` / `funcs` — fonksiyon çağırma
- `config` — config_set, config_set_str, config_get, config_reset, config_list

---

## Özellikler

| Sistem | Açıklama |
|--------|----------|
| 📢 Message | Broadcast, whisper, msg, title, subtitle, actionbar ve title kontrolleri |
| 🔊 Sound | Playsound ve partikül desteği |
| 👤 Player | Teleport, gamemode, kick, dondurma, attribute |
| ✨ Effect | Efekt ekleme, temizleme ve anlık iyileştirme |
| 🎒 Items | Give / clear / enchant — 1.21+ bileşen sistemi desteği |
| ✨ XP | XP puan ve seviye yönetimi |
| 📊 Score | Scoreboard oyuncu ve objective yönetimi |
| 🩸 Bossbar | Oluşturma / güncelleme / kaldırma |
| 👹 Entity | Spawn / kill / data merge / modify |
| 📍 Waypoint | Waypoint oluşturma, ışınlanma, silme |
| ⏱ Timer | Gecikmeli, tekrarlayan ve durdurulabilir zamanlayıcılar |
| ⌨️ Cmd / Cmds | Tekil veya çoklu ham komut çalıştırma (güvenlik filtreli) |
| 🔁 Func / Funcs | Tekil veya çoklu fonksiyon çağırma |
| ⚙️ Config | Ayarlanabilir sistem değişkenleri, yeniden yükleme sonrası kalıcı |

---

## Kurulum

<details>
<summary><b>📦 Gereksinimler</b></summary>

- Minecraft Java Edition 1.21.6+
- Pack Format 94

</details>

<details>
<summary><b>🛠 Kurulum Adımları</b></summary>

1. ZIP dosyasını `world/datapacks/` klasörüne çıkart
2. `/reload` komutunu çalıştır
3. Yükleme onayı için sohbette `[EventCore] v2.2.0 yüklendi.` mesajını gör

</details>

---

## Hızlı Başlangıç

```mcfunction
function eventcore:trigger {args:{type:"broadcast",data:{msg:"EventCore aktif!"}},events:[],config:{}}
```

---

## Trigger Sözdizimi

`eventcore:trigger` üç macro parametresi alır.
Üçü de her zaman belirtilmelidir — boş geçilebilir ama atlanamaz.

```mcfunction
function eventcore:trigger {
  args:{type:"...",data:{...}},
  events:[{type:"...",data:{...}}, ...],
  config:{...}
}
```

### args:{}

Tekil bir eylem çalıştırır. Boş bırakılabilir: `args:{}`

### events:[]

Birden fazla eylemi sırayla çalıştırır. Boş bırakılabilir: `events:[]`

### config:{}

| Alan | Tür | Açıklama |
|------|-----|----------|
| `delay:N` | int | N tick sonra çalıştır |
| `version_check:0b` | bool | Sürüm kontrolünü devre dışı bırak (varsayılan: 1b) |
| `as:"@a"` | string | execute as bağlamı |
| `at:"@s"` | string | execute at bağlamı |
| `silent:1b` | bool | Hata mesajlarını bastır |

---

## Config Sistemi

Config değerleri `eventcore:config` storage'ında tutulur.
`/reload` sonrası otomatik yüklenir — mevcut değerlerin üstüne yazılmaz.

| Anahtar | Varsayılan | Açıklama |
|---------|-----------|----------|
| `debug.sound` | `1b` | Trigger sonrası level-up sesi |
| `errors.show` | `1b` | Hata mesajlarını göster |
| `cmd.security` | `1b` | OP/ban/kick komut filtresi |
| `broadcast.prefix` | `"[DUYURU]"` | Broadcast ön eki |
| `broadcast.prefix_color` | `"gold"` | Ön ek rengi |
| `broadcast.msg_color` | `"yellow"` | Mesaj rengi |
| `on_load.enabled` | `0b` | Yükleme sonrası fonksiyon çalıştır |
| `on_load.ns` | `"eventcore"` | Yükleme fonksiyonu namespace'i |
| `on_load.path` | `"version/announce"` | Yükleme fonksiyonu yolu |

### Config Kullanımı

```mcfunction
# Tüm değerleri listele
function eventcore:trigger {args:{type:"config_list"},events:[],config:{}}

# Değer oku
function eventcore:trigger {args:{type:"config_get",data:{key:"broadcast.prefix"}},events:[],config:{}}

# Bool/int değer yaz
function eventcore:trigger {args:{type:"config_set",data:{key:"debug.sound",value:0b}},events:[],config:{}}

# String değer yaz
function eventcore:trigger {args:{type:"config_set_str",data:{key:"broadcast.prefix",value:"[OLAY]"}},events:[],config:{}}

# Varsayılanlara sıfırla
function eventcore:trigger {args:{type:"config_reset"},events:[],config:{}}
```

---

## Örnekler

### 📢 Tekil Eylem — Broadcast

```mcfunction
function eventcore:trigger {args:{type:"broadcast",data:{msg:"Sunucu başlıyor!"}},events:[],config:{}}
```

### 📋 Çoklu Eylem — events:[]

```mcfunction
function eventcore:trigger {args:{},events:[{type:"broadcast",data:{msg:"Etkinlik başladı!"}},{type:"title",data:{target:"@a",text:"BAŞLADI",color:"gold"}},{type:"playsound",data:{sound:"minecraft:entity.player.levelup",source:"master",target:"@a"}}],config:{}}
```

### ⏱ Gecikmeli Yürütme

```mcfunction
function eventcore:trigger {args:{type:"broadcast",data:{msg:"5 saniye sonra!"}},events:[],config:{delay:100}}
```

### 👤 Bağlamlı Yürütme — as + at

```mcfunction
function eventcore:trigger {args:{type:"broadcast",data:{msg:"Tüm oyuncular!"}},events:[],config:{as:"@a",at:"@s"}}
```

### 📊 Scoreboard

```mcfunction
function eventcore:trigger {args:{type:"score_obj_add",data:{obj:"coins",type:"dummy"}},events:[],config:{}}
function eventcore:trigger {args:{type:"score_add",data:{target:"@s",obj:"coins",val:10}},events:[],config:{}}
```

### ⌨️ Çoklu Komut

```mcfunction
function eventcore:trigger {args:{type:"cmds",data:{commands:["title @s title {\"text\":\"A\"}","title @s subtitle {\"text\":\"B\"}"]}},events:[],config:{}}
```

### 🔕 Sürüm Kontrolü Devre Dışı

```mcfunction
function eventcore:trigger {args:{type:"broadcast",data:{msg:"test"}},events:[],config:{version_check:0b}}
```

---

## Proje Yapısı
eventcore/
├── pack.mcmeta
└── data/eventcore/function/
├── trigger.mcfunction          ← Ana giriş noktası
├── multi.mcfunction            ← Sadece events:[] girişi
├── trigger/
│   ├── run_core.mcfunction
│   ├── run_as.mcfunction
│   ├── run_at.mcfunction
│   ├── run_as_at.mcfunction
│   ├── defer.mcfunction
│   ├── schedule_delay.mcfunction
│   └── run_pending.mcfunction
├── internal/
│   └── dispatch.mcfunction     ← Ortak eylem yönlendirici
├── events/
│   ├── process.mcfunction
│   └── exec.mcfunction
├── config/
│   ├── load.mcfunction
│   ├── list.mcfunction
│   ├── get.mcfunction
│   ├── set.mcfunction
│   ├── set_str.mcfunction
│   ├── reset.mcfunction
│   └── run_on_load.mcfunction
├── version/
│   └── announce.mcfunction
├── messages/
├── sound/
├── player/
├── effect/
├── item/
├── xp/
├── score/
├── bossbar/
├── entity/
├── waypoint/
├── timer/
└── command/

---

## Katkıda Bulunma

> [!NOTE]
> Bu depo kalıcı olarak arşivlenmiştir. Katkılar artık kabul edilmemektedir.

Depo yalnızca referans amaçlı fork'lanabilir.

---

## Lisans

MIT License © 2025 Legends11

---

## Destek

- Issues: [GitHub Issues](https://github.com/asn44nb/EventCoreSystem-Datapack/issues)
- Depo: [GitHub Deposu](https://github.com/asn44nb/EventCoreSystem-Datapack/)

---

<p align="center">
  <b>EventCore — kontrol sende.</b>
</p>
