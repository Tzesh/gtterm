# gtterm kullanım kılavuzu

[README](../../README.md) · [Komutlar](commands.md) · [Sorun giderme](troubleshooting.md) · [English](../en/guide.md)

## Paketin içeriği

Tam iTerm profilleri Oh My Zsh, Powerlevel10k, MesloLGS NF, zsh-autosuggestions, zsh-autocomplete, zasync ve komut renklendirmesini bir araya getirir. 40 profil bulunur: örneğin **gtterm - Mocha** koyu/pastel, **gtterm - Nord** soğuk gri/mavi, **gtterm - Latte** açık temadır. Öneriler, vurgu renkleri ve prompt aynı paleti kullanır. Önceki komutların prompt'u kısalarak çıktılara yer açar.

Yardımcı komutlar normal Zsh oturumlarında da kullanılabilir. Ancak yalnızca yardımcı komutları yüklemek, normal profile tüm görünümü ve eklentileri eklemez. `gtterm doctor` hangi durumda olduğunuzu gösterir.

## Kurulum

ZIP'i açın. `zsh /gercek/yol/gtterm/install.zsh` çalıştırın veya Terminal'e `zsh ` yazıp kurulum dosyasını pencereye sürükleyin. Örnekteki yol yerine gerçek dosyanın yolunu kullanın.

Türkçe kurulum için komutun sonuna `--lang tr` ekleyin. Varsayılan İngilizcedir. Kurucu macOS/Zsh sürümünü kontrol eder, paket dosyalarını kopyalar, eksik kullanıcı fontlarını ekler ve 40 dinamik iTerm profili kaydeder. Var olan `.zshrc` dosyasını kurulum klasörüne yedekler; mevcut satırları değiştirmeden işaretli bir yardımcı komut bloğu ekler.

Kurucu **gtterm - Nord** profilini varsayılan kaydeder; önceki varsayılanı kaldırmada geri yüklemek üzere saklar. Hemen **iTerm → Profiles → gtterm - Nord** açabilir veya kaydedilen varsayılanın geçerli olması için uygun olduğunda iTerm’i yeniden açabilirsiniz. Varsayılanı değiştirmek açık oturumları dönüştürmez. gtterm iTerm'i kapatmaz veya çalışan işlerinizi kesmez.

Yeni bir normal Zsh terminali yardımcı komut bloğunu yükler. Açık eski terminalde:

```sh
source ~/.config/iterm-pack/devtools.zsh
```

## Dil seçimi

```sh
gtterm lang        # Geçerli dili göster.
gtterm lang tr     # Türkçe mesajlar ve kılavuzlar.
gtterm lang en     # İngilizceye dön.
```

Tercih bu Mac'te `state/language` dosyasında saklanır. Mevcut terminal ve sonraki oturumlar seçilen dili kullanır. Başka açık terminallerde `gtterm reload` çalıştırın. Yalnızca `en` ve `tr` kabul edilir; kayıtlı değer geçersizse İngilizceye dönülür. Üçüncü taraf eklentilerin ve işletim sisteminin mesajları gtterm tarafından çevrilmez.

## Java/JBoss ile günlük çalışma

```sh
gtterm doctor
gtterm java
gtterm ports java
gtterm ports 8080
gtterm chrome
```

`gtterm java`, JDK içindeki `jps -l` aracını kullanarak JVM kimliklerini ve ana sınıf/JAR adlarını gösterir. JVM parametrelerini veya ortam değişkenlerini istemez. JDK aracı bulunmazsa Java süreç adlarına döner. `gtterm ports`, görülebilen TCP dinleyicilerini, PID'leri ve süreç adlarını listeler. İki komut da süreç durdurmaz veya sunucuyu değiştirmez.

JBoss filtresi uygulama kimliğini değil, sık kullanılan portları kontrol eder. Örneğin 8080'i bir proxy de kullanabilir. Özel port veya port-offset kullanıyorsanız `gtterm ports java` ya da belirli port numarasını kullanın. Başka kullanıcıların süreçlerini görebilmeniz macOS izinleriyle sınırlıdır.

