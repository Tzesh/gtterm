# Persistent preferences are validated data, never executable shell fragments.
source "${${(%):-%x}:A:h}/effects.zsh" || return
typeset -ga GTTERM_STYLES=(rounded minimal powerline compact ascii)
typeset -ga GTTERM_SETTING_KEYS=(theme style font-size line-spacing icons prompt-spacing suggestions background effect cursor hotkey status-bar tabs)
typeset -gA GTTERM_SETTING_DEFAULTS=(theme nord style rounded font-size 15 line-spacing relaxed icons on prompt-spacing comfortable suggestions on background off effect off cursor beam hotkey on status-bar minimal tabs smart)

_gt_setting_valid() {
  local key=$1 value=$2
  case $key in
    theme) (( ${GTTERM_THEMES[(Ie)$value]} )) ;;
    style) (( ${GTTERM_STYLES[(Ie)$value]} )) ;;
    font-size) [[ $value =~ '^(1[2-9]|2[0-2])$' ]] ;;
    line-spacing) [[ $value == (compact|normal|relaxed) ]] ;;
    background) [[ $value == (off|glass|frost|retrowave) ]] ;;
    effect) (( ${GTTERM_EFFECTS[(Ie)$value]} )) ;;
    status-bar) [[ $value == (off|minimal|dashboard) ]] ;;
    tabs) [[ $value == (smart|profile) ]] ;;
    cursor) [[ $value == (block|beam|underline) ]] ;;
    hotkey|icons|suggestions) [[ $value == (on|off) ]] ;;
    prompt-spacing) [[ $value == (comfortable|compact) ]] ;;
    *) return 1 ;;
  esac
}

_gt_settings_load() {
  local settings_root=${1:-$TERMINAL_PACK_DIR} key value state_key
  typeset -gA GTTERM_SETTINGS
  for key in $GTTERM_SETTING_KEYS; do
    value=$GTTERM_SETTING_DEFAULTS[$key]
    if [[ $key == theme ]] && _gt_setting_valid theme "${TERMINAL_PACK_THEME:-}"; then value=$TERMINAL_PACK_THEME; fi
    state_key=$key
    [[ $key != effect ]] || state_key=visual-effect
    # Previous releases used state/effect for the background. Keep it for rollback.
    if [[ $key == background && ! -r "$settings_root/state/background" && -r "$settings_root/state/effect" ]]; then state_key=effect; fi
    if [[ -r "$settings_root/state/$state_key" ]]; then
      value=$(<"$settings_root/state/$state_key")
      _gt_setting_valid "$key" "$value" || value=$GTTERM_SETTING_DEFAULTS[$key]
    fi
    GTTERM_SETTINGS[$key]=$value
  done
  export TERMINAL_PACK_THEME=$GTTERM_SETTINGS[theme]
  typeset -g GTTERM_STYLE=$GTTERM_SETTINGS[style]
  typeset -g GTTERM_FONT_SIZE=$GTTERM_SETTINGS[font-size]
  typeset -g GTTERM_LINE_SPACING=$GTTERM_SETTINGS[line-spacing]
  typeset -g GTTERM_ICONS=$GTTERM_SETTINGS[icons]
  typeset -g GTTERM_PROMPT_SPACING=$GTTERM_SETTINGS[prompt-spacing]
  typeset -g GTTERM_SUGGESTIONS=$GTTERM_SETTINGS[suggestions]
  typeset -g GTTERM_BACKGROUND=$GTTERM_SETTINGS[background]
  typeset -g GTTERM_EFFECT=$GTTERM_SETTINGS[effect]
  typeset -g GTTERM_CURSOR=$GTTERM_SETTINGS[cursor]
  typeset -g GTTERM_HOTKEY=$GTTERM_SETTINGS[hotkey]
  typeset -g GTTERM_STATUS_BAR=$GTTERM_SETTINGS[status-bar]
  typeset -g GTTERM_TABS=$GTTERM_SETTINGS[tabs]
}

