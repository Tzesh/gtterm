# Yerleşik yazı efektleri ve retro fontlar

[Komutlar](commands.md) · [Arka plan/sekmeler/durum](visual.md) · [English](../en/effects.md)

`gtterm effect`, yerleşik yazı/font/renk/imleç görünümünü değiştirir. `gtterm background`, bağımsız olarak off/glass/frost/retrowave resim/saydamlık/bulanıklık seçeneklerini korur. İkisi ayrı kaydedilir. İlk kullanım varsayılanları Nord, arka plan kapalı, efekt kapalıdır.

```sh
gtterm effect list
gtterm effect retro
gtterm effect fallout
gtterm effect amber
gtterm effect typewriter
gtterm effect neon
gtterm effect status
gtterm effect off
```

| Görünüm | Font ve renkler | Yerleşik imleç |
|---|---|---|
| off | Seçili tema ve normal Meslo fontu | Kaydettiğin imleç şekli |
| retro | VT323 piksel tarzı ASCII font, seçili tema renkleri | Sabit blok |
| fallout | VT323, koyu yeşilde parlak yeşil yazı | Yanıp sönen blok, hareket animasyonu |
| amber | VT323, siyaha yakın zeminde amber yazı | Yanıp sönen blok, hareket animasyonu |
| typewriter | Courier, sıcak sepya yazı ve koyu kahverengi | Sabit blok |
| neon | Kalın Meslo, açık camgöbeği yazı ve magenta imleç | Yanıp sönen blok, hareket animasyonu |

Efekt değişiminden önce gtterm, aynı gtterm profilini iTerm’e yeniden uygulatır; böylece oturuma özgü font/yakınlaştırma ayarları temizlenir. Ardından paylaşılan profil güncellemesi fontu mevcut sekmede değiştirebilir; yeni sekmeler de güncel profili devralır. Varsayılan profil değiştirilmez. Canlı istek yalnızca yerel ve etkileşimli bir gtterm iTerm oturumunda gönderilir; yönlendirilmiş çıktı, SSH, tmux, screen ve diğer terminallerde profil değiştirme dizisi gönderilmez. Tüm tema profilleri ve hotkey bu görünümü alır. `off`, her temanın temel renk/font özelliklerini ve kaydedilmiş font boyutu, satır aralığı, imleç şeklini geri getirir. Seçili tema ve arka plan modu değişmez. gtterm dışında elle değiştirilmiş profil alanları, efektin yönettiği alanlarda yeniden yazılabilir.

```sh
gtterm background glass
gtterm effect fallout
gtterm config set font-size 18
# iTerm profil değişimi izni sorarsa izin verip gtterm effect apply çalıştır.
gtterm effect off                  # Glass açık kalır
gtterm background off              # Ayrı kontrol
```

Aranabilir menüde yazı efekti ve arka plan ayrı seçeneklerdir. Ayarlar menüsünde `e` yazı görünümünü, `g` arka planı seçer. `gtterm config set effect amber` ve `gtterm config set background frost` ayrı ayarlardır. `config reset`, ikisini de sıfırlar.

## CLI uyumu ve sınırlar

Bunlar **yerleşik iTerm2 görünümleridir; CRT shader’ı değildir**. iTerm2 3.6.10; özel CRT parlaması, tarama shader’ı, ekran eğriliği veya 3D çizim eklentisi sunmaz. `gtterm effect crt`, `bloom`, `scanlines`, `3d` komutları ayar değiştirmeden sınırı açıklar. Başka terminal kurulmaz. Ekran flaşı, sürekli OSC/renk döngüsü, CLI üstüne çizim yapan betik veya yeni klavye eşlemesi eklenmez.

Retro görünümlerde ASCII için paketli VT323, Unicode/Nerd karakterleri için aynı boyutta Meslo ve yerleşik Powerline glif çizimi kullanılır. Unicode genişlik tabloları, klavye ve yapıştırma protokolleri değişmez. Efekt; varsayılan yazı/zemin/imleç/seçim/sekme renklerini değiştirir; hata/uyarı/diff ayrımını korumak için temanın on altı ANSI rengine dokunmaz. Kendi truecolor renklerini kullanan CLI’lar bunları koruyabilir; her uygulama tamamen tek renge dönüşmez. Yoğun Unicode arayüzünü tercih ettiğin fontla kontrol et; `off`, normal yazıyı geri getirir.

Efekt açıkken blok imleç kullanılır; normal imleç tercihi kayıtta korunur ve `effect off` ile döner. Hareket animasyonu yerleşik imleç esnemesidir; yazı parlaması veya fosfor izi değildir. Sabit imleç için `retro`/`typewriter` veya kapalı efekti seç. Tüm görünümler arka plan seçenekleriyle birleşir; tarama çizgisi resmi eklenmez.

