# Only en/tr preferences are accepted; state is plain data, never sourced.
typeset -g GTTERM_LANG=${GTTERM_LANG:-en}
if [[ -r "$TERMINAL_PACK_DIR/state/language" ]]; then
  GTTERM_LANG=$(<"$TERMINAL_PACK_DIR/state/language")
fi
[[ $GTTERM_LANG == en || $GTTERM_LANG == tr ]] || GTTERM_LANG=en
typeset -gA _GT_EN=(
  status_ui 'Status bar: %s | Tabs: %s | Background: %s | Effect: %s'
  tabs_visibility_failed 'Tab visibility could not be saved. Enable the single-tab bar in iTerm Appearance settings.'
  statusbar_usage 'Usage: gtterm statusbar [status|off|minimal|dashboard]'
  tabs_usage 'Usage: gtterm tabs [status|smart|profile]'
  menu_actions 'theme	Theme
background	Window background
effect	Text effects and retro fonts
statusbar	Status bar
tabs	Tab titles
snippet	Copy a snippet
cli	AI CLI commands
tools	Bundled tools
monitor	Resource monitor
sysinfo	System summary
finder	Reveal current folder in Finder
disk	Disk space'

  mac_usage 'Usage: gtterm %s'
  mac_path 'Path does not exist: %s'
  mac_tty 'Open the resource monitor in an interactive terminal tab.'
  mac_copy_pipe 'Pipe output into gtterm copy or redirect a file into it.'
  background_usage 'Usage: gtterm background [list|off|glass|frost|retrowave]'
  effect_usage 'Usage: gtterm effect [list|status|apply|off|retro|fallout|amber|typewriter|neon]'
  effect_rebind_permission 'iTerm profile refresh requested. If iTerm asks, allow profile changes, then run gtterm effect apply. No administrator access is needed.'
  effect_rebind_denied 'iTerm blocks profile-switch control sequences. Reselect the gtterm profile from iTerm’s Profiles menu; gtterm has not changed this security preference.'
  effect_rebind_local 'Run gtterm effect apply in a local interactive gtterm iTerm profile, outside SSH/tmux/screen.'
  effect_native_only 'iTerm2 does not offer CRT bloom, scanline shaders or 3D screen curvature. Choose retro, fallout, amber, typewriter or neon for native text treatments.'
  hotkey_usage 'Usage: gtterm hotkey [on|off|status]'
  hotkey_status 'Control+Esc top hotkey: %s (iTerm2 must be running).'
  snippet_usage 'Usage: gtterm snippet [list|show NAME|copy NAME|pick]'
  snippet_missing 'Invalid, missing or unsafe snippet: %s'
  snippet_large 'Snippets must be at most 32 KiB.'
  snippet_copied 'Copied snippet: %s. Paste it into your CLI/editor; nothing was executed.'
  cli_local 'Local PATH checks only; no CLI was started, installed or authenticated.'
  tools_os 'Tool %s requires macOS %s or newer. Other gtterm features remain available.'

  tools_arch 'Bundled tools require Apple Silicon or Intel macOS.'
  tools_corrupt 'Tool integrity check failed. Extract a complete, trusted gtterm package again; no downloaded commands were run.'
  tools_blocked 'Tool %s is unavailable or quarantined. From the extracted gtterm package, run: zsh install.zsh --trust-tools'
  tools_activation 'Downloaded tools need explicit activation. Verify the package source, then run: zsh install.zsh --trust-tools. Only verified bundled tool executables are activated.'
  tools_usage 'Usage: gtterm tools [status|verify]'
  preset_usage 'Usage: gtterm preset [list|work|focus|presentation]'
  preset_list 'work          Rounded, 15-point text, relaxed spacing, icons and suggestions
focus         Minimal, 14-point text, compact spacing, no icons
presentation  Minimal, 20-point text, relaxed spacing, no icons or suggestions'
  preset_saved 'Workspace preset saved: %s. Theme, language and proxy were preserved.'

  status_style 'Prompt style: %s'
  style_usage 'Usage: gtterm style [list|rounded|minimal|powerline|compact|ascii]'
  config_invalid 'Invalid setting: %s = %s. Use gtterm config show or gtterm docs themes.'
  config_saved 'Saved %s: %s'
  config_new_tab 'Profile settings apply to new gtterm windows. Hotkey: Control+Esc; iTerm2 must be running.'
  config_reset 'Appearance reset to Nord/rounded. Language and proxy settings were preserved.'
  config_usage 'Usage: gtterm config [show|set key value|reset]'
  config_tty 'The settings menu needs an interactive terminal. Use gtterm config show or gtterm config set key value.'
  config_choose 'Enter a number (invalid input cancels):'
  config_font 'Font size (12–22):'
  config_menu '
  gtterm · Settings
  1 Theme      2 Prompt style    3 Font size
  4 Line spacing    5 Icons     6 Prompt spacing
  7 Suggestions     8 Language  9 Reset appearance
  p Workspace presets   e Text effects   g Background   c Cursor   h Hotkey
  b Status bar   t Tab titles
  s Show settings   0 Exit
Choose:'

  upgrade_invalid 'Cannot upgrade: expected a normal gtterm installation and a separate extracted package.'
  upgrade_locked 'Another upgrade is running. If it was interrupted, verify no upgrade is active before removing ~/.config/.gtterm-upgrade.lock.'
  upgrade_rolled_back 'Upgrade failed. The previous installation was restored.'
  upgrade_restore 'Automatic restore failed. Your previous installation is saved at: %s'
  upgraded 'gtterm updated to %s.'
  upgrade_backup 'Private backup (contains personal settings): %s'
  upgrade_reopen 'Open a new gtterm profile and run gtterm doctor. Existing sessions were not restarted.'

  theme_unset 'not selected in this shell'
  theme_usage 'Usage: gtterm theme [list|name|preview name] — gtterm theme list'
  proxy_format 'Proxy format: host:port or http://host:port (no username/password).'
  port_range 'Port must be between 1 and 65535.'
  proxy_usage 'Usage: gtterm proxy on [host:port]'
  proxy_first 'Set an address first: gtterm proxy on 127.0.0.1:8080'
  proxy_on 'HTTP and HTTPS proxy enabled: %s'
  proxy_off 'Proxy disabled in this shell.'
  auto_on 'Proxy will be enabled in new shell sessions.'
  auto_off 'Automatic proxy startup disabled.'
  auto_status 'Automatic startup: %s'
  auto_usage 'Usage: gtterm proxy auto on | off | status'
  off 'off'
  chrome_usage 'Usage: gtterm chrome [hostname]'
  chrome_domain 'Enter a valid hostname, for example: jboss.local'
  chrome_missing 'Google Chrome was not found.'
  ports_usage 'Usage: gtterm ports [port | java | jboss]'
  jboss_hint 'Common JBoss ports; check the process name to identify the application.'
  listeners_none 'No visible TCP listeners.'
  jps_missing 'JDK jps is unavailable; showing Java process names only.'
  java_none 'No visible Java processes.'
  jvm_none 'No visible JVMs.'
  ports_none 'No matching TCP listeners.'
  port_http 'Possible HTTP / proxy'
  port_https 'Possible HTTPS'
  port_management_http 'Possible JBoss management HTTP'
  port_management_https 'Possible JBoss management HTTPS'
  port_ajp 'Possible AJP'
  port_debug 'Possible Java debug'
  process 'PROCESS'
  address 'ADDRESS'
  note 'NOTE'
  lang_usage 'Usage: gtterm lang [en | tr]'
  lang_set 'Language: %s. New sessions will use this preference.'
  unknown 'Unknown command: %s. Run gtterm help.'
  args 'Unexpected arguments. Run gtterm help.'
  docs_usage 'Usage: gtterm docs [guide | commands | themes | tools | cli | snippets | visual | effects | mac | troubleshooting]'
  docs_missing 'Documentation file is missing: %s'
  loaded 'gtterm reloaded.'
  status_version 'Version: %s'
  status_lang 'Language: %s'
  status_theme 'Theme: %s'
  status_home 'Installation: %s'
  proxy_actions 'Usage: gtterm proxy on [address] | off | status | auto [on | off | status]'
  java_usage 'Usage: gtterm java [list]'
  doctor_ok 'OK'
  doctor_missing 'MISSING'
  doctor_optional 'OPTIONAL'
  doctor_shell 'Full gtterm shell: %s'
  yes 'yes'
  no 'no (helpers are still available)'
  doctor_profile 'For the full appearance, open the gtterm - Nord iTerm profile.'
  doctor_no_network 'Local checks only; no network requests or system changes.'
  install_macos 'gtterm requires macOS.'
  install_zsh 'gtterm requires Zsh 5.8 or newer.'
  install_exists 'Existing profile without a normal installation. See docs/en/troubleshooting.md.'
  install_incomplete 'The package is incomplete.'
  installed 'gtterm installed. Nord is now the saved default iTerm profile. Reopen iTerm when safe, or open Profiles > gtterm - Nord now.'
  install_preserved 'Existing .zshrc lines were preserved. The previous default profile was saved for uninstall.'
  install_remove 'Remove with: zsh ~/.config/iterm-pack/uninstall.zsh'
  uninstall_location 'Run the uninstaller from the installed directory.'
  uninstalled 'gtterm removed. Existing shell settings were preserved.'
  uninstall_chrome 'Chrome development data was kept in Library/Application Support/Terminal Pack.'
  uninstall_fonts 'Shared Meslo fonts were kept in your user Fonts directory.'
  language 'Language: %s'
)
typeset -gA _GT_TR=(
  status_ui 'Durum çubuğu: %s | Sekmeler: %s | Arka plan: %s | Efekt: %s'
  tabs_visibility_failed 'Sekme görünürlüğü kaydedilemedi. iTerm Appearance ayarından tek sekmeli çubuğu açabilirsin.'
  statusbar_usage 'Kullanım: gtterm statusbar [status|off|minimal|dashboard]'
  tabs_usage 'Kullanım: gtterm tabs [status|smart|profile]'
  menu_actions 'theme	Tema
background	Pencere arka planı
effect	Yazı efektleri ve retro fontlar
statusbar	Durum çubuğu
tabs	Sekme başlıkları
snippet	Parça kopyala
cli	AI CLI komutları
tools	Paket araçları
monitor	Kaynak izleyici
sysinfo	Sistem özeti
finder	Klasörü Finder’da göster
disk	Disk alanı'

  mac_usage 'Kullanım: gtterm %s'
  mac_path 'Yol bulunamadı: %s'
  mac_tty 'Kaynak izleyiciyi etkileşimli bir terminal sekmesinde açın.'
  mac_copy_pipe 'Çıktıyı veya dosyayı gtterm copy komutuna yönlendirin.'
  background_usage 'Kullanım: gtterm background [list|off|glass|frost|retrowave]'
  effect_usage 'Kullanım: gtterm effect [list|status|apply|off|retro|fallout|amber|typewriter|neon]'
  effect_rebind_permission 'iTerm profili yenileme isteği gönderildi. iTerm sorarsa profil değişimine izin verip gtterm effect apply çalıştır. Yönetici yetkisi gerekmez.'
  effect_rebind_denied 'iTerm profil değiştirme kontrol dizilerini engelliyor. Profiles menüsünden gtterm profilini yeniden seç; gtterm bu güvenlik tercihini değiştirmedi.'
  effect_rebind_local 'gtterm effect apply komutunu yerel, etkileşimli bir gtterm iTerm profilinde; SSH/tmux/screen dışında çalıştır.'
  effect_native_only 'iTerm2; CRT parlaması, tarama shader’ı veya 3D ekran eğriliği sunmuyor. Yerleşik yazı görünümleri: retro, fallout, amber, typewriter, neon.'
  hotkey_usage 'Kullanım: gtterm hotkey [on|off|status]'
  hotkey_status 'Control+Esc üst hotkey: %s (iTerm2 açık olmalı).'
  snippet_usage 'Kullanım: gtterm snippet [list|show AD|copy AD|pick]'
  snippet_missing 'Geçersiz, eksik veya güvenli olmayan parça: %s'
  snippet_large 'Parçalar en fazla 32 KiB olabilir.'
  snippet_copied 'Parça kopyalandı: %s. CLI/editöre yapıştır; hiçbir şey çalıştırılmadı.'
  cli_local 'Yalnızca yerel PATH kontrolü; CLI açılmaz, kurulmaz veya hesap bağlantısı yapılmaz.'
  tools_os '%s aracı macOS %s veya yenisini gerektirir. Diğer gtterm özellikleri kullanılabilir.'

  tools_arch 'Paket araçları Apple Silicon veya Intel macOS gerektirir.'
  tools_corrupt 'Araç bütünlük kontrolü başarısız. Güvendiğiniz tam gtterm paketini yeniden açın; indirilen komutlar çalıştırılmadı.'
  tools_blocked '%s aracı eksik veya karantinada. Açtığınız gtterm paketinde çalıştırın: zsh install.zsh --trust-tools'
  tools_activation 'İndirilen araçlar açık etkinleştirme gerektiriyor. Paket kaynağını doğrulayıp çalıştırın: zsh install.zsh --trust-tools. Yalnızca doğrulanan paket araçları etkinleştirilir.'
  tools_usage 'Kullanım: gtterm tools [status|verify]'
  preset_usage 'Kullanım: gtterm preset [list|work|focus|presentation]'
  preset_list 'work          Yuvarlak, 15 punto, rahat aralık, ikon ve öneriler açık
focus         Minimal, 14 punto, sıkı aralık, ikonlar kapalı
presentation  Minimal, 20 punto, rahat aralık, ikon ve öneriler kapalı'
  preset_saved 'Hazır görünüm kaydedildi: %s. Tema, dil ve proxy korundu.'

  status_style 'Prompt görünümü: %s'
  style_usage 'Kullanım: gtterm style [list|rounded|minimal|powerline|compact|ascii]'
  config_invalid 'Geçersiz ayar: %s = %s. gtterm config show veya gtterm docs themes kullanın.'
  config_saved 'Kaydedildi %s: %s'
  config_new_tab 'Profil ayarları yeni gtterm pencerelerinde uygulanır. Hotkey: Control+Esc; iTerm2 açık olmalı.'
  config_reset 'Görünüm Nord/rounded olarak sıfırlandı. Dil ve proxy ayarları korundu.'
  config_usage 'Kullanım: gtterm config [show|set anahtar değer|reset]'
  config_tty 'Ayar menüsü etkileşimli terminal gerektirir. gtterm config show veya gtterm config set anahtar değer kullanın.'
  config_choose 'Bir sayı girin (geçersiz giriş iptal eder):'
  config_font 'Font boyutu (12–22):'
  config_menu '
  gtterm · Ayarlar
  1 Tema       2 Prompt görünümü  3 Font boyutu
  4 Satır aralığı    5 İkonlar   6 Prompt boşluğu
  7 Öneriler        8 Dil       9 Görünümü sıfırla
  p Hazır görünümler   e Yazı efektleri   g Arka plan   c İmleç   h Hotkey
  b Durum çubuğu   t Sekme başlıkları
  s Ayarları göster 0 Çıkış
Seçim:'

  upgrade_invalid 'Güncelleme yapılamıyor: normal bir gtterm kurulumu ve ayrı açılmış yeni paket gerekiyor.'
  upgrade_locked 'Başka bir güncelleme çalışıyor. Yarım kaldıysa ~/.config/.gtterm-upgrade.lock klasörünü kaldırmadan önce etkin güncelleme olmadığını kontrol edin.'
  upgrade_rolled_back 'Güncelleme başarısız oldu. Önceki kurulum geri yüklendi.'
  upgrade_restore 'Otomatik geri yükleme başarısız. Önceki kurulumunuz burada saklanıyor: %s'
  upgraded 'gtterm %s sürümüne güncellendi.'
  upgrade_backup 'Özel yedek (kişisel ayarlar içerir): %s'
  upgrade_reopen 'Yeni bir gtterm profili açıp gtterm doctor çalıştırın. Açık oturumlar yeniden başlatılmadı.'

  theme_unset 'bu oturumda seçilmedi'
  theme_usage 'Kullanım: gtterm theme [list|name|preview name] — gtterm theme list'
  proxy_format 'Proxy biçimi: host:port veya http://host:port (kullanıcı/parola eklemeyin).'
  port_range 'Port 1–65535 arasında olmalı.'
  proxy_usage 'Kullanım: gtterm proxy on [host:port]'
  proxy_first 'Önce adresi belirtin: gtterm proxy on 127.0.0.1:8080'
  proxy_on 'HTTP ve HTTPS proxy açık: %s'
  proxy_off 'Proxy bu terminal oturumunda kapalı.'
  auto_on 'Proxy yeni terminal oturumlarında otomatik açılacak.'
  auto_off 'Otomatik proxy başlangıcı kapalı.'
  auto_status 'Otomatik başlangıç: %s'
  auto_usage 'Kullanım: gtterm proxy auto on | off | status'
  off 'kapalı'
  chrome_usage 'Kullanım: gtterm chrome [alan.adi]'
  chrome_domain 'Geçerli bir alan adı belirtin; örnek: jboss.local'
  chrome_missing 'Google Chrome bulunamadı.'
  ports_usage 'Kullanım: gtterm ports [port | java | jboss]'
  jboss_hint 'Sık kullanılan JBoss portları; uygulamayı süreç adından doğrulayın.'
  listeners_none 'Görülebilen TCP dinleyicisi yok.'
  jps_missing 'JDK jps bulunamadı; yalnızca Java süreç adları gösteriliyor.'
  java_none 'Görülebilen Java süreci yok.'
  jvm_none 'Görülebilen JVM yok.'
  ports_none 'Eşleşen TCP dinleyicisi yok.'
  port_http 'HTTP / proxy olabilir'
  port_https 'HTTPS olabilir'
  port_management_http 'JBoss yönetim HTTP olabilir'
  port_management_https 'JBoss yönetim HTTPS olabilir'
  port_ajp 'AJP olabilir'
  port_debug 'Java debug olabilir'
  process 'SÜREÇ'
  address 'ADRES'
  note 'NOT'
  lang_usage 'Kullanım: gtterm lang [en | tr]'
  lang_set 'Dil: %s. Yeni oturumlar bu tercihi kullanacak.'
  unknown 'Bilinmeyen komut: %s. gtterm help komutunu çalıştırın.'
  args 'Beklenmeyen parametreler. gtterm help komutunu çalıştırın.'
  docs_usage 'Kullanım: gtterm docs [guide | commands | themes | tools | cli | snippets | visual | effects | mac | troubleshooting]'
  docs_missing 'Dokümantasyon dosyası bulunamadı: %s'
  loaded 'gtterm yeniden yüklendi.'
  status_version 'Sürüm: %s'
  status_lang 'Dil: %s'
  status_theme 'Tema: %s'
  status_home 'Kurulum: %s'
  proxy_actions 'Kullanım: gtterm proxy on [adres] | off | status | auto [on | off | status]'
  java_usage 'Kullanım: gtterm java [list]'
  doctor_ok 'TAMAM'
  doctor_missing 'EKSİK'
  doctor_optional 'İSTEĞE BAĞLI'
  doctor_shell 'Tam gtterm terminali: %s'
  yes 'evet'
  no 'hayır (yardımcı komutlar kullanılabilir)'
  doctor_profile 'Tam görünüm için iTerm içinden gtterm - Nord profilini açın.'
  doctor_no_network 'Yalnızca yerel kontrol; ağ isteği veya sistem değişikliği yapılmaz.'
  install_macos 'gtterm macOS gerektirir.'
  install_zsh 'gtterm Zsh 5.8 veya daha yeni sürüm gerektirir.'
  install_exists 'Normal bir kuruluma ait olmayan profil var. docs/tr/troubleshooting.md dosyasını inceleyin.'
  install_incomplete 'Paket eksik.'
  installed 'gtterm kuruldu. Nord varsayılan iTerm profili olarak kaydedildi. Uygun olduğunda iTerm’i yeniden açın veya Profiles > gtterm - Nord ile devam edin.'
  install_preserved 'Mevcut .zshrc satırları korundu. Önceki varsayılan profil kaldırmada geri yüklenmek üzere kaydedildi.'
  install_remove 'Kaldırmak için: zsh ~/.config/iterm-pack/uninstall.zsh'
  uninstall_location 'Kaldırıcıyı kurulu klasörden çalıştırın.'
  uninstalled 'gtterm kaldırıldı. Mevcut terminal ayarları korundu.'
  uninstall_chrome 'Chrome geliştirme verileri Library/Application Support/Terminal Pack içinde korundu.'
  uninstall_fonts 'Paylaşılan Meslo fontları kullanıcı Fonts klasöründe korundu.'
  language 'Dil: %s'
)

_gt_msg() {
  local key=$1 template
  shift
  if [[ ${GTTERM_LANG:-en} == tr ]]; then
    template=${_GT_TR[$key]:-${_GT_EN[$key]:-$key}}
  else
    template=${_GT_EN[$key]:-$key}
  fi
  printf -- "$template\n" "$@"
}
