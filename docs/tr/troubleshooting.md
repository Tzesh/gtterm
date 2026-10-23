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

`gtterm theme <ad>` artık seçimi kaydeder; `gtterm theme preview <ad>` geçicidir. `gtterm config show` ile kaydı kontrol edip yeni tam gtterm profili açın. Kayıtlı tema varsa profilin başlangıç paletinin önüne geçer; yoksa açılan profilin rengi kullanılır. Diğer açık terminaller yeniden yüklenene kadar kendi görünümünü korur. macOS görünümü değiştirilmez.

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

Eski kurucular mevcut kurulumu reddeder. Yeni paketi ayrı klasöre açıp onun `zsh install.zsh` komutunu çalıştırın; artık özel yedek alarak yerinde günceller. Mevcut çalışma klasörünü silmeyin. [Güncelleme kılavuzuna](guide.md) bakın.

## Ek bilgi

`gtterm status` yol ve sürümü, `gtterm docs commands` desteklenen girdileri ve sınırları gösterir. Sürüm kontrolleri `VERIFICATION.txt` içindedir. Yerel tercihler, kişisel ayarlar ve Chrome verileri özel kalmalı; dağıtılacak ZIP'e girmemelidir.

## Apple `gitstatusd-darwin-arm64` dosyasını doğrulayamıyor

macOS, tarayıcıdan indirilmiş arşivdeki noter onayı olmayan gitstatusd programını engelleyebilir. gtterm 2.1.1 itibarıyla Powerlevel10k’ın Zsh `vcs_info` altyapısını kullanır; gitstatusd başlatılmaz. Git dalı/durum bilgisi korunur; büyük depolarda güncellenmesi biraz daha yavaş olabilir. Yönetici yetkisi veya Gatekeeper değişikliği gerekmez.

Mevcut 2.1.0 kurulumunda `~/.config/iterm-pack/p10k.zsh` dosyasına `typeset -g POWERLEVEL9K_DISABLE_GITSTATUS=true` ekleyip yeni bir gtterm oturumu açın. `gtterm reload` yalnızca yardımcı komutları yükler; bu prompt değişikliği için yeni oturum gerekir.


## Araçlar ve hazır görünümler

[Araçlar, kısayollar, hazır görünümler ve tek komutla güncelleme](tools.md). Yerel belge için `gtterm docs tools` kullan.


## 3.0 CLI çalışma alanı

[Control+Esc hotkey, canlı paletler, isteğe bağlı efektler ve CLI uyumluluğu](cli.md), [güvenli tekrar kullanılabilir parçalar](snippets.md). Komutlar: `gtterm hotkey`, `gtterm effect`, `gtterm cli`, `gtterm snippet`.


[Yerleşik yazı efektleri ve retro fontlar](effects.md), arka plan resmi/saydamlık ayarlarından bağımsızdır.

## Efekt sonrası yazı pürüzlü kalıyor

[Normal yazı görünümüne dönüş ve sekme kontrolü](effects.md#normal-yazı-görünümüne-dönüş) bölümüne bakın. 3.0.0 kurucusu yazı yumuşatma ve imleç ayarlarını açıkça geri yükler.
