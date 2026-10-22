# Komut başvurusu

[Kılavuz](guide.md) · [Sorun giderme](troubleshooting.md) · [English](../en/commands.md)

Komutlar shell fonksiyonudur; proxy değişiklikleri mevcut terminali etkiler. Komut adları, alt komutlar, `on/off/status` ve dil kodları iki dilde de İngilizce kalır. Tek genel giriş noktası `gtterm` komutudur; eski kısa komutlar 2.1.0 sürümünde kaldırıldı.

## Yardım ve durum

| Komut | İşlev |
|---|---|
| `gtterm`, `gtterm help`, `gtterm --help` | Komut özeti |
| `gtterm version`, `gtterm --version` | Paket sürümü |
| `gtterm status` | Sürüm, dil, seçili tema, çalışma yolu, HTTP/HTTPS ve auto proxy durumu |
| `gtterm doctor` | Gerekli dosyalar, isteğe bağlı araçlar ve tam profil/yalnızca yardımcı komut ayrımı |
| `gtterm reload` | Yardımcı komutları ve kayıtlı dili yükle; proxy auto açıksa yeniden uygula |
| `gtterm docs` | Seçili dilde kılavuz |
| `gtterm docs commands` | Bu komut başvurusu |
| `gtterm docs troubleshooting` | Sorun giderme |

`doctor` yerel ve salt okunurdur; ağ isteği, sunucu başlatma, süreç durdurma veya otomatik onarım yapmaz. Gerekli paket dosyası eksikse sıfırdan farklı durum koduyla döner. İsteğe bağlı araçların eksikliği veya normal profil kullanımı tek başına hata değildir. Proxy/JBoss bağlantısının çalıştığını kanıtlamaz.

## Dil

```sh
gtterm lang
gtterm lang en
gtterm lang tr
```

Parametresiz kullanım geçerli dili gösterir. `en`/`tr` seçimi `state/language` dosyasına kaydedilir ve mevcut terminale uygulanır. Diğer açık terminaller `gtterm reload` kullanabilir. Geçersiz seçim kayıtlı tercihi değiştirmez; bozuk kayıtlı tercih İngilizceye döner.

## Tema

```sh
gtterm theme mocha
gtterm theme nord
gtterm theme latte
```

Tek bir tema adı gerekir. gtterm prompt renklerini, mevcut vurgu/öneri renklerini ve iTerm paletini bu oturum için değiştirir. Tema komutu normal oturuma eksik eklentileri kurmaz, varsayılan profili/macOS temasını değiştirmez ve sonraki pencerelere tema kaydetmez. Kurucu ise ayrıca Nord profilini varsayılan kaydeder. Palet kontrolü iTerm gerektirir; bu sürüm tmux/screen üzerinden iletmez.


## Proxy

| Komut | Etki |
|---|---|
| `gtterm proxy` | `gtterm proxy status` ile aynı |
| `gtterm proxy on host:port` | Adresi doğrula/kaydet, mevcut terminalde HTTP/HTTPS değişkenlerini ayarla |
| `gtterm proxy on` | Kayıtlı adresi kullan; yoksa hata ver |
| `gtterm proxy off` | HTTP/HTTPS ve ALL_PROXY değişkenlerini bu oturumda temizle; auto tercihini koru |
| `gtterm proxy auto on` | Şimdi aç ve otomatik başlangıcı kaydet; kayıtlı adres gerekir |
| `gtterm proxy auto off` | Şimdi kapat ve otomatik başlangıcı kapalı kaydet |
| `gtterm proxy auto`, `gtterm proxy auto status` | Otomatik başlangıç tercihini göster |
| `gtterm proxy status` | HTTP, HTTPS ve otomatik başlangıcı göster |

Örnek geçerli adresler: `127.0.0.1:8080`, `proxy.example.test:3128`, `http://proxy.example.test:3128`, `https://proxy.example.test:443`. Şema yoksa `http://` eklenir. Port 1–65535 olmalıdır. Kullanıcı/parola, yol, SOCKS ve IPv6 proxy sunucusu kabul edilmez.

`http_proxy`, `https_proxy`, `HTTP_PROXY` ve `HTTPS_PROXY` aynı adresi alır. Yerel istisnalar mevcut `no_proxy`/`NO_PROXY` listelerine eklenir. Temiz kurulumda adres veya otomatik başlangıç ayarlanmış değildir.


## Yerel Chrome eşlemesi

```sh
gtterm chrome                  # jboss.local → 127.0.0.1
gtterm chrome app.local        # app.local → 127.0.0.1
```

En fazla bir yalın alan adı alınır; URL, yol veya port eklemeyin. Chrome host-resolver kurallarıyla bu ad için ayrı geliştirme profilinde `http://<alan.adi>` açılır. Chrome `/Applications` veya `~/Applications` içinde aranır. Alan adı nokta içermeli ve geçerli karakterlerden oluşmalıdır. Joker eşleme yoktur.

Portsuz HTTP 80'i kullanır; gerekiyorsa tarayıcıda `http://jboss.local:8080` yazın. Normal Chrome geçmişi/çerezleri, sistem hosts/DNS ayarları ve çalışan JBoss sunucusu değişmez. Sertifika doğrulaması açık kalır. Sistem/tarayıcı proxy politikaları adın yerelde çözülmesini etkileyebilir; terminal proxy değişkenleri ayrı bir özelliktir.


## Java ve portlar

| Komut | Çıktı |
|---|---|
| `gtterm ports` | Görülebilen TCP dinleyicileri; PID, süreç, adres ve port ipucu |
| `gtterm ports 8080` | Yalnızca bu port |
| `gtterm ports java` | Süreç adı `java` olan dinleyiciler; özel portlar dahil |
| `gtterm ports jboss` | Aday portlar: 8080, 8443, 9990, 9993, 8009, 8787 |
| `gtterm java`, `gtterm java list` | `jps -l` listesi; JDK aracı yoksa Java süreç adları |

JBoss filtresi port filtresidir; kesin sunucu tanımlaması yapmaz. Özel portlar ve offset kullanılabilir. Standart bağlamalar [WildFly yönetim kılavuzunda](https://docs.wildfly.org/26/Admin_Guide.html) açıklanır. 8787 yaygın bir Java debug adayıdır; debug'ın açık olduğu iddia edilmez.

Önce `$JAVA_HOME/bin/jps`, sonra PATH üzerindeki `jps` kullanılır. Listeleme aracının kendisi hariç tutulur. Görünürlük macOS/JVM izinlerine bağlıdır. JVM parametreleri, thread/heap dump, deployment, yeniden başlatma ve süreç sonlandırma bu komutların kapsamına girmez.


## Çıkış durumu ve tercihler

Başarılı işlemler genellikle 0 döner. Geçersiz parametre/adres/alan adı, gerekli dosya/veri eksikliği veya başlatıcı hatası sıfırdan farklı döner. Boş süreç/port listesi normal sonuçtur.

Tercihler `~/.config/iterm-pack/state` altında düz veri olarak tutulur; shell kodu olarak değerlendirilmez. Diğer Mac'leri etkilemez. Kurulu klasörü ZIP'lemek yerine temiz dağıtım ZIP'ini paylaşın.
