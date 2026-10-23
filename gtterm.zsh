# Main shell command: proxy changes must affect the caller's environment.
_gt_help() {
  if [[ $GTTERM_LANG == tr ]]; then
    cat <<'TXT'
gtterm — taşınabilir macOS terminal paketi

  gtterm help                         Bu özeti göster
  gtterm status                       Sürüm, dil, tema ve proxy durumu
  gtterm doctor                       Yerel kurulum kontrolü
  gtterm lang [en|tr]                  Dili göster veya kaydet
  gtterm theme [list|name|preview name]              Temayı seç ve kaydet
  gtterm preset [work|focus|presentation]
                                     Hazır görünümü uygula ve kaydet
  gtterm jump [-i|kelimeler]          Dizin geçmişinden klasöre geç
  gtterm tools [status|verify]        Araçları kontrol et
  gtterm background [off|glass|frost|retrowave]  Pencere arka planı
  gtterm effect [list|status|apply|off|retro|fallout|amber|typewriter|neon]
                                     Yerleşik yazı/font/imleç görünümü
  gtterm monitor [tree|basic]        Canlı CPU/RAM ve süreç ekranı
  gtterm sysinfo                     Fastfetch sistem özeti
  gtterm finder [PATH]               Finder’da seçili göster
  gtterm preview FILE                Quick Look ile önizle
  gtterm copy-path [PATH]            Tam yolu panoya kopyala
  COMMAND | gtterm copy              Çıktıyı panoya kopyala
  gtterm disk [PATH]                 Disk alanını göster
  gtterm awake -- COMMAND [ARG…]      Komut çalışırken boşta uyumayı önle
  gtterm hotkey [on|off|status]        Control+Esc üst terminali
  gtterm snippet [list|show|copy|pick] Komut/prompt parçaları
  gtterm cli                         Kurulu AI CLI komutlarını göster
  gtterm menu                        Aranabilir komut paleti
  gtterm statusbar [off|minimal|dashboard]
                                     Yerleşik durum çubuğu
  gtterm tabs [smart|profile]         Sekme başlığı görünümü
  gtterm style [list|name]            Prompt görünümünü seç ve kaydet
  gtterm config [show|set key value|reset]
                                     Ayarlar menüsü veya komutları
  gtterm proxy on [host:port]          Proxy adresini kaydet ve aç
  gtterm proxy off                    Bu oturumun proxy'sini kapat
  gtterm proxy auto [on|off|status]    Otomatik başlangıcı yönet
  gtterm proxy status                 Proxy durumunu göster
  gtterm chrome [alan.adi]             Adı 127.0.0.1'e eşleyen Chrome aç
  gtterm ports [port|java|jboss]       TCP dinleyicilerini göster
  gtterm java [list]                  Çalışan JVM'leri göster
  gtterm docs [guide|commands|themes|tools|cli|snippets|visual|effects|mac|troubleshooting]
                                     Seçili dilde yerel kılavuz
  gtterm reload                       Yardımcı komutları yeniden yükle
  gtterm version                      Sürümü göster

İlk kullanım: gtterm doctor → gtterm docs guide
TXT
  else
    cat <<'TXT'
gtterm — a portable macOS terminal kit

  gtterm help                         Show this overview
  gtterm status                       Version, language, theme and proxy
  gtterm doctor                       Check the local installation
  gtterm lang [en|tr]                  Show or save the language
  gtterm theme [list|name|preview name]              Choose and save a theme
  gtterm preset [work|focus|presentation]
                                     Apply and save a workspace preset
  gtterm jump [-i|words]              Jump to a directory with zoxide
  gtterm tools [status|verify]        Check bundled tools
  gtterm background [off|glass|frost|retrowave]  Window background
  gtterm effect [list|status|apply|off|retro|fallout|amber|typewriter|neon]
                                     Native text/font/cursor treatment
  gtterm monitor [tree|basic]        Live CPU/RAM and process view
  gtterm sysinfo                     Fastfetch system summary
  gtterm finder [PATH]               Reveal a path in Finder
  gtterm preview FILE                Quick Look preview
  gtterm copy-path [PATH]            Copy an absolute path
  COMMAND | gtterm copy              Copy output to the clipboard
  gtterm disk [PATH]                 Show disk space
  gtterm awake -- COMMAND [ARG…]      Prevent idle sleep during a command
  gtterm hotkey [on|off|status]        Control+Esc top terminal
  gtterm snippet [list|show|copy|pick] Command/prompt snippets
  gtterm cli                         Show installed AI CLI commands
  gtterm menu                        Searchable command palette
  gtterm statusbar [off|minimal|dashboard]
                                     Native status bar
  gtterm tabs [smart|profile]         Tab title style
  gtterm style [list|name]            Choose and save a prompt style
  gtterm config [show|set key value|reset]
                                     Settings menu or commands
  gtterm proxy on [host:port]          Save an address and enable proxy
  gtterm proxy off                    Disable proxy in this shell
  gtterm proxy auto [on|off|status]    Manage automatic startup
  gtterm proxy status                 Show proxy status
  gtterm chrome [hostname]             Open Chrome mapping to 127.0.0.1
  gtterm ports [port|java|jboss]       Show TCP listeners
  gtterm java [list]                  Show running JVMs
  gtterm docs [guide|commands|themes|tools|cli|snippets|visual|effects|mac|troubleshooting]
                                     Read the local manual
  gtterm reload                       Reload shell helpers
  gtterm version                      Show the version

Start here: gtterm doctor → gtterm docs guide
TXT
  fi
}

