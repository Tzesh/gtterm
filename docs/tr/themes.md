# Temalar ve ayarlar

[Kılavuz](guide.md) · [Komutlar](commands.md) · [English](../en/themes.md)

40 tema ve birbirinden bağımsız beş prompt görünümü bulunur. Başlangıç **Nord + rounded**, font 15, rahat satır aralığı, ikonlar ve öneriler açık şeklindedir. Sudo, Homebrew, internet bağlantısı veya yeni çalışma ortamı gerekmez.

```sh
gtterm config                      # Etkileşimli ayar menüsü.
gtterm config show                 # Menüyü açmadan tercihleri göster.
gtterm theme list
gtterm theme kanagawa-wave          # Uygula ve kaydet.
gtterm theme preview dracula        # Yalnızca bu oturumda dene.
gtterm style minimal               # Temadan bağımsız uygula ve kaydet.
gtterm config set font-size 17
gtterm config set icons off
```

Kayıtlı tema, adı belirli iTerm profilleri dahil bütün yeni tam gtterm oturumlarında kullanılır. Kayıtlı tercih yoksa açılan profilin kendi rengiyle başlanır. Önizleme kayıtlı temayı değiştirmez. Önizlerken görünüm değiştirmek mevcut önizlemeyi korur; yeni oturum kayıtlı temayla başlar. Diğer açık terminaller kendi ayarlarını siz değiştirene veya `gtterm reload` çalıştırana kadar korur.

## Prompt görünümleri

| Ad | Görünüm |
| --- | --- |
| `rounded` | Yuvarlak uçlu renkli bloklar ve iki satırlı rehber |
| `minimal` | Bloksuz, renkli metinden oluşan iki satır |
| `powerline` | Köşeli ayraçlarla birleşen renkli bloklar |
| `compact` | Tek satır ve sağda daha az bilgi |
| `ascii` | Düz ASCII ayraçları ve komut işareti; prompt için ikon fontu gerekmez |

`gtterm style list` ile listeleyin, Tab ile tamamlayın. Bütün görünümler gitstatusd başlatmadan Git bilgisi gösterir. `compact` ek boş satırı her zaman kapatır. `ascii`, kayıtlı ikon tercihinden bağımsız ikonları gizler; başka görünüme geçince ikon tercihi yeniden uygulanır.

## Ayarlar

| Anahtar | Kabul edilen değerler | Varsayılan |
| --- | --- | --- |
| `theme` | Aşağıdaki tema adlarından biri | `nord` |
| `style` | `rounded`, `minimal`, `powerline`, `compact`, `ascii` | `rounded` |
| `font-size` | 12–22 arası tam sayı | `15` |
| `line-spacing` | `compact`, `normal`, `relaxed` | `relaxed` |
| `icons` | `on`, `off` | `on` |
| `prompt-spacing` | `comfortable`, `compact` | `comfortable` |
| `suggestions` | `on`, `off` | `on` |

`gtterm config set <anahtar> <değer>` kullanın. Font ve satır aralığı yalnızca gtterm profillerini günceller; bunları uygulamak için yeni gtterm sekmesi/penceresi açın. Diğer görünüm ayarları mevcut oturumda hemen uygulanır. Menüde İngilizce/Türkçe dil seçimi de vardır. `gtterm config reset` yalnızca görünümü varsayılana döndürür; dil, proxy ve diğer kişisel ayarları korur.

Tercihler `~/.config/iterm-pack/state/` altında ayrı, doğrulanan metin dosyalarıdır. `zsh install.zsh` güncellemesinde korunur ve dağıtılan ZIP’e eklenmez. Geçersiz kayıtlarda güvenli varsayılan kullanılır; dosya içeriği shell kodu olarak çalıştırılmaz. `gtterm config show` kayıtlı tercihleri, `gtterm status` mevcut etkin tema/görünümü gösterir.

## Tema listesi

| Komut adı | Profil |
| --- | --- |
| `mocha` | Mocha |
| `nord` | Nord |
| `latte` | Latte |
| `frappe` | Catppuccin Frappe |
| `macchiato` | Catppuccin Macchiato |
| `dracula` | Dracula |
| `tokyo-night` | Tokyo Night |
| `tokyo-storm` | Tokyo Night Storm |
| `gruvbox-dark` | Gruvbox Dark |
| `gruvbox-light` | Gruvbox Light |
| `rose-pine` | Rose Pine |
| `rose-pine-moon` | Rose Pine Moon |
| `rose-pine-dawn` | Rose Pine Dawn |
| `solarized-dark` | Solarized Dark |
| `solarized-light` | Solarized Light |
| `one-dark` | One Dark |
| `github-dark` | GitHub Dark |
| `monokai` | Monokai |
| `kanagawa-wave` | Kanagawa Wave |
| `kanagawa-dragon` | Kanagawa Dragon |
| `kanagawa-lotus` | Kanagawa Lotus |
| `everforest-dark` | Everforest Dark Soft |
| `everforest-light` | Everforest Light Soft |
| `nightfox` | Nightfox |
| `carbonfox` | Carbonfox |
| `dawnfox` | Dawnfox |
| `ayu-mirage` | Ayu Mirage |
| `ayu-light` | Ayu Light |
| `iceberg-dark` | Iceberg Dark |
| `iceberg-light` | Iceberg Light |
| `tokyo-day` | Tokyo Night Day |
| `github-light` | GitHub Light Default |
| `night-owl` | Night Owl |
| `poimandres` | Poimandres |
| `material-ocean` | Material Ocean |
| `oxocarbon` | Oxocarbon |
| `synthwave` | Synthwave |
| `cyberpunk` | Cyberpunk |
| `aurora` | Aurora |
| `laserwave` | Laserwave |


Bütün renk dosyaları çevrimdışı kullanım için dahildir. Kaynak sürümleri, dosya özetleri ve atıflar `THEME-SOURCES.json` ve `themes/` içinde bulunur. Tarayıcı galerisi yaklaşık önizlemedir; gerçek karakter görünümü iTerm ve fonta bağlıdır. README olduğu gibi korunmuştur.

[Etkileşimli çevrimdışı galeri](../theme-gallery.html).


[Yerleşik yazı efektleri ve retro fontlar](effects.md), arka plan resmi/saydamlık ayarlarından bağımsızdır.
