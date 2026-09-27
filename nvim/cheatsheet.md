# Neovim Cheatsheet

## Genel
### Aç / Kapat
| Tuş          | Neyi açar / kapatır                                  |
|--------------|------------------------------------------------------|
| `Space t k`  | Otomatik kısayol menüsü (açıkken statusline'da `󰌌`)  |
| `Space t f`  | Kaydederken formatlama                               |
| `Space t b`  | Satır sonunda git blame                              |

### Temel
| Tuş          | İş                                            |
|--------------|-----------------------------------------------|
| `Space ?`    | Kısayol menüsünü aç (her zaman çalışır)       |
| `Space c s`  | Bu cheatsheet                                 |
| `Space c e`  | Cheatsheet'i düzenle                          |
| `Space s k`  | Tüm kısayollarda ara (Telescope)              |
| `:Lazy`      | Eklentileri yönet / güncelle                  |
| `:Mason`     | LSP, formatter, debugger yönet                |
| `:VimBeGood` | Vim pratik oyunu                              |

Otomatik mod açıkken `Space`, `g`, `]`, `d`, `c`, `y` gibi bir tuşa basıp beklersen devamı menüde görünür. Varsayılan kapalı.

## Dosya ve gezinme
| Tuş         | İş                                   |
|-------------|--------------------------------------|
| `Space p v` | Dosya gezgini (Oil)                  |
| `-`         | Üst klasöre çık (Oil)                |
| `Space p f` | Dosya ara (Telescope)                |
| `Space p s` | Dosyaların içinde metin ara (grep)   |
| `Ctrl p`    | Git dosyalarında ara                 |
| `Space s k` | Tüm kısayollarda ara                 |

### Oil — klasörü metin gibi düzenle, `:w` ile uygula
| Yapılacak          | Nasıl                                      |
|--------------------|--------------------------------------------|
| Dosya aç           | `Enter`                                    |
| Üst klasör         | `-`                                        |
| Yeni dosya         | `o` → `ad.ts` yaz → `:w`                   |
| Yeni klasör        | `o` → `klasor/` yaz (sonda `/`) → `:w`     |
| Yeniden adlandır   | `ciw` / `cw` ile adı değiştir → `:w`       |
| Sil (çöpe)         | `dd` → `:w`                                |
| Taşı               | `dd` → diğer klasöre git → `p` → `:w`      |
| Kopyala            | `yy` → diğer klasöre git → `p` → `:w`      |
| Toplu adlandır     | `:%s/eski/yeni/` → `:w`                    |
| Dikey bölmede aç   | `Ctrl v`                                   |
| Önizleme           | `Ctrl p`                                   |
| Yenile / kapat     | `Ctrl r` / `q`                             |
| Tüm kısayollar     | `g?`                                       |

Soldaki git durumu — 1. sütun: stage edilmiş · 2. sütun: edilmemiş
| İşaret | Anlamı                                         |
|--------|------------------------------------------------|
| `M `   | Değişti, stage edildi (commit'e hazır)         |
| ` M`   | Değişti, henüz stage edilmedi                  |
| `MM`   | Stage edildi, sonra tekrar değişti             |
| `A `   | Yeni dosya, stage edildi                       |
| `??`   | Yeni dosya, git'e hiç eklenmemiş               |
| ` D`   | Silindi                                        |
| `R `   | Yeniden adlandırıldı                           |
| `!!`   | .gitignore'da (yok sayılıyor)                  |
Klasörde işaret varsa içinde o durumda dosya var.

## Harpoon
| Tuş        | İş                          |
|------------|-----------------------------|
| `Space a`  | Dosyayı Harpoon'a ekle      |
| `Ctrl e`   | Harpoon menüsü              |
| `Ctrl h`   | 1. dosya                    |
| `Ctrl t`   | 2. dosya                    |
| `Ctrl n`   | 3. dosya                    |
| `Ctrl s`   | 4. dosya                    |

## Kaydırma ve arama
| Tuş        | İş                                    |
|------------|---------------------------------------|
| `Ctrl d`   | Yarım sayfa aşağı (ortada kalır)      |
| `Ctrl u`   | Yarım sayfa yukarı (ortada kalır)     |
| `/` `?`    | İleri / geri ara                      |
| `n` `N`    | Sonraki / önceki sonuç                |
| `*`        | İmleçteki kelimeyi ara                |

## Textobjects — fiil + a/i + nesne
Fiiller: `d` sil · `c` değiştir · `y` kopyala · `v` seç
`a` = tamamı (etrafıyla) · `i` = sadece içi

| Nesne         | Tamamı | İçi   | Örnek                          |
|---------------|--------|-------|--------------------------------|
| Function      | `af`   | `if`  | `daf` fonksiyonu sil           |
| Class         | `ac`   | `ic`  | `yac` class'ı kopyala          |
| Argüman       | `aa`   | `ia`  | `cia` argümanı değiştir        |
| if / koşul    | `ai`   | `ii`  | `dai` if bloğunu sil           |
| Loop          | `al`   | `il`  | `cil` döngü içini değiştir     |
| Kelime        | `aw`   | `iw`  | `ciw` kelimeyi değiştir        |
| Tırnak        | `a"`   | `i"`  | `ci"` tırnak içini değiştir    |
| Parantez      | `a(`   | `i(`  | `di(` parantez içini sil       |
| Süslü parantez| `a{`   | `i{`  | `yi{` blok içini kopyala       |
| Köşeli        | `a[`   | `i[`  | `di[` dizi içini sil           |
| Paragraf      | `ap`   | `ip`  | `yap` paragrafı kopyala        |

JSON: `aa` / `ia` = `"key": value` çifti veya dizi elemanı

### Kod içinde atlama
| Tuş         | İş                        |
|-------------|---------------------------|
| `]f` `[f`   | Sonraki / önceki function |
| `]c` `[c`   | Sonraki / önceki class    |
| `%`         | Eşleşen paranteze git     |

## Düzenleme
| Tuş               | İş                                        |
|-------------------|-------------------------------------------|
| `gcc`             | Satırı yorum yap / geri al                |
| `gc` (visual)     | Seçimi yorum yap                          |
| `gcap` / `gcaf`   | Paragrafı / fonksiyonu yorum yap          |
| `J` / `K` (visual)| Seçili satırları aşağı / yukarı taşı      |
| `<` / `>` (visual)| Girinti ver (seçim kalır)                 |
| `J`               | Alt satırı bu satıra birleştir            |
| `Space p` (visual)| Seçimin üstüne yapıştır, kopyalanan kalır |
| `Space r`         | İmleçteki kelimeyi tüm dosyada değiştir   |
| `Space u`         | Undotree (geri alma geçmişi)              |
| `u` / `Ctrl r`    | Geri al / ileri al                        |
| `Esc`             | Arama vurgusunu kaldır                    |
| `Option ⌫` (insert)| Önceki kelimeyi sil                      |
| `Ctrl w` (insert) | Önceki kelimeyi sil (aynısı)              |
| `Ctrl u` (insert) | Satır başına kadar sil                    |

Parantez, tırnak otomatik kapanır: `(` yazınca `)` gelir.

## Git
| Tuş          | İş                                          |
|--------------|---------------------------------------------|
| `Space g g`  | LazyGit (commit, push, branch, her şey)     |
| `Space g d`  | Tüm değişiklikler yan yana diff             |
| `Space g h`  | Bu dosyanın geçmişi                         |
| `Space g H`  | Projenin commit geçmişi                     |
| `Space g q`  | Diff penceresini kapat                      |
| `]h` `[h`    | Sonraki / önceki değişiklik (hunk)          |
| `Space h p`  | Değişikliği önizle                          |
| `Space h s`  | Değişikliği stage et (visual'da seçimi)     |
| `Space h r`  | Değişikliği geri al (reset)                 |
| `Space h S`  | Tüm dosyayı stage et                        |
| `Space h R`  | Tüm dosyayı reset et                        |
| `Space h b`  | Bu satırı kim, ne zaman yazdı               |
| `Space t b`  | Satır sonunda blame aç / kapat              |
| `dih` `vih`  | Değişikliği sil / seç (textobject)          |

Kenar çubuğu: `▎` yeşil eklendi · sarı değişti · kırmızı `` silindi

## LSP
| Tuş          | İş                                   |
|--------------|--------------------------------------|
| `gd`         | Tanıma git                           |
| `gD`         | Deklarasyona git                     |
| `gr`         | Kullanıldığı yerler                  |
| `gI`         | Implementasyona git                  |
| `gy`         | Tip tanımına git                     |
| `K`          | Dokümantasyon                        |
| `Space c a`  | Code action (import ekle, düzelt)    |
| `Space e`    | Satırdaki hatayı göster              |
| `Space p d`  | Tüm hatalar (Telescope)              |
| `]d` `[d`    | Sonraki / önceki hata                |
| `Space d s`  | Dosyadaki semboller                  |
| `Space w s`  | Projedeki semboller                  |
| `Ctrl o`     | Geri dön (gd sonrası)                |
| `:Mason`     | Server yönet                         |

### Trouble — listeler (alt/yan panel)
| Tuş          | İş                                   |
|--------------|--------------------------------------|
| `Space x x`  | Projedeki tüm hatalar                |
| `Space x b`  | Bu dosyadaki hatalar                 |
| `Space x s`  | Semboller (yan panel)                |
| `Space x r`  | Tanım / kullanım yerleri (LSP)       |
| `Space x q`  | Quickfix listesi                     |
| `]x` `[x`    | Listede sonraki / önceki öğeye atla  |
Panel içinde: `Enter` git · `o` git ve kapat · `p` önizle · `q` kapat

### Formatlama
Kaydederken (`:w`) otomatik formatlar (`~/notes` hariç).

| Tuş             | İş                                  |
|-----------------|-------------------------------------|
| `Space f`       | Şimdi formatla (seçimde de çalışır) |
| `Space t f`     | Kaydederken formatlamayı aç/kapat   |
| `:ConformInfo`  | Bu dosyada hangi formatter çalışıyor |

### Autocomplete (insert modda)
| Tuş               | İş                          |
|-------------------|-----------------------------|
| `Ctrl y`          | Öneriyi kabul et            |
| `Ctrl n` `Ctrl p` | Sonraki / önceki öneri      |
| `Ctrl space`      | Menüyü aç / dokümantasyon   |
| `Ctrl e`          | Menüyü kapat                |
| `Ctrl k`          | Parametre bilgisi           |

## Debug
| Tuş          | İş                                        |
|--------------|-------------------------------------------|
| `Space b`    | Breakpoint koy / kaldır                   |
| `Space B`    | Koşullu breakpoint (ör. `i == 5`)         |
| `F5`         | Debug başlat / devam et                   |
| `F10`        | Sonraki satır (step over)                 |
| `F11`        | Fonksiyonun içine gir (step into)         |
| `F12`        | Fonksiyondan çık (step out)               |
| `Space d c`  | Başlat / devam (F5 ile aynı)              |
| `Space d t`  | İmleçteki testi debug et (Go, Python)     |
| `Space d l`  | Son debug'ı tekrar çalıştır               |
| `Space d q`  | Debug'ı durdur                            |
| `Space d u`  | Debug panellerini aç / kapat              |
| `Space d e`  | İmleçteki / seçili değeri göster          |

Kenar: `●` breakpoint · `◆` koşullu · `▶` şu an durulan satır
Değişken değerleri debug sırasında satır sonunda görünür.

### Diller
| Dil        | Nasıl                                          |
|------------|------------------------------------------------|
| Python     | `F5` → dosyayı çalıştırır                      |
| Go         | `F5` → paketi çalıştırır · `Space d t` test    |
| JS         | `F5` → "Bu dosyayı çalıştır"                   |
| TS         | `F5` → `npx tsx` ile çalıştırır                |
| Çalışan    | `node --inspect` ile başlat, `F5` → "bağlan"   |

## Obsidian
Vault: `~/notes` · Günlükler: `Journal/Daily/YYYY-MM-DD`
`Space o` kısayolları her klasörden çalışır.

| Tuş          | İş                                         |
|--------------|--------------------------------------------|
| `Space o o`  | Not aç (isimle ara) — asıl geçiş tuşu      |
| `Space o s`  | Notların içinde ara                        |
| `Space o n`  | Yeni not                                   |
| `Space o d`  | Bugünün günlüğü                            |
| `Space o y`  | Dünün günlüğü                              |
| `Space o D`  | Tüm günlükler                              |
| `Space o b`  | Bu nota link verenler (backlinks)          |
| `Space o l`  | Bu nottaki linkler                         |
| `Space o t`  | Etiketler (#tag)                           |
| `Space o r`  | Notu yeniden adlandır (linkler güncellenir)|
| `Space o c`  | İçindekiler                                |
| `Space o x`  | Checkbox işaretle `- [ ]` ↔ `- [x]`        |
| `Space o a`  | Obsidian uygulamasında aç                  |
| `Space o k`  | (visual) Seçimi mevcut nota linkle         |
| `Space o K`  | (visual) Seçimden yeni not + link          |

### Not içinde
| Tuş            | İş                                   |
|----------------|--------------------------------------|
| `[[` yaz       | Not adı tamamlama menüsü             |
| `gd` / `Enter` | Linke git (`[[not]]` üstünde)        |
| `Ctrl o`       | Geri dön                             |
| `K`            | Link önizle                          |
| `gr`           | Bu nota link verenler                |

## tmux
| Tuş                    | İş                                  |
|------------------------|-------------------------------------|
| `Ctrl a [`             | Copy mode (geçmişte gezin)          |
| `v` / `V` / `Ctrl v`   | Seç / satır seç / blok seç          |
| `y`                    | Panoya kopyala ve çık               |
| `Esc` / `q`            | Copy mode'dan çık                   |
| `Ctrl a f`             | Proje / session seçici              |
| `Ctrl a D`             | ~/notes/todo.md aç (popup)          |