_gt_doctor() {
  _gt_msg doctor_no_network
  local required missing=0
  for required in .zshrc devtools.zsh gtterm.zsh i18n.zsh appearance.zsh colors.zsh themes.zsh settings.zsh tools.zsh snippets.zsh chrome.zsh mac.zsh effects.zsh p10k.zsh VERSION docs/en/guide.md docs/en/commands.md docs/en/troubleshooting.md docs/en/cli.md docs/en/snippets.md docs/tr/guide.md docs/tr/commands.md docs/tr/troubleshooting.md docs/tr/cli.md docs/tr/snippets.md snippets/en/review.txt snippets/tr/review.txt ui/profile-names.txt ui/effect-base.json fonts/VT323-Regular.ttf fonts/VT323-OFL.txt ui/status-minimal.json ui/status-dashboard.json assets/retrowave.png docs/en/visual.md docs/tr/visual.md docs/en/mac.md docs/tr/mac.md docs/en/effects.md docs/tr/effects.md vendor/zsh-autosuggestions/zsh-autosuggestions.zsh vendor/zsh-autocomplete/zsh-autocomplete.plugin.zsh vendor/zasync/zasync vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh vendor/oh-my-zsh/oh-my-zsh.sh vendor/powerlevel10k/powerlevel10k.zsh-theme; do
    if [[ -r "$TERMINAL_PACK_DIR/$required" ]]; then
      printf '[%s] %s\n' "$(_gt_msg doctor_ok)" "$required"
    else
      printf '[%s] %s\n' "$(_gt_msg doctor_missing)" "$required"
      missing=1
    fi
  done
  for required in lsof jps; do
    if (( $+commands[$required] )); then
      printf '[%s] %s\n' "$(_gt_msg doctor_ok)" "$required"
    else
      printf '[%s] %s\n' "$(_gt_msg doctor_optional)" "$required"
    fi
  done
  local full=no
  [[ ${${ZDOTDIR:-$HOME}:A} == ${TERMINAL_PACK_DIR:A} ]] && full=yes
  _gt_msg doctor_shell "$(_gt_msg $full)"
  [[ $full == yes ]] || _gt_msg doctor_profile
  _gt_tools_status || missing=1
  return $missing
}

