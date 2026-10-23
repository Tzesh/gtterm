# Sekmeler, yerleşik durum çubuğu ve retrowave

[CLI rehberi](cli.md) · [English](../en/visual.md)

## Neler açık geliyor?

İlk 3.0 paketinde tema rengine göre sekme rengi vardı; durum çubuğu yoktu. Güncellenen, henüz yayımlanmamış 3.0'da sade yerleşik durum çubuğu ve kullanışlı sekme başlıkları varsayılan olarak açık. Kayıtlı ayarların, teman, hotkey ve iTerm varsayılanın korunur.

```sh
gtterm statusbar minimal
gtterm statusbar dashboard
gtterm statusbar off
gtterm tabs smart
gtterm tabs profile
gtterm menu
```

`minimal`: çalışma dizini, ön plandaki uygulama ve saat. `dashboard`: bunlara iTerm'in yerleşik CPU/RAM grafikleri eklenir. `off`: çubuğu gizler. Dar bölmelerde iTerm düşük öncelikli parçaları sıkıştırabilir veya gizleyebilir. Bunlar yerel Mac'in kaynak değerleridir; SSH sunucusunun metriği, agent'ın düşünme durumu veya hesap kullanım limiti değildir. Kabukta periyodik sorgulama servisi eklenmez.

`smart` yerleşik dizin + çalışan uygulama başlıklarını; `profile` profil adını kullanır. Tam komut argümanları eklenmez; uzun prompt'lar bilerek başlığa taşınmaz. Sekme rengi temayı izlemeye devam eder. Tam gtterm kabuğu açılışta/dizin değişince yüzde kodlamalı yerel dizin bilgisi gönderir; çalışan CLI'ın üstüne yeniden çizim yapmaz ve uzak SSH dizinlerini takip etmez. Yalnızca yardımcı komutların yüklendiği normal kabukta bu kanca kurulmaz.

Mevcut oturuma özel ayarlar profilin önüne geçebilir; güncellemeden sonra yeni gtterm penceresi aç. Sekme şekli/konumu/görünürlüğü uygulama genelindedir: tek sekmeyi göremiyorsan **Settings → Appearance → Tabs → Show tab bar even when there is only one tab** seçeneğini kontrol et (etiket sürüme göre değişebilir). Kurucu tek sekmeli çubuğu görünür yapmak için iTerm'in genel `HideTab` tercihini bir kez false yapar. Önceki değeri özel olarak yedekler; sonradan değiştirmediysen kaldırmada geri yükler. Görünürlük diğer iTerm profillerine de uygulanır; diğer genel görünüm ayarları değişmez. Sonraki elle görünürlük seçimin güncellemelerde korunur.

Resmî kaynaklar: [Status Bar](https://iterm2.com/documentation-status-bar.html), [Appearance](https://iterm2.com/documentation-preferences-appearance.html), [Profil başlıkları](https://iterm2.com/documentation-preferences-profiles-general.html).

## İsteğe bağlı retrowave sahnesi

```sh
gtterm theme synthwave
gtterm background retrowave
gtterm statusbar dashboard
```

Özgün ve statik çizim: çizgili gün batımı diski, koyu ufuk ve perspektif neon ızgara. iTerm'in arka plan görseli ve ölçülü karıştırma ayarı kullanılır; shader, ek çizim süreci veya yanıp sönen metin yoktur. Bu modda durum çubuğunun yerleşik otomatik renkleri açılır. Arka plan paletten bağımsızdır; Synthwave önerilen eşleşmedir, tema zorla değiştirilmez. CPU/RAM grafikleri gerçek etkinliği gösterir; duvar kâğıdı animasyonlu değildir.

`gtterm background off` görseli temizleyip opak terminale döner. `glass` ve `frost` da görseli temizler ve kendi efektlerini uygular. Varsayılan Nord ve kapalı efektlerdir. Ayarlar güncellemede korunur; `gtterm config reset` sade durum çubuğu ve smart başlıkları da geri getirir. Yerleşik çizim ve karıştırma sürüme göre değişebilir; tarayıcı galerisi yaklaşık önizlemedir. PNG ve düzenlenebilir SVG kaynağı MIT lisansıyla `assets/` içindedir. İş Mac'inde grafik çalışma zamanı, sudo, brew veya indirme gerekmez. [iTerm arka plan görselleri](https://iterm2.com/documentation-preferences-profiles-window.html).

## Aranabilir komut paleti

`gtterm menu`, mevcut fzf ile tema, efekt, durum çubuğu, sekme başlığı, parça, CLI kontrolü veya araç durumunu seçtirir. Menü açıklamaları İngilizce/Türkçe seçimini izler; komut isimleri İngilizce kalır. Esc açık seçiciyi iptal eder. Yalnızca belirli, doğrulanan işlemler çağrılır; metin kod olarak değerlendirilmez, AI sağlayıcısı açılmaz.

## CLI için gözden geçirilen diğer fikirler

Sonraki en faydalı eklemeler: önizlemeli dosya/arama sonucu bağlam seçimi, özel proje yer imleri ve sağlayıcının kendi oturum devam özelliği. Bunlar burada kurulmadı. Bugün `rg`/`fd` ile dosyayı daralt, `bat` ile incele, `jq` ile JSON süz, lazygit ile diff gör; prompt parçalarıyla inceleme/plan/devir isteklerini tekrar kullan. Mevcut sistemin üstüne ikinci geçmiş/tamamlama sistemi bindirmemek iyi olur. Sağlayıcıya özel çok satırlı giriş için genel tuş ataması yerine CLI'ın belgelenmiş ayarını kullan.

Shell Integration komut işaretleri/son çıktıyı kopyalama ayrı değerlendirilebilir; bu sürüm yalnızca dizin bilgisi gönderir, tam shell integration sunduğunu iddia etmez. Ortam etiketi, bildirim, hazır bölme düzeni veya yeni Java/JBoss özellikleri açılmaz.

Araştırılan ek seçenekler (kurulmadı): [Cmd-click ile dosya/editör geçişi](https://iterm2.com/documentation-preferences-profiles-advanced.html), [imgcat ile terminal içinde görsel önizleme](https://iterm2.com/documentation-utilities.html), [tam Shell Integration ile komut çıktısı seçme/kopyalama](https://iterm2.com/documentation-command-selection.html).

gtterm komutlarını AI sohbet girişinde değil Zsh kabuğunda çalıştır. Agent açıkken menü/parça kopyalama için başka bir terminal sekmesini kullanıp metni agent girişine yapıştırabilirsin. Sağlayıcıya özel kabuğa kaçış kısayolu varsayılmaz.


## Mac araçları ve kaynak izleyici

[Mac komut kılavuzu](mac.md): `gtterm monitor`, `gtterm sysinfo`, `gtterm finder`, `gtterm preview`, `gtterm copy-path`, `gtterm copy`, `gtterm disk`, `gtterm awake` ve `gtterm background`.


[Yerleşik yazı efektleri ve retro fontlar](effects.md), arka plan resmi/saydamlık ayarlarından bağımsızdır.