_gt_setting_write() {
  local key=$1 value=$2 temporary state_key=$1
  _gt_setting_valid "$key" "$value" || { _gt_msg config_invalid "$key" "$value" >&2; return 1; }
  [[ $key != effect ]] || state_key=visual-effect
  (
    umask 077
    mkdir -p "$TERMINAL_PACK_DIR/state" || exit 1
    temporary=$(/usr/bin/mktemp "$TERMINAL_PACK_DIR/state/.$state_key.XXXXXX") || exit 1
    if print -r -- "$value" > "$temporary" && mv -f "$temporary" "$TERMINAL_PACK_DIR/state/$state_key"; then
      exit 0
    fi
    rm -f -- "$temporary"
    exit 1
  )
}

# Called on prepared profile files by installation, upgrade and font preferences.
_gt_profile_settings() {
  local file=$1 font_size=${2:-$GTTERM_FONT_SIZE} spacing=${3:-$GTTERM_LINE_SPACING} effect=${4:-$GTTERM_BACKGROUND} cursor=${5:-$GTTERM_CURSOR} hotkey=${6:-$GTTERM_HOTKEY} status_bar=${7:-$GTTERM_STATUS_BAR} tabs=${8:-$GTTERM_TABS} text_effect=${9:-$GTTERM_EFFECT} ratio index opacity radius blur cursor_type layout tab_title status_enabled background previous_effect
  _gt_setting_valid effect "$text_effect" || return 1
  previous_effect=$(/usr/bin/plutil -extract gttermTextEffect raw -o - "$file" 2>/dev/null) || previous_effect=off
  case $spacing in compact) ratio=1.0 ;; normal) ratio=1.15 ;; relaxed) ratio=1.2 ;; *) return 1 ;; esac
  case $effect in off) opacity=0; radius=2; blur=false ;; glass) opacity=0.12; radius=8; blur=true ;; frost) opacity=0.22; radius=14; blur=true ;; retrowave) opacity=0; radius=2; blur=false ;; *) return 1 ;; esac
  case $cursor in block) cursor_type=0 ;; beam) cursor_type=1 ;; underline) cursor_type=2 ;; *) return 1 ;; esac
  case $status_bar in off) status_enabled=false; layout=minimal ;; minimal|dashboard) status_enabled=true; layout=$status_bar ;; *) return 1 ;; esac
  case $tabs in smart) tab_title=6 ;; profile) tab_title=32 ;; *) return 1 ;; esac
  [[ -r "$TERMINAL_PACK_DIR/ui/status-$layout.json" ]] || return 1
  layout=$(<"$TERMINAL_PACK_DIR/ui/status-$layout.json")
  background=
  if [[ $effect == retrowave ]]; then
    [[ -r "$TERMINAL_PACK_DIR/assets/retrowave.png" ]] || return 1
    background="$HOME/.config/iterm-pack/assets/retrowave.png"; fi
  for (( index=0; index <= ${#GTTERM_THEMES}; ++index )); do
    /usr/bin/plutil -replace "Profiles.$index.Normal Font" -string "MesloLGS-NF-Regular $font_size" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Non Ascii Font" -string "MesloLGS-NF-Regular $font_size" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Vertical Spacing" -float "$ratio" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Transparency" -float "$opacity" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Initial Use Transparency" -bool true "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Only The Default BG Color Uses Transparency" -bool true "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Blur" -bool "$blur" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Blur Radius" -float "$radius" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Cursor Type" -integer "$cursor_type" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Show Status Bar" -bool "$status_enabled" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Status Bar Layout" -json "$layout" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Title Components" -integer "$tab_title" "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Use Custom Tab Title" -bool false "$file" || return
    if [[ $effect == retrowave ]]; then
      /usr/bin/plutil -replace "Profiles.$index.Background Image Location" -string "$background" "$file" || return
      /usr/bin/plutil -replace "Profiles.$index.Status Bar Layout.advanced configuration.auto-rainbow style" -integer 3 "$file" || return
    else
      /usr/bin/plutil -replace "Profiles.$index.Background Image Location" -string "" "$file" || return
    fi
    /usr/bin/plutil -replace "Profiles.$index.Background Image Mode" -integer 2 "$file" || return
    /usr/bin/plutil -replace "Profiles.$index.Blend" -float 0.15 "$file" || return
    if [[ $text_effect != off || $previous_effect != off ]]; then
      _gt_effect_profile "$file" "$index" "$text_effect" "$font_size" || return
    fi
  done
  /usr/bin/plutil -replace gttermTextEffect -string "$text_effect" "$file" || return
  /usr/bin/plutil -replace "Profiles.${#GTTERM_THEMES}.Has Hotkey" -bool "$([[ $hotkey == on ]] && print true || print false)" "$file" || return
  /usr/bin/plutil -convert xml1 -o /dev/null "$file" || return
  /usr/bin/plutil -convert json "$file"
}

_gt_update_profiles() {
  local font_size=$1 spacing=$2 effect=${3:-$GTTERM_BACKGROUND} cursor=${4:-$GTTERM_CURSOR} hotkey=${5:-$GTTERM_HOTKEY} status_bar=${6:-$GTTERM_STATUS_BAR} tabs=${7:-$GTTERM_TABS} text_effect=${8:-$GTTERM_EFFECT} temporary dynamic_temporary
  local dynamic="$HOME/Library/Application Support/iTerm2/DynamicProfiles/terminal-pack.json"
  [[ -r "$TERMINAL_PACK_DIR/profile.json" && -d ${dynamic:h} ]] || return 1
  temporary=$(/usr/bin/mktemp "$TERMINAL_PACK_DIR/.profile.XXXXXX") || return
  dynamic_temporary=$(/usr/bin/mktemp "${dynamic:h}/.gtterm-profile.XXXXXX") || { rm -f "$temporary"; return 1; }
  if cp "$TERMINAL_PACK_DIR/profile.json" "$temporary" &&
     _gt_profile_settings "$temporary" "$font_size" "$spacing" "$effect" "$cursor" "$hotkey" "$status_bar" "$tabs" "$text_effect" &&
     cp "$temporary" "$dynamic_temporary" &&
     mv -f "$dynamic_temporary" "$dynamic" &&
     mv -f "$temporary" "$TERMINAL_PACK_DIR/profile.json"; then
    return 0
  fi
  rm -f -- "$temporary" "$dynamic_temporary"
  return 1
}

_gt_suggestions_apply() {
  if [[ ${GTTERM_SUGGESTIONS:-on} == off ]]; then
    typeset -g _ZSH_AUTOSUGGEST_DISABLED=1
  else
    unset _ZSH_AUTOSUGGEST_DISABLED
  fi
}

_gt_refresh() {
  source "$TERMINAL_PACK_DIR/appearance.zsh" || return
  source "$TERMINAL_PACK_DIR/p10k.zsh" || return
  _pack_apply_highlights
  _gt_suggestions_apply
  (( ! ${+functions[p10k]} )) || p10k reload
  _pack_apply_palette
  (( ! ${+functions[_gt_tools_colors]} )) || _gt_tools_colors
}

_gt_config_set() {
  local key=$1 value=$2 active_theme=${TERMINAL_PACK_THEME:-nord}
  _gt_setting_valid "$key" "$value" || { _gt_msg config_invalid "$key" "$value" >&2; return 1; }
  case $key in effect|font-size|line-spacing|cursor) _gt_effect_rebind || true ;; esac
  case $key in
    font-size) _gt_update_profiles "$value" "$GTTERM_LINE_SPACING" || return ;;
    line-spacing) _gt_update_profiles "$GTTERM_FONT_SIZE" "$value" || return ;;
    background) _gt_update_profiles "$GTTERM_FONT_SIZE" "$GTTERM_LINE_SPACING" "$value" || return ;;
    effect) _gt_update_profiles "$GTTERM_FONT_SIZE" "$GTTERM_LINE_SPACING" "$GTTERM_BACKGROUND" "$GTTERM_CURSOR" "$GTTERM_HOTKEY" "$GTTERM_STATUS_BAR" "$GTTERM_TABS" "$value" || return ;;
    cursor) _gt_update_profiles "$GTTERM_FONT_SIZE" "$GTTERM_LINE_SPACING" "$GTTERM_BACKGROUND" "$value" || return ;;
    hotkey) _gt_update_profiles "$GTTERM_FONT_SIZE" "$GTTERM_LINE_SPACING" "$GTTERM_BACKGROUND" "$GTTERM_CURSOR" "$value" || return ;;
    status-bar) _gt_update_profiles "$GTTERM_FONT_SIZE" "$GTTERM_LINE_SPACING" "$GTTERM_BACKGROUND" "$GTTERM_CURSOR" "$GTTERM_HOTKEY" "$value" || return ;;
    tabs) _gt_update_profiles "$GTTERM_FONT_SIZE" "$GTTERM_LINE_SPACING" "$GTTERM_BACKGROUND" "$GTTERM_CURSOR" "$GTTERM_HOTKEY" "$GTTERM_STATUS_BAR" "$value" || return ;;
  esac
  _gt_setting_write "$key" "$value" || return
  _gt_settings_load
  [[ $key == theme ]] || export TERMINAL_PACK_THEME=$active_theme
  _gt_refresh || return
  _gt_msg config_saved "$key" "$value"
  case $key in font-size|line-spacing|background|effect|cursor|hotkey|status-bar|tabs) _gt_msg config_new_tab ;; esac
}