gtterm() {
  local subcommand=${1:-help}
  (( $# )) && shift
  case $subcommand in
    help|-h|--help) (( $# == 0 )) || { _gt_msg args >&2; return 1; }; _gt_help ;;
    version|--version) (( $# == 0 )) || { _gt_msg args >&2; return 1; }; print -r -- "gtterm $(<"$TERMINAL_PACK_DIR/VERSION")" ;;
    status)
      (( $# == 0 )) || { _gt_msg args >&2; return 1; }
      _gt_msg status_version "$(<"$TERMINAL_PACK_DIR/VERSION")"
      _gt_msg status_lang "$GTTERM_LANG"
      _gt_msg status_theme "${TERMINAL_PACK_THEME:-$(_gt_msg theme_unset)}"
      _gt_msg status_style "$GTTERM_STYLE"
      _gt_msg status_ui "$GTTERM_STATUS_BAR" "$GTTERM_TABS" "$GTTERM_BACKGROUND" "$GTTERM_EFFECT"
      _gt_msg status_home "$TERMINAL_PACK_DIR"
      _gt_proxy_status ;;
    doctor) (( $# == 0 )) || { _gt_msg args >&2; return 1; }; _gt_doctor ;;
    lang)
      (( $# <= 1 )) || { _gt_msg lang_usage >&2; return 1; }
      if (( $# == 0 )); then _gt_msg language "$GTTERM_LANG"; return; fi
      [[ $1 == en || $1 == tr ]] || { _gt_msg lang_usage >&2; return 1; }
      (umask 077; mkdir -p "$TERMINAL_PACK_DIR/state" && print -r -- "$1" > "$TERMINAL_PACK_DIR/state/language") || return
      typeset -g GTTERM_LANG=$1
      _gt_msg lang_set "$GTTERM_LANG" ;;
    theme) (( $# <= 2 )) || { _gt_msg theme_usage >&2; return 1; }; _gt_theme "$@" ;;
    style) _gt_style "$@" ;;
    config) _gt_config "$@" ;;
    menu) (( $# == 0 )) || { _gt_msg args >&2; return 1; }; _gt_menu ;;
    statusbar) _gt_statusbar "$@" ;;
    tabs) _gt_tabs "$@" ;;
    effect) _gt_effect "$@" ;;
    background) _gt_background "$@" ;;
    monitor|sysinfo|finder|preview|copy-path|copy|disk|awake) _gt_mac "$subcommand" "$@" ;;
    hotkey) _gt_hotkey "$@" ;;
    snippet) _gt_snippet "$@" ;;
    cli) (( $# == 0 )) || { _gt_msg args >&2; return 1; }; _gt_cli ;;
    preset) _gt_preset "$@" ;;
    jump) _gt_jump "$@" ;;
    tools)
      (( $# <= 1 )) || { _gt_msg tools_usage >&2; return 1; }
      case ${1:-status} in status) _gt_tools_status ;; verify) _gt_tools_verify "$TERMINAL_PACK_DIR" ;; *) _gt_msg tools_usage >&2; return 1 ;; esac ;;
    proxy)
      local action=${1:-status}
      (( $# )) && shift
      case $action in
        on) _gt_proxy_on "$@" ;;
        off|status)
          (( $# == 0 )) || { _gt_msg args >&2; return 1; }
          if [[ $action == off ]]; then _gt_proxy_off; else _gt_proxy_status; fi ;;
        auto) (( $# <= 1 )) || { _gt_msg auto_usage >&2; return 1; }; _gt_proxy_auto "$@" ;;
        *) _gt_msg proxy_actions >&2; return 1 ;;
      esac ;;
    chrome) _gt_chrome "$@" ;;
    ports) _gt_ports "$@" ;;
    java)
      (( $# <= 1 )) && [[ ${1:-list} == list ]] || { _gt_msg java_usage >&2; return 1; }
      _gt_java ;;
    docs)
      local topic=${1:-guide}
      (( $# <= 1 )) || { _gt_msg docs_usage >&2; return 1; }
      case $topic in guide|commands|themes|tools|cli|snippets|visual|effects|mac|troubleshooting) ;; *) _gt_msg docs_usage >&2; return 1 ;; esac
      local document="$TERMINAL_PACK_DIR/docs/$GTTERM_LANG/$topic.md"
      [[ -r $document ]] || { _gt_msg docs_missing "$document" >&2; return 1; }
      if [[ -t 1 && -t 0 ]]; then /usr/bin/less -R "$document"; else cat "$document"; fi ;;
    reload)
      (( $# == 0 )) || { _gt_msg args >&2; return 1; }
      source "$TERMINAL_PACK_DIR/devtools.zsh" || return
      if (( ${+functions[p10k]} )); then _gt_refresh || return; fi
      _gt_msg loaded ;;
    *) _gt_msg unknown "$subcommand" >&2; return 1 ;;
  esac
}

fpath=("$TERMINAL_PACK_DIR/completions" ${fpath:#$TERMINAL_PACK_DIR/completions})
if (( $+functions[compdef] )); then
  autoload -Uz _gtterm
  compdef _gtterm gtterm
fi
