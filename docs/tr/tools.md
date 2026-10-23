# Araçlar ve hazır çalışma görünümleri

[Rehber](guide.md) · [Komutlar](commands.md) · [English](../en/tools.md)

## Kurulum ve güncelleme

Yeni temiz ZIP'i ayrı bir klasöre aç. İçindeki `gtterm` klasöründe ilk kurulum ve güncelleme için aynı komut kullanılır:

```sh
zsh install.zsh --trust-tools
```

Sudo, Homebrew, paket yöneticisi, yönetici parolası veya kurulum sırasında indirme gerekmez. Apple Silicon ve Intel dosyaları birlikte gelir; çalışan mimari otomatik seçilir. İlk beş araç macOS 11+, yeni lazygit dosyaları macOS 12+, jq dosyaları macOS 14+, güncel Fastfetch macOS 26+ gerektirir. Bottom macOS 11+ tabanını destekler. Eski sistemlerde yalnızca ilgili araç çalıştırılmadan gereksinim mesajı verir; diğer özellikler kullanılabilir. Yalnızca sistem kütüphaneleri kullanılır. Mevcut iTerm, Zsh ve Java gereksinimleri değişmez; JDK veya iTerm uygulaması kurulmaz.

`--trust-tools`, tüm araç manifesti SHA256 ile doğrulandıktan sonra yalnızca dokuz paket komut başlatıcısının ve seçilen mimarideki dokuz çalıştırılabilir dosyanın macOS karantina özniteliğini kaldırmak için açık seçimdir. Yalnızca güvendiğin pakette kullan. Gatekeeper ayarları, başka dosyalar ve kurum politikaları değiştirilmez. Sağlama toplamı hasarı algılar; yayıncı imzası değildir. Kaynaklar, sürümler, özetler ve lisanslar `TOOLS-SOURCES.json` ve `tools/licenses/` içinde bulunur.

Seçenek verilmezse karantina korunur. Engellenen araç `gtterm tools` ile bildirilir; kabuk açılışında çalıştırılmaz ve entegrasyonu atlanır. Doğrulanmış araçları etkinleştirmek için aynı kurulum komutunu seçenekle tekrar çalıştır. Kurum yönetimi ayrıca engel koyabilir; gtterm bunu aşmaz. gitstatusd için mevcut çözüm korunur.

Güncelleme görünüm, dil, proxy, `local.zsh`, geçmiş, seçili iTerm varsayılanı ve zoxide veritabanını korur; eski çalışma dosyalarının özel yedeğini alır. Önce kaldırma işlemi yapma. Yeni entegrasyonlar için güncellemeden sonra yeni gtterm sekmesi aç. Bu, indirilen paketi yerel olarak günceller; GitHub'dan yeni sürüm indiren bir komut değildir.

## Dahil edilen araçlar

| Komut | Sabit sürüm | Örnek |
|---|---|---|
| `fzf` | 0.64.0 | `printf 'dev\nstaging\n' | fzf` |
| `zoxide` | 0.10.0 | `gtterm jump backend` |
| `rg` | 15.2.0 | `rg -n 'class .*Service' src` |
| `fd` | 10.5.0 | `fd '\.java$' src` |
| `bat` | 0.26.1 | `bat --paging=never pom.xml` |
| `lazygit` | 0.66.2 | `lazygit` |
| `jq` | 1.8.2 | `jq . file.json` |
| `btm` | 0.14.9 | `gtterm monitor tree` |
| `fastfetch` | 2.70.0 | `gtterm sysinfo` |

Standart araç adları `gtterm` ile birlikte kullanılabilir; eski kısayol aliasları geri gelmez. gtterm yükleyen kabuklarda paket araçları PATH'teki diğer sürümlerin önüne geçer. Diğer oturumlar etkilenmez. Kişisel ayarlar `local.zsh` içinde tutulabilir.

`rg` ve `fd` normalde ignore dosyalarına uyar, gizli girdileri atlar. Seçenekler için kendi `--help` çıktılarını kullan. `bat` ANSI renkleriyle terminal paletini takip eder. fzf renkleri tema değişimini izler; kişisel fzf seçenekleri gtterm görünüm seçeneklerinden önce korunur. İş bilgisayarında derleme yapılmaz.

## Klavye kısayolları

Tam gtterm profilinde:

| Kısayol | İşlev |
|---|---|
| Ctrl+R | Geçmişte ara; Enter seçimi satıra getirir, tekrar Enter çalıştırır |
| Ctrl+T | Dosya/dizin seçip yolunu güvenli tırnaklarla satıra ekle; bat dosya önizlemesi sunar |
| Option+C / Alt+C | Dizin seçip içine gir |
| Esc | Seçiciyi iptal et |

Tab mevcut Zsh tamamlama sisteminde kalır. Option+C için iTerm profilinin Keys ayarlarında Option tuşunun Esc+ göndermesi gerekebilir. Yalnızca yardımcı komutların yüklendiği normal kabuklarda klavye atamaları değiştirilmez. Geçmiş ve dosya aramaları yereldir; geçmişte hassas bilgi bulunabilir.

## Dizinler arasında geçiş

```sh
gtterm jump                 # Ana dizin
gtterm jump backend         # Önceden ziyaret edilen en uygun eşleşme
gtterm jump -i              # fzf ile etkileşimli seçim
gtterm jump './folder with spaces'
```

Tam gtterm oturumları dizin ziyaretlerini zoxide ile kaydeder. Veritabanı `~/.config/iterm-pack/state/zoxide` içinde kalır, güncellemede korunur ve dağıtım ZIP'ine girmez. Yeni veritabanı dizini özel izinlerle oluşturulur. `z` veya `zi` aliasları eklenmez. Eşleşme yoksa zoxide bunu bildirir. `gtterm tools` durum/sürüm gösterir; `gtterm tools verify` araçları çalıştırmadan kurulu araç manifestini doğrular.

## Work, Focus ve Presentation

```sh
gtterm preset list
gtterm preset work
gtterm preset focus
gtterm preset presentation
gtterm config
```

| Görünüm | Prompt | Font | Satırlar | İkonlar | Prompt boşluğu | Öneriler |
|---|---|---|---|---|---|---|
| Work | rounded | 15 | relaxed | on | comfortable | on |
| Focus | minimal | 14 | compact | off | compact | on |
| Presentation | minimal | 20 | relaxed | off | comfortable | off |

Hazır görünümler bu altı ayarı birlikte kaydeder. Tema, dil, proxy ve iTerm varsayılanı korunur. İlk varsayılan yine Nord'dur. Prompt tam profilde hemen; font ve satır aralığı yeni gtterm sekmelerinde uygulanır. Diğer açık kabuklar ayarları yeniden yükleyebilir. Ayar menüsünde `p` ile seçim yapılır. Sonrasında ayarları tek tek değiştirebilirsin; `gtterm config show` gerçek değerleri gösterir. Presentation önerileri kapatır, ekran paylaşımından geçmişi, çıktıyı veya parolaları gizlemez.


## 3.0 CLI çalışma alanı

[Control+Esc hotkey, canlı paletler, isteğe bağlı efektler ve CLI uyumluluğu](cli.md), [güvenli tekrar kullanılabilir parçalar](snippets.md). Komutlar: `gtterm hotkey`, `gtterm effect`, `gtterm cli`, `gtterm snippet`.

| Ek araç | Sabit sürüm |
|---|---|
| `lazygit` | 0.66.2 |
| `jq` | 1.8.2 |

`lazygit` mevcut Git kurulumunu kullanır; gtterm Git veya Command Line Tools kurmaz. `jq` JSON biçimlendirme/sorgulama içindir. İkisi de CPU dosyaları, lisansları ve SHA256 kayıtlarıyla gelir.

Paket lazygit ayarında otomatik fetch ve güncelleme kontrolü kapalıdır. Seçtiğin manuel fetch/push işlemleri kullanılabilir. Kendi `LG_CONFIG_FILE` ayarın varsayılanı değiştirir. Genel Git ayarları değiştirilmez.


## Mac araçları ve kaynak izleyici

[Mac komut kılavuzu](mac.md): `gtterm monitor`, `gtterm sysinfo`, `gtterm finder`, `gtterm preview`, `gtterm copy-path`, `gtterm copy`, `gtterm disk`, `gtterm awake` ve `gtterm background`.


[Yerleşik yazı efektleri ve retro fontlar](effects.md), arka plan resmi/saydamlık ayarlarından bağımsızdır.