_gt_config_show() {
  local key
  for key in $GTTERM_SETTING_KEYS; do printf '%-18s %s\n' "$key" "$GTTERM_SETTINGS[$key]"; done
  printf '%-18s %s\n' language "$GTTERM_LANG"
}

_gt_config_reset() {
  local key
  _gt_effect_rebind || true
  _gt_update_profiles 15 relaxed off beam on minimal smart off || return
  for key in $GTTERM_SETTING_KEYS; do _gt_setting_write "$key" "$GTTERM_SETTING_DEFAULTS[$key]" || return; done
  _gt_settings_load
  _gt_refresh || return
  _gt_msg config_reset
}

_gt_choose() {
  local -a choices=("$@")
  local -i index=1
  local answer
  for answer in $choices; do printf '%2d  %s\n' "$index" "$answer"; (( ++index )); done
  _gt_msg config_choose
  read -r answer || return 1
  [[ $answer == <-> && ${#answer} -le 2 ]] || return 1
  index=$((10#$answer))
  (( index >= 1 && index <= ${#choices} )) || return 1
  REPLY=$choices[$index]
}

_gt_config_menu() {
  [[ -t 0 && -t 1 ]] || { _gt_msg config_tty >&2; return 1; }
  local choice value REPLY
  while true; do
    _gt_msg config_menu
    read -r choice || return 0
    case $choice in
      0|q|quit) return 0 ;;
      1) _gt_choose $GTTERM_THEMES && _gt_config_set theme "$REPLY" ;;
      2) _gt_choose $GTTERM_STYLES && _gt_config_set style "$REPLY" ;;
      3) _gt_msg config_font; read -r value || return 0; _gt_config_set font-size "$value" ;;
      4) _gt_choose compact normal relaxed && _gt_config_set line-spacing "$REPLY" ;;
      5) _gt_choose on off && _gt_config_set icons "$REPLY" ;;
      6) _gt_choose comfortable compact && _gt_config_set prompt-spacing "$REPLY" ;;
      7) _gt_choose on off && _gt_config_set suggestions "$REPLY" ;;
      8) _gt_choose en tr && gtterm lang "$REPLY" ;;
      9) _gt_config_reset ;;
      e) _gt_choose $GTTERM_EFFECTS && _gt_config_set effect "$REPLY" ;;
      g) _gt_choose off glass frost retrowave && _gt_config_set background "$REPLY" ;;
      c) _gt_choose block beam underline && _gt_config_set cursor "$REPLY" ;;
      b) _gt_choose off minimal dashboard && _gt_config_set status-bar "$REPLY" ;;
      t) _gt_choose smart profile && _gt_config_set tabs "$REPLY" ;;
      h) _gt_choose on off && _gt_config_set hotkey "$REPLY" ;;
      p) _gt_choose work focus presentation && _gt_preset "$REPLY" ;;
      s) _gt_config_show ;;
      *) _gt_msg args >&2 ;;
    esac
  done
}