`gtterm chrome`, ayrı Chrome geliştirme profilinde `http://jboss.local` açar ve bu adı 127.0.0.1'e eşler. Hosts dosyası değiştirilmez. Portsuz HTTP, 80 portunu kullanır. JBoss 8080'de çalışıyorsa adres çubuğunda `http://jboss.local:8080` kullanın veya 80 portundan yönlendiren bir servis sağlayın. gtterm bu yönlendirme servisini kurmaz.

## Proxy kullanımı

```sh
gtterm proxy on 127.0.0.1:8080   # Örnek adres; kendi HTTP proxy'nizi yazın.
gtterm proxy auto on            # Sonraki oturumlarda da otomatik aç.
gtterm proxy status
gtterm proxy off                # Yalnızca bu oturum; auto tercihi korunur.
gtterm proxy auto off           # Bu oturumda ve otomatik başlangıçta kapat.
```

HTTP ve HTTPS istekleri için aynı HTTP proxy uç noktası atanır. gtterm, ortam değişkenlerini destekleyen komut satırı istemcileri için küçük/büyük harfli değişkenleri ayarlar. Proxy sunucusu başlatmaz, macOS ağ proxy'sini değiştirmez ve başka yerde çalışan uygulamaları yeniden yapılandırmaz. Tarayıcı/sistem proxy kuralları ayrıdır.

Localhost, 127.0.0.1, ::1 ve `.local` adresleri `no_proxy`/`NO_PROXY` listesine eklenir; mevcut istisnalar korunur. Kapatma HTTP/HTTPS değişkenlerini ve miras alınmış `ALL_PROXY`/`all_proxy` değerlerini temizler; istisna listeleri kalır. Diğer açık terminaller kendi ortamlarını korur. Başka bir proxy etkin süreçten açılan alt süreç, otomatik başlangıç kapalı olsa da o ortamı devralabilir.

Bu sürüm proxy adresinde kullanıcı/parola, SOCKS URL'si ve IPv6 proxy sunucusu kabul etmez. Alan adı veya IPv4 adresi ve port kullanın. Kaydedilen adres ve tercihler dağıtılacak ZIP'e eklenmez.

## Klavye ve görünüm

- En az iki karakter yazınca tamamlama listesi açılır; Tab tamamlar, aşağı ok seçeneklere geçer.
- Satır sonundayken sağ ok soluk geçmiş önerisini kabul eder. Option+F kelime ilerletir/kabul eder.
- Ctrl+R geçmişte arar.
- Cmd+D / Cmd+Shift+D iTerm bölmesini dikey/yatay böler.
- Cmd+Option+ok bölmeler arasında geçer; Cmd+Shift+Enter seçili bölmeyi büyütür/geri getirir.
- `gtterm theme <ad>` temayı mevcut ve yeni oturumlar için kaydeder. `gtterm theme preview <ad>` yalnızca mevcut oturumda dener.

Prompt için kurulum klasöründeki `p10k.zsh`, profil görünümü için dinamik profil JSON'u düzenlenebilir. Burada `p10k configure` kullanmayın: sihirbaz paketin dosyası yerine normal varsayılan dotfile'lara yazabilir.

## Kişisel ayarlar ve dosyalar

Tam profil kendi `.zshrc` dosyasını kullanır. `~/.zprofile` yüklenir; normal `~/.zshrc` ikinci kez yüklenmez. Makineye özel PATH, JAVA_HOME ve alias'ları `~/.config/iterm-pack/local.zsh` içine koyun. Bu dosyadan ikinci bir Oh My Zsh, tamamlama başlangıcı veya tema yüklemeyin.

| Konum | İçerik |
|---|---|
| `~/.config/iterm-pack/` | gtterm çalışma dosyaları; uyumluluk için eski yol korunur |
| `state/language`, `state/proxy-url`, `state/proxy-auto` | Bu Mac'e özel düz veri tercihleri |
| `local.zsh` | İsteğe bağlı kişisel ayarlar |
| `~/Library/Application Support/iTerm2/DynamicProfiles/terminal-pack.json` | Sabit kimlikli gtterm profilleri |
| `~/Library/Application Support/Terminal Pack/Chrome/<alan.adi>` | Her eşlenen adın ayrı Chrome geçmişi/çerezleri |
| `~/.zsh_history` | Bu Mac'in mevcut komut geçmişi |

## İş Mac'ine taşıma

