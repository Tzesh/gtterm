# Sorun giderme

[Kılavuz](guide.md) · [Komutlar](commands.md) · [English](../en/troubleshooting.md)

## `gtterm: command not found`

Terminal kurulumdan önce açılmış veya Zsh dışında bir shell kullanıyor olabilir. Mevcut Zsh oturumunda:

```sh
source ~/.config/iterm-pack/devtools.zsh
gtterm doctor
```

Yeni Zsh oturumları `~/.zshrc` içindeki işaretli bloğu yükler. Bash/Fish desteklenmez. Dosya yoksa tam paketi açıp kurulum kılavuzunu izleyin; yalnızca birkaç shell dosyasını kopyalamayın.

## Terminal eski görünüyor

Eski paket tam görünümü ayrı iTerm profilinde etkinleştiriyordu. gtterm tema komutunu normal Zsh yardımcı komut bloğundan da sunar. Yukarıdaki gibi yükleyip `gtterm theme mocha` çalıştırın.

Tam prompt, font, boşluklar ve tamamlama menüleri için **Profiles → gtterm - Nord** açın. Normal profilin yardımcı komutları, tam ortamı kendiliğinden yüklemez. `gtterm doctor` iki durumu ayırır.

Kurulum artık **gtterm - Nord** profilini varsayılan kaydeder. Sonradan farklı profil seçmek için **Settings → Profiles → seçtiğiniz profil → Other Actions → Set as Default** kullanın. Açık iTerm dışından kaydedilen tercih, uygulama tamamen yeniden başlatılana kadar geçerli olmayabilir. gtterm oturumları sizin adınıza kapatmaz. Açık pencereler mevcut shell'lerini korur.

## Tema yeni pencerede geri dönüyor

`gtterm theme` oturumluk bir işlemdir. Yeni pencere seçilen iTerm profilinin temasıyla başlar. Belirli bir başlangıç teması istiyorsanız ilgili profili varsayılan yapın. macOS açık/koyu görünümü değiştirilmez.

## İkonlar kare veya prompt kaymış

Profil fontunun **MesloLGS NF** olduğunu ve dört font dosyasının kullanıcı Fonts klasöründe bulunduğunu kontrol edin. Font kaydından sonra profili yeniden açın. Özel font, tmux/screen, değiştirilmiş karakter aralıkları veya desteklenmeyen terminal hizalamayı etkileyebilir.

## Proxy açık görünüyor ama bağlantı yok

`gtterm proxy status` ortam ayarlarını gösterir; proxy sunucusunun çalıştığını doğrulamaz. Yerel proxy için `gtterm ports <proxy-portu>` kullanın ve adresi işyeri ayarlarıyla karşılaştırın. gtterm proxy/VPN başlatmaz.

Yerel ve `.local` hedefler bilerek proxy dışındadır. Başka yerde açık uygulamalar yeni terminal ayarını devralmaz. JVM'e özel proxy parametreleri gerektiren Java araçları veya Docker daemon kendi ayarlarını isteyebilir; gtterm bütün uygulamaları yapılandırdığını iddia etmez.

## `gtterm proxy off` sonrası proxy yeniden açılıyor

`gtterm proxy off` yalnızca o oturum içindir. `gtterm proxy auto off`, mevcut oturumda kapatır ve otomatik başlangıcı durdurur. Diğer açık terminaller kendi ortamlarını korur. Başka bir etkin üst süreçten açılan alt süreç onun proxy değişkenlerini devralabilir; gerçekten kullandığınız terminalde durumu kontrol edin.

## `jboss.local` hata sayfası açıyor

Eşleme bir sunucu değildir. `gtterm ports java` ile JBoss'un portunu kontrol edin. `gtterm chrome` HTTP 80'i açar. JBoss 8080'deyse ayrı geliştirme penceresinde `http://jboss.local:8080` yazın. Port-offset varsa gerçek port değişir.

gtterm'in açtığı Chrome geliştirme penceresini kullanın; kural normal Chrome/Safari veya sistem DNS'ini etkilemez. Kurumsal proxy alan adını uzaktan çözüyorsa yerel adres istisnası/politikası gerekebilir. HTTPS için uygun geçerli sertifika gerekir. Güvenlik kontrollerini kapatan bayraklar eklenmez.

## Java süreçleri veya portlar eksik

Yalnızca hesabınızın inceleyebildiği süreçler listelenir. Farklı JAVA_HOME veya JVM ayarları `jps` görünürlüğünü etkileyebilir. `gtterm ports java` süreç adını süzer; standart dışı başlatıcılarda belirli port numarası yararlı olabilir. JBoss filtresi özel portları kaçırabilir veya aynı yaygın portu kullanan başka programları gösterebilir.

Boş liste, sistemde başka kullanıcıların hiç dinleyicisi olmadığını kanıtlamaz. Sudo istenmez.

## `doctor` yalnızca yardımcı komutların yüklü olduğunu söylüyor

Normal Zsh profilinde beklenen durumdur. Yardımcı komutlar kullanılabilir. Tam görünüm/eklentiler için gtterm profili açın. Gerekli paket dosyası eksikliği ayrı bir durumdur; aynı sürümden dosyaları geri getirin veya yükseltme adımlarını izleyin.

## Dil diğer sekmede değişmedi

Dil tercihi bu Mac'te tutulur. `gtterm lang tr` mevcut terminali ve yeni oturumları etkiler. Diğer açık terminalde `gtterm reload` çalıştırın. gtterm mesajları/belgeleri çevrilir; eklenti ve işletim sistemi mesajları İngilizce kalabilir. Komut adları İngilizce kalır.

## Kurulum zaten mevcut uyarısı

Bu koruyucu bir reddetmedir, yarım kalmış bir yükseltme değildir. Kılavuzdaki özel yedek/kaldır/yeniden kur adımlarını izleyin. `local.zsh` ve `state/` gerekiyorsa yedeklemeden kurulum klasörünü silmeyin.

## Ek bilgi

`gtterm status` yol ve sürümü, `gtterm docs commands` desteklenen girdileri ve sınırları gösterir. Sürüm kontrolleri `VERIFICATION.txt` içindedir. Yerel tercihler, kişisel ayarlar ve Chrome verileri özel kalmalı; dağıtılacak ZIP'e girmemelidir.