_gt_config() {
  local action=${1:-menu}
  (( $# )) && shift
  case $action in
    menu|show|reset)
      (( $# == 0 )) || { _gt_msg config_usage >&2; return 1; }
      case $action in menu) _gt_config_menu ;; show) _gt_config_show ;; reset) _gt_config_reset ;; esac ;;
    set) (( $# == 2 )) || { _gt_msg config_usage >&2; return 1; }; _gt_config_set "$1" "$2" ;;
    *) _gt_msg config_usage >&2; return 1 ;;
  esac
}

_gt_style() {
  (( $# <= 1 )) || { _gt_msg style_usage >&2; return 1; }
  if [[ ${1:-list} == list ]]; then print -rl -- $GTTERM_STYLES; return 0; fi
  _gt_config_set style "$1"
}

_gt_settings_load
_gt_suggestions_apply


# Presets save existing preferences; theme, language and proxy are deliberately outside this group.
_gt_preset() {
  (( $# <= 1 )) || { _gt_msg preset_usage >&2; return 1; }
  local name=${1:-list} active_theme=$TERMINAL_PACK_THEME
  local -a keys=(style font-size line-spacing icons prompt-spacing suggestions) values
  local -i index
  case $name in
    list) _gt_msg preset_list; return 0 ;;
    work) values=(rounded 15 relaxed on comfortable on) ;;
    focus) values=(minimal 14 compact off compact on) ;;
    presentation) values=(minimal 20 relaxed off comfortable off) ;;
    *) _gt_msg preset_usage >&2; return 1 ;;
  esac
  _gt_effect_rebind || true
  _gt_update_profiles "$values[2]" "$values[3]" || return
  for (( index=1; index <= ${#keys}; ++index )); do
    _gt_setting_write "$keys[$index]" "$values[$index]" || return
  done
  _gt_settings_load
  export TERMINAL_PACK_THEME=$active_theme
  _gt_refresh || return
  _gt_msg preset_saved "$name"
  _gt_msg config_new_tab
}

_gt_background() {
  (( $# <= 1 )) || { _gt_msg background_usage >&2; return 1; }
  if [[ ${1:-list} == list ]]; then print -rl -- off glass frost retrowave; return 0; fi
  _gt_config_set background "$1"
}

_gt_effect() {
  (( $# <= 1 )) || { _gt_msg effect_usage >&2; return 1; }
  case ${1:-list} in
    list) print -rl -- $GTTERM_EFFECTS; return 0 ;;
    status) print -r -- "$GTTERM_EFFECT"; return 0 ;;
    apply)
      if _gt_effect_rebind; then return 0
      else
        local result=$?
        (( result == 2 )) || _gt_msg effect_rebind_local >&2
        return 1
      fi ;;
    crt|3d|bloom|scanlines) _gt_msg effect_native_only >&2; return 1 ;;
  esac
  _gt_config_set effect "$1"
}

_gt_hotkey() {
  (( $# <= 1 )) || { _gt_msg hotkey_usage >&2; return 1; }
  if [[ ${1:-status} == status ]]; then _gt_msg hotkey_status "$GTTERM_HOTKEY"; return 0; fi
  [[ $1 == (on|off) ]] || { _gt_msg hotkey_usage >&2; return 1; }
  _gt_config_set hotkey "$1"
}

_gt_statusbar() {
  (( $# <= 1 )) || { _gt_msg statusbar_usage >&2; return 1; }
  if [[ ${1:-status} == status ]]; then print -r -- "$GTTERM_STATUS_BAR"; return 0; fi
  _gt_config_set status-bar "$1"
}

_gt_tabs() {
  (( $# <= 1 )) || { _gt_msg tabs_usage >&2; return 1; }
  if [[ ${1:-status} == status ]]; then print -r -- "$GTTERM_TABS"; return 0; fi
  _gt_config_set tabs "$1"
}