Temiz ZIP'i kopyalayıp kurun. İki işlemci mimarisinin gitstatus dosyaları, fontlar, eklentiler ve belgeler pakettedir. Kişisel proxy adresi, geçmiş, `local.zsh`, parola, orijinal `.zshrc` yedeği ve Chrome verileri pakette yoktur. İşyerindeki adresi ve isteğe bağlı dili orada seçin. Kurumsal politikalar Chrome'un komut satırı bayraklarıyla açılmasını kısıtlayabilir.

## Mevcut kurulumu yükseltme veya geri dönme

Yeni ZIP’i ayrı klasöre açın. İlk kurulumda da güncellemede de aynı komutu çalıştırın:

```sh
zsh install.zsh
```

Mevcut kurulum otomatik bulunup güncellenir. Önce kaldırmayın. `state/` (dil, proxy ve ilk varsayılan profil kaydı), `local.zsh`, `custom/`, orijinal shell yedeği, font kayıtları, mevcut `.zshrc` ve seçili iTerm varsayılanı korunur. Kaydedilen dili özellikle değiştirmek isterseniz `--lang tr` veya `--lang en` ekleyin.

Yeni dosyalar geçici klasörde hazırlanır. `~/.config/iterm-pack-backups/` altında önceki çalışma klasörü ve dinamik profil özel yedek olarak saklanır; tam yolu tamamlanma mesajında gösterilir. Yedek kişisel ayar içerir: paylaşmayın. Çalışma klasörü/profil geçişi başarısız olursa eski kurulum otomatik geri yüklenir. Başarılı güncellemenin yedeği siz silene kadar tutulur; kaldırıcı yedekleri silmez.

Yeni bir gtterm profili açıp `gtterm version` ve `gtterm doctor` çalıştırın. Açık oturumlar yeni oturum açılana kadar bellekteki eski kodu kullanır. Eşzamanlı güncelleme çalıştırmayın. Paket program dosyaları ve gtterm profillerinin görünümü yenilenir; kişisel değişiklikleri `local.zsh` içinde tutun.

Başarılı güncellemeden sonra elle geri dönmek için gtterm oturumlarından çıkın, yeni çalışma klasörünü ayrı tutun, yedekteki `runtime` klasörünü `~/.config/iterm-pack` konumuna koyun; varsa `dynamic-profile.json` dosyasını `~/Library/Application Support/iTerm2/DynamicProfiles/terminal-pack.json` konumuna geri kopyalayın. Güncelleme shell bloğunu veya varsayılan profil tercihini değiştirmez.

## Kaldırma

Tam gtterm profili dışındaki normal bir terminalde:

```sh
zsh ~/.config/iterm-pack/uninstall.zsh
```

Kaldırıcı dinamik gtterm profillerini, yardımcı komut bloğunu ve çalışma klasörünü kaldırır. Diğer `.zshrc` satırları, ortak Meslo fontları ve Chrome geliştirme verileri korunur. Bu Mac'te önceki varsayılan profil kaydedilmişse ve mevcut varsayılan hâlâ gtterm ise o tercih geri yüklenir. Açık terminaller kapanana kadar yüklenmiş fonksiyonları tutar. Çalışma klasöründeki yerel tercihler silinir; gerekiyorsa önce yedekleyin.


[40 temanın tamamı ve örnekler](themes.md).


## Araçlar ve hazır görünümler

[Araçlar, kısayollar, hazır görünümler ve tek komutla güncelleme](tools.md). Yerel belge için `gtterm docs tools` kullan.


## 3.0 CLI çalışma alanı

[Control+Esc hotkey, canlı paletler, isteğe bağlı efektler ve CLI uyumluluğu](cli.md), [güvenli tekrar kullanılabilir parçalar](snippets.md). Komutlar: `gtterm hotkey`, `gtterm effect`, `gtterm cli`, `gtterm snippet`.


[Yerleşik durum çubuğu, sekme başlıkları, retrowave ve komut paleti](visual.md).


## Mac araçları ve kaynak izleyici

[Mac komut kılavuzu](mac.md): `gtterm monitor`, `gtterm sysinfo`, `gtterm finder`, `gtterm preview`, `gtterm copy-path`, `gtterm copy`, `gtterm disk`, `gtterm awake` ve `gtterm background`.


[Yerleşik yazı efektleri ve retro fontlar](effects.md), arka plan resmi/saydamlık ayarlarından bağımsızdır.
