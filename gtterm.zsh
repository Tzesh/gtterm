# Main shell command: proxy changes must affect the caller's environment.
_gt_help() {
  if [[ $GTTERM_LANG == tr ]]; then
    cat <<'TXT'
gtterm — taşınabilir macOS terminal paketi

  gtterm help                         Bu özeti göster
  gtterm status                       Sürüm, dil, tema ve proxy durumu
  gtterm doctor                       Yerel kurulum kontrolü
  gtterm lang [en|tr]                  Dili göster veya kaydet
  gtterm theme mocha|nord|latte         Bu oturumun temasını değiştir
  gtterm proxy on [host:port]          Proxy adresini kaydet ve aç
  gtterm proxy off                    Bu oturumun proxy'sini kapat
  gtterm proxy auto [on|off|status]    Otomatik başlangıcı yönet
  gtterm proxy status                 Proxy durumunu göster
  gtterm chrome [alan.adi]             Adı 127.0.0.1'e eşleyen Chrome aç
  gtterm ports [port|java|jboss]       TCP dinleyicilerini göster
  gtterm java [list]                  Çalışan JVM'leri göster
  gtterm docs [guide|commands|troubleshooting]
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
  gtterm theme mocha|nord|latte         Change this session's theme
  gtterm proxy on [host:port]          Save an address and enable proxy
  gtterm proxy off                    Disable proxy in this shell
  gtterm proxy auto [on|off|status]    Manage automatic startup
  gtterm proxy status                 Show proxy status
  gtterm chrome [hostname]             Open Chrome mapping to 127.0.0.1
  gtterm ports [port|java|jboss]       Show TCP listeners
  gtterm java [list]                  Show running JVMs
  gtterm docs [guide|commands|troubleshooting]
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
  for required in .zshrc devtools.zsh gtterm.zsh i18n.zsh appearance.zsh colors.zsh p10k.zsh VERSION docs/en/guide.md docs/en/commands.md docs/en/troubleshooting.md docs/tr/guide.md docs/tr/commands.md docs/tr/troubleshooting.md vendor/zsh-autosuggestions/zsh-autosuggestions.zsh vendor/zsh-autocomplete/zsh-autocomplete.plugin.zsh vendor/zasync/zasync vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh vendor/oh-my-zsh/oh-my-zsh.sh vendor/powerlevel10k/powerlevel10k.zsh-theme; do
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
    theme) (( $# == 1 )) || { _gt_msg theme_usage >&2; return 1; }; _gt_theme "$@" ;;
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
      case $topic in guide|commands|troubleshooting) ;; *) _gt_msg docs_usage >&2; return 1 ;; esac
      local document="$TERMINAL_PACK_DIR/docs/$GTTERM_LANG/$topic.md"
      [[ -r $document ]] || { _gt_msg docs_missing "$document" >&2; return 1; }
      if [[ -t 1 && -t 0 ]]; then /usr/bin/less -R "$document"; else cat "$document"; fi ;;
    reload)
      (( $# == 0 )) || { _gt_msg args >&2; return 1; }
      source "$TERMINAL_PACK_DIR/devtools.zsh" || return
      _gt_msg loaded ;;
    *) _gt_msg unknown "$subcommand" >&2; return 1 ;;
  esac
}

fpath=("$TERMINAL_PACK_DIR/completions" ${fpath:#$TERMINAL_PACK_DIR/completions})
if (( $+functions[compdef] )); then
  autoload -Uz _gtterm
  compdef _gtterm gtterm
fi