## Güncelleme ve font lisansı

Eski `state/effect`, arka plan anlamındaydı; yeni açık arka plan ayarı yoksa geri dönüş olarak kullanılır ve dosya aynen tutulur. Yeni arka plan `state/background`, yazı görünümü `state/visual-effect` içinde kaydedilir. Veri kod olarak çalıştırılmaz; eski dosya yıkıcı biçimde yeniden yazılmaz. Tekrarlanan güncelleme/yükleme iki tercihi de korur. Eski açık shell’de yeni komutları kullanmadan önce `gtterm reload` çalıştır.

VT323, SIL Open Font License ile paketlidir; lisansı `fonts/VT323-OFL.txt`, sabitlenmiş kaynak ve SHA256 değeri `FONT-SOURCES.json` içindedir. Normal çevrimdışı kurulum yalnızca kullanıcı Fonts klasörüne kopyalar; sudo, Homebrew veya kurulum sırasında indirme yoktur. Meslo ve font boyutu tercihleri korunur. Courier macOS ile gelir.

[VT323 kaynağı](https://github.com/google/fonts/tree/2da41909d08a7bfeab32cfc163edb7be0c34395d/ofl/vt323) · [iTerm yazı ayarları](https://iterm2.com/documentation-preferences-profiles-text.html) · [iTerm3.6.10 profil anahtarları](https://github.com/gnachman/iTerm2/blob/v3.6.10/sources/ITAddressBookMgr.h).

[Font önizleme galerisi](../effect-gallery.html) gerçek paket fontlarını kullanır; tarayıcı çizimi iTerm’den farklı olabilir.

## Font değişmiyorsa

Fallout ve amber bilerek aynı **VT323** fontunu kullanır; renkleri değişir, font ailesi değişmez. Off, **MesloLGS NF Regular**; typewriter, **Courier**; neon, **MesloLGS NF Bold** kullanır.

iTerm, Dynamic Profiles dosyasındaki font doğru olsa bile oturuma özgü font/yakınlaştırma tercihini koruyup yeni sekmeye aktarabilir. Efekt, font boyutu/imleç ayarı, hazır görünüm ve sıfırlama işlemleri artık profil dosyasını yazmadan **önce** yerleşik profil bağlantısını yeniler; eski yerel tercih yeni fontun önüne geçmez. Başka sekmelere dokunulmaz. Bu, mevcut gtterm profilinin ayarlarını yeniden uygular ve o sekmenin yerel görünüm değişikliklerini temizler; varsayılan profili değiştirmez, gtterm dışı profili dönüştürmez.

```sh
gtterm reload
gtterm effect off
gtterm effect fallout
gtterm effect amber     # Aynı VT323 ailesi, amber renkler
gtterm effect apply     # Seçimi değiştirmeden mevcut profili yeniden uygula
```

İlk kullanımda iTerm, kontrol dizilerinin profil değiştirmesine izin verilip verilmeyeceğini sorabilir. İzin verirsen ardından bir kez `gtterm effect apply` çalıştır; ilk reddedilen istek otomatik yinelenmez. gtterm bu izni değiştirmez; yönetici yetkisi, Automation, AppleScript veya Python API erişimi istemez. iTerm politikası engelliyorsa Profiles menüsünden gtterm profilini elle yeniden seç. Dosyada doğru font bulunması, oturumun gerçekten o fontla çizildiğini tek başına kanıtlamaz.

## Normal yazı görünümüne dönüş

`gtterm effect off`, Meslo Regular fontunu, ASCII/Unicode yazı yumuşatmayı, tema/seçim/sekme renklerini, Retina ekranlarda ince çizgileri ve normal Powerline çizimini açıkça geri yükler; imleç yanıp sönmesi ve hareket animasyonu kapanır. Kayıtlı imleç şekli, font boyutu ve satır aralığı yeniden uygulanır. Seçili arka plan bağımsız kalır; onu da kapatmak için ayrıca `gtterm background off` kullanın. On altı ANSI rengi ve klavye protokolleri değiştirilmez.

Font Meslo olduğu halde yazı pürüzlü görünüyorsa genel Settings yerine açık sekmede **Cmd+I → Text → Anti-aliased** ayarına bakın. Güncellemeden sonra `gtterm reload; gtterm effect off; gtterm effect apply` çalıştırın. iTerm mevcut profil değiştirme iznini sorabilir; gtterm bu güvenlik tercihini değiştirmez.
