# Mac araçları

[Komutlar](commands.md) · [Araçlar ve güncelleme](tools.md) · [English](../en/mac.md)

Bu işlemler yalnızca çağrıldığında çalışır. Terminal açılışına sistem afişi, süreç izleme, pano okuma veya uyku engelleme servisi eklenmez. AI CLI mevcut girdiyi kullanıyorsa başka sekmede çalıştırın.

## Kaynak izleyici

```sh
gtterm monitor
gtterm monitor tree
gtterm monitor basic
```

Bottom 0.14.9; CPU, bellek, disk, ağ ve süreçleri gösterir. `tree`, agent ve alt süreçlerini ağaçta izlemeyi; `basic`, küçük pencerede sade görünümü sağlar. Üçü de paket yapılandırması, iki saniyelik yenileme ve süreç sonlandırma/sinyal göndermeyi kapatan `--read_only` ile açılır. Çıkış `q`, süreç arama `/` tuşudur. Tam süreç argümanları varsayılan olarak açılmaz. Etkileşimli terminal gerekir; yönlendirilmiş çıktıda başlatılmaz.

macOS bazı süreç ayrıntılarını yetki nedeniyle kısıtlar. GPU/sıcaklık ve diğer kullanıcıların tüm süreç bilgileri garanti edilmez; yükseltilmiş yetki istenmez. Çalışırken küçük yerleşik CPU/RAM grafikleri için mevcut `gtterm statusbar dashboard` kullanılabilir.

## Sistem özeti

```sh
gtterm sysinfo
```

Fastfetch 2.70.0; küçük Apple logosu, sistem, çekirdek, açık kalma süresi, işlemci, bellek, pil ve terminal bilgilerini gösterir. Universal dosyası **macOS 26+** gerektirir; macOS 27 dahildir. Eski sistemde açıklayıcı gereksinim mesajı verilir, diğer gtterm özellikleri kullanılabilir. Bottom için paket tabanı macOS 11+ korunur.

`gtterm sysinfo`, açıkça `tools/fastfetch.jsonc` dosyasını kullanır. Kullanıcı/makine adı, başlık, seri numarası, ağ/IP, ortam değişkeni ve komut modülleri eklenmez. Doğrudan `fastfetch` komutu kendi yapılandırmasını kullanabilir; çıktısı farklı olabilir. Özet otomatik kopyalanmaz veya gönderilmez.

## Finder, önizleme ve pano

```sh
gtterm finder                      # Geçerli klasörü göster
gtterm finder './rapor.pdf'        # Dosyayı Finder’da göster
gtterm preview './rapor.pdf'       # Desteklenen biçimi Quick Look ile aç
gtterm copy-path                   # Klasörün tam yolunu kopyala
gtterm copy-path './rapor.pdf'     # Dosyanın tam yolunu kopyala
printf '%s' 'kopyalanacak metin' | gtterm copy
gtterm copy < './notlar.txt'
```

Yolun var olması gerekir. Boşluk, Unicode ve baştaki tire dosya yolu olarak korunur. Sembolik bağlantı gerçek hedefe çözülür. Yol kopyasına satır sonu eklenmez. `copy`, yalnızca verdiğiniz standart girdiyi okur ve etkileşimli girişi reddeder. Pano okunmaz, kopyalanan içerik çalıştırılmaz. Finder tüm yolları `open -R` ile seçili gösterir; uygulama/paket klasörlerini çalıştırmaz. Finder ve Quick Look yerleşik arayüzlerini açabilir.

## Disk alanı ve komut süresince uyanık kalma

```sh
gtterm disk
gtterm disk '/Volumes/Work'
gtterm awake -- codex
gtterm awake -- /bin/zsh './uzun-is.zsh'
```

`disk`, seçilen yolu içeren dosya sistemini macOS `df -h` ile gösterir; dosyaları tek tek taramaz. `awake`, komut bitene kadar `caffeinate -i` kullanır ve komutun çıkış durumunu döndürür. Argümanlar aynen aktarılır, shell ifadesi değerlendirilmez; shell operatörleri için açıkça bir betik çalıştırın. Boşta sistem uykusunu engeller; kapak kapatma veya kurum politikaları altında çalışmanın süreceğini garanti etmez.

## Arka plan adlandırması

```sh
gtterm background list
gtterm background glass
gtterm background retrowave
gtterm background off
```

`background`, resim/saydamlık/bulanıklığı yönetir. `gtterm effect` ise bağımsız olarak yazı/font/imleç görünümünü değiştirir. Güncelleme eski arka plan seçimini korur. [Yazı efektleri](effects.md) ve [görsel ayarlar](visual.md).

## Kaynaklar ve kurulum

İki işlemci mimarisi, upstream sağlama değerleri, sabitlenmiş lisanslar ve minimum sistem sürümleri `TOOLS-SOURCES.json` içinde kayıtlıdır. Yeni paketi ayrı klasöre açıp aynı çevrimdışı `zsh install.zsh --trust-tools` komutuyla kurun veya güncelleyin; sudo, Homebrew ve yönetici parolası kullanılmaz. [Bütünlük ve karantina işlemleri](tools.md).

[Bottom](https://github.com/ClementTsang/bottom/releases/tag/0.14.9) · [Bottom seçenekleri](https://bottom.pages.dev/stable/configuration/command-line-options/) · [Fastfetch](https://github.com/fastfetch-cli/fastfetch/releases/tag/2.70.0). Yerleşik yardımcılar macOS `open`, `qlmanage`, `pbcopy`, `df`, `caffeinate` araçlarını kullanır; platform davranışı kurulu man sayfalarında açıklanır.


[Yerleşik yazı efektleri ve retro fontlar](effects.md), arka plan resmi/saydamlık ayarlarından bağımsızdır.
