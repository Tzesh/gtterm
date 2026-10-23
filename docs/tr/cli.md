# AI CLI çalışma alanı

[Rehber](guide.md) · [Komut parçaları](snippets.md) · [English](../en/cli.md)

## Üstten açılan hotkey terminal

iTerm2 açıkken **Control+Esc**, `gtterm - Hotkey` penceresini açıp gizler. Pencere üstten kayar; ekran genişliğinin %100, yüksekliğinin %55'ini kullanır. Odağı başka uygulamaya verince açık kalır; gizlemek için aynı kısayola bas. Gizlemek içerideki CLI işlemini durdurmaz. Tam ekran uygulamaların üzerinde görünebilir ve Spaces alanlarına katılır. Normal etkileşimli gtterm Zsh oturumu açılır; hiçbir agent otomatik başlatılmaz.

```sh
gtterm hotkey status
gtterm hotkey off
gtterm hotkey on
```

Kısayol yalnızca hotkey profiline atanır. Diğer gtterm pencerelerinin düzeni ve güncellemede mevcut iTerm varsayılanı korunur. Hotkey varsa kayıtlı temayı, yoksa Nord'u kullanır. iTerm2'nin yerleşik animasyonu kullanılır; ek servis veya genel klavye izleyicisi kurulmaz. Güncellemede Dynamic Profiles'ın yenilenmesini bekle veya güvenli olduğunda iTerm'i yeniden aç. Önemli işi çalışan terminali ayar yenilemek için kapatma.

Kısayol çalışmazsa **Settings → Profiles → gtterm - Hotkey → Keys → Configure Hotkey Window** içinde Control+Esc atamasını ve macOS/diğer uygulama çakışmalarını kontrol et. iTerm2 açık olmalı. Kurumun klavye politikaları etkileyebilir. Yapılandırma iTerm2 kaynak kodundaki anahtarlarla doğrulandı; fiziksel tuş ve ekran animasyonu otomatik testle kanıtlanamaz. [iTerm2 hotkey belgesi](https://iterm2.com/documentation-hotkey.html).

## Canlı paletler ve isteğe bağlı efektler

```sh
gtterm theme synthwave
gtterm theme cyberpunk
gtterm theme aurora
gtterm theme laserwave
gtterm background glass
gtterm background frost
gtterm background off
gtterm config set cursor block
```

40 palet, beş prompt ve Work/Focus/Presentation hazır görünümleri bulunur. Dört yeni palet gtterm için özgün tasarımlardır; benzer isimli başka temaların kopyası değildir. Başlangıç varsayılanı Nord, beam imleç ve kapalı efektlerdir. Palet ve pencere efektleri birbirinden bağımsız kaydedilir. Kaydetmeden tema denemek için `gtterm theme preview AD` kullan.

| Efekt | Saydamlık | Yerleşik bulanıklık yarıçapı |
|---|---|---|
| off | %0 | kapalı |
| glass | %12 | 8 |
| frost | %22 | 14 |

Saydamlık yalnızca varsayılan arka plana uygulanır; TUI içindeki renkli paneller opak kalır. Yerleşik iTerm arka plan çizimi kullanılır; metnin üstünde periyodik kabuk çizimi, özel shader veya animasyon çalışmaz. Etki, pencerenin arkasında ne olduğuna bağlıdır. Font, imleç ve efektleri en güvenilir şekilde yeni gtterm penceresinde görürsün; mevcut oturuma özel ayarlar öncelikli olabilir. Bulanıklık GPU kullanımını artırabilir; en yüksek kontrast/performans için `off` kullan. [iTerm2 pencere ayarları](https://iterm2.com/documentation-preferences-profiles-window.html).

## CLI uyumluluğu

```sh
gtterm cli
gtterm snippet copy review
```

`gtterm cli` yalnızca PATH içinde `agent`, `cursor-agent`, `codex`, `copilot` ve `claude` komutlarını arar. Hiçbirini açmaz; hesap, ağ veya prompt sorgusu yapmaz. AI CLI uygulamaları ayrıdır; kurulumları, hesap bağlantıları, abonelikleri ve kurum politikaları gtterm tarafından değiştirilmez. Komutun bulunması hesabın veya kurulumun çalıştığı anlamına gelmez.

Enter, Esc, Shift+Enter, fare, bracketed paste ve alternatif ekran davranışları değiştirilmez. Zsh fzf kısayolları kabuk prompt'unda çalışır; ön plandaki CLI kendi tuşlarını yönetir. İstediğin genel Control+Esc ataması agent çalışırken de pencereyi açıp gizler. Kişisel varsayılan iTerm profilinden miras gelen tuş ayarları ayrıca etkili olabilir.

Paket lazygit uygulaması ve yerel tam ekran terminal test aracı kontrol edilir. Hesap bağlantılı Cursor/Codex/Copilot/Claude oturumları açılmaz ve uçtan uca uyumluluk sertifikası verilmez. Bir agent'ın çalıştırdığı kabuk çıktısı karmaşıksa `gtterm style minimal` veya `gtterm style ascii` ve `gtterm background off` seçeneklerini deneyebilirsin; alt kabuklar kendi ortamını kullanabilir.

## CLI kullanımında faydalı seçenekler

- Review, plan, debug, explain, verify veya handoff parçasını kopyalayıp agent girişine yapıştır; göndermeden önce incele. Komut parçaları da yalnızca metin olarak kopyalanır.
- Proje kurallarını projenin kendi dosyalarında tut. gtterm `AGENTS.md`, `CLAUDE.md` veya `.cursor/rules` dosyalarını oluşturmaz/değiştirmez.
- Ayrı bir gtterm konuşma veritabanı yerine CLI'ın kendi devam/geçmiş özelliğini kullan. Codex için `codex resume`, [resmî OpenAI belgesinde](https://developers.openai.com/codex/cli/features) açıklanır.
- Genel tuş ataması yapmadan önce çok satırlı girişi CLI içinde kontrol et. Güncel Claude Code belgesinde Ctrl+J genel yeni satır seçeneği, iTerm2 için Shift+Enter desteği belirtilir. Copilot gerektiğinde `/terminal-setup` sunar. Davranış kurulu sürüme bağlıdır: [Claude terminal ayarları](https://code.claude.com/docs/en/terminal-config), [Copilot komutları](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-command-reference).
- Cursor CLI proje kuralları ve planlama sunar: [Cursor CLI](https://cursor.com/docs/cli/using). Sağlayıcıya özel ayarları kendi uygulamasında tut.

İleride eklenebilecekler: önizleme/boyut sınırı olan seçili dosya bağlam paketleri, kişisel proje yer imleri ve komut paleti. Bunlar 3.0'a kurulmuş özellikler değildir. Otomatik konuşma dışa aktarma, pano geçmişi toplama, bildirim, ortam etiketi, hazır bölme düzeni veya yeni Java/JBoss özellikleri eklenmez.


[Yerleşik durum çubuğu, sekme başlıkları, retrowave ve komut paleti](visual.md).


[Yerleşik yazı efektleri ve retro fontlar](effects.md), arka plan resmi/saydamlık ayarlarından bağımsızdır.
