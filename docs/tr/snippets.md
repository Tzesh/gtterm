# Komut ve prompt parçaları

[CLI çalışma alanı](cli.md) · [English](../en/snippets.md)

`gtterm snippet list` isimleri listeler. `show AD` içeriği gösterir; `copy AD` düz metni aynen yerel macOS panosuna kopyalar; `pick` fzf ile seçip kopyalar. İçerik değerlendirilmez veya çalıştırılmaz. Copy/pick mevcut pano içeriğinin yerine geçer. Hedef agent/editöre yapıştırıp incele; komut parçasını kabuğa yapıştırıp Enter'a basmak komutu çalıştırabilir.

Hazır isimler: `review`, `plan`, `debug`, `explain`, `verify`, `handoff`, `git-status`, `git-diff`. Prompt metni `gtterm lang en|tr` seçimini izler; komut isimleri İngilizce kalır. Bunlar sağlayıcı slash komutu değil, düz prompt metnidir.

Kişisel parça için `~/.config/iterm-pack/state/snippets/AD.txt` konumuna normal UTF-8 dosya kaydet. Dizini özel izinle oluştur (`mkdir -m 700 -p ~/.config/iterm-pack/state/snippets`). İsimler 1–48 küçük harf/rakam/alt çizgi/tire olabilir; ilk karakter harf veya rakam olmalıdır. Boyut sınırı 32 KiB'dır. Sembolik bağlar reddedilir. Aynı isimli kişisel dosya iki dilde de paket parçasının önüne geçer. Kişisel parçalar güncellemede korunur, temiz ZIP'e girmez. Paylaşılan parçalara parola/token koyma.

```sh
gtterm snippet show review
gtterm snippet copy handoff
gtterm snippet pick
```


[Yerleşik yazı efektleri ve retro fontlar](effects.md), arka plan resmi/saydamlık ayarlarından bağımsızdır.
