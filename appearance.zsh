# Shared colors keep the prompt, suggestions and highlighting in sync.
source "$TERMINAL_PACK_DIR/themes.zsh"
export TERMINAL_PACK_THEME=${TERMINAL_PACK_THEME:-nord}
(( ${GTTERM_THEMES[(Ie)$TERMINAL_PACK_THEME]} )) || TERMINAL_PACK_THEME=nord
typeset -gA PACK_COLORS
case $TERMINAL_PACK_THEME in
  nord)
    PACK_COLORS=(base '#2e3440' surface '#3b4252' text '#d8dee9' blue '#88c0d0' green '#a3be8c' yellow '#ebcb8b' red '#bf616a' muted '#7b88a1' accent '#b48ead') ;;
  latte)
    PACK_COLORS=(base '#eff1f5' surface '#dce0e8' text '#4c4f69' blue '#1e66f5' green '#40a02b' yellow '#df8e1d' red '#d20f39' muted '#7c7f93' accent '#8839ef') ;;
  frappe)
    PACK_COLORS=(base '#303446' surface '#3e4256' text '#c6d0f5' blue '#8caaee' green '#a6d189' yellow '#e5c890' red '#e78284' muted '#878eac' accent '#f4b8e4') ;;
  macchiato)
    PACK_COLORS=(base '#24273a' surface '#33364b' text '#cad3f5' blue '#8aadf4' green '#a6da95' yellow '#eed49f' red '#ed8796' muted '#848ba6' accent '#f5bde6') ;;
  dracula)
    PACK_COLORS=(base '#282a36' surface '#3b3d47' text '#f8f8f2' blue '#bd93f9' green '#50fa7b' yellow '#f1fa8c' red '#ff5555' muted '#a1a1a3' accent '#ff79c6') ;;
  tokyo-night)
    PACK_COLORS=(base '#1a1b26' surface '#292b39' text '#c0caf5' blue '#7aa2f7' green '#9ece6a' yellow '#e0af68' red '#f7768e' muted '#7a809e' accent '#bb9af7') ;;
  tokyo-storm)
    PACK_COLORS=(base '#24283b' surface '#32374c' text '#c0caf5' blue '#7aa2f7' green '#9ece6a' yellow '#e0af68' red '#f7768e' muted '#7e86a7' accent '#bb9af7') ;;
  gruvbox-dark)
    PACK_COLORS=(base '#282828' surface '#3a3834' text '#ebdbb2' blue '#458588' green '#98971a' yellow '#d79921' red '#cc241d' muted '#999078' accent '#b16286') ;;
  gruvbox-light)
    PACK_COLORS=(base '#fbf1c7' surface '#eae0ba' text '#3c3836' blue '#458588' green '#98971a' yellow '#d79921' red '#cc241d' muted '#8c8673' accent '#b16286') ;;
  rose-pine)
    PACK_COLORS=(base '#191724' surface '#2b2937' text '#e0def4' blue '#9ccfd8' green '#31748f' yellow '#f6c177' red '#eb6f92' muted '#8c8a9d' accent '#c4a7e7') ;;
  rose-pine-moon)
    PACK_COLORS=(base '#232136' surface '#343247' text '#e0def4' blue '#9ccfd8' green '#3e8fb0' yellow '#f6c177' red '#eb6f92' muted '#918fa4' accent '#c4a7e7') ;;
  rose-pine-dawn)
    PACK_COLORS=(base '#faf4ed' surface '#ebe5e3' text '#575279' blue '#56949f' green '#286983' yellow '#ea9d34' red '#b4637a' muted '#9b96aa' accent '#907aa9') ;;
  solarized-dark)
    PACK_COLORS=(base '#002b36' surface '#0c343f' text '#839496' blue '#268bd2' green '#859900' yellow '#b58900' red '#dc322f' muted '#4c686e' accent '#d33682') ;;
  solarized-light)
    PACK_COLORS=(base '#fdf6e3' surface '#efebda' text '#657b83' blue '#268bd2' green '#859900' yellow '#b58900' red '#dc322f' muted '#a5afab' accent '#d33682') ;;
  one-dark)
    PACK_COLORS=(base '#21252b' surface '#2d3238' text '#abb2bf' blue '#61afef' green '#98c379' yellow '#e5c07b' red '#e06c75' muted '#717781' accent '#c678dd') ;;
  github-dark)
    PACK_COLORS=(base '#101216' surface '#1b1e22' text '#8b949e' blue '#6ca4f8' green '#56d364' yellow '#e3b341' red '#f78166' muted '#575d65' accent '#db61a2') ;;
  monokai)
    PACK_COLORS=(base '#272822' surface '#3a3b35' text '#fdfff1' blue '#fd971f' green '#a6e22e' yellow '#e6db74' red '#f92672' muted '#a3a59a' accent '#ae81ff') ;;
  kanagawa-wave)
    PACK_COLORS=(base '#1f1f28' surface '#303035' text '#dcd7ba' blue '#7e9cd8' green '#76946a' yellow '#c0a36e' red '#c34043' muted '#8d8a7d' accent '#957fb8') ;;
  kanagawa-dragon)
    PACK_COLORS=(base '#181616' surface '#282626' text '#c5c9c5' blue '#8ba4b0' green '#8a9a7b' yellow '#c4b28a' red '#c4746e' muted '#7c7e7b' accent '#a292a3') ;;
  kanagawa-lotus)
    PACK_COLORS=(base '#f2ecbc' surface '#e4deb4' text '#545464' blue '#4d699b' green '#6f894e' yellow '#77713f' red '#c84053' muted '#969489' accent '#b35b79') ;;
  everforest-dark)
    PACK_COLORS=(base '#293136' surface '#383e40' text '#d3c6aa' blue '#7fbbb3' green '#a7c080' yellow '#dbbc7f' red '#e67e80' muted '#8c8779' accent '#d699b6') ;;
  everforest-light)
    PACK_COLORS=(base '#e5dfc5' surface '#d9d4be' text '#5c6a72' blue '#7fbbb3' green '#a7c080' yellow '#dbbc7f' red '#e67e80' muted '#969b95' accent '#d699b6') ;;
  nightfox)
    PACK_COLORS=(base '#192330' surface '#29323e' text '#cdcecf' blue '#719cd6' green '#81b29a' yellow '#dbc074' red '#c94f6d' muted '#81868c' accent '#9d79d6') ;;
  carbonfox)
    PACK_COLORS=(base '#161616' surface '#2a2a2a' text '#f2f4f8' blue '#78a9ff' green '#25be6a' yellow '#08bdba' red '#ee5396' muted '#969799' accent '#be95ff') ;;
  dawnfox)
    PACK_COLORS=(base '#faf4ed' surface '#ebe5e3' text '#575279' blue '#286983' green '#618774' yellow '#ea9d34' red '#b4637a' muted '#9b96aa' accent '#907aa9') ;;
  ayu-mirage)
    PACK_COLORS=(base '#1f2430' surface '#2f333d' text '#cccac2' blue '#6dcbfa' green '#87d96c' yellow '#facc6e' red '#ed8274' muted '#838485' accent '#dabafa') ;;
  ayu-light)
    PACK_COLORS=(base '#f8f9fa' surface '#eaebed' text '#5c6166' blue '#3199e1' green '#6cbf43' yellow '#eca944' red '#ea6c6d' muted '#9ea1a4' accent '#9e75c7') ;;
  iceberg-dark)
    PACK_COLORS=(base '#161821' surface '#262831' text '#c6c8d1' blue '#84a0c6' green '#b4be82' yellow '#e2a478' red '#e27878' muted '#7c7e87' accent '#a093c7') ;;
  iceberg-light)
    PACK_COLORS=(base '#e8e9ec' surface '#d8d9de' text '#33374c' blue '#2d539e' green '#668e3d' yellow '#c57339' red '#cc517a' muted '#7f828f' accent '#7759b4') ;;
  tokyo-day)
    PACK_COLORS=(base '#e1e2e7' surface '#d2d6e3' text '#3760bf' blue '#2e7de9' green '#587539' yellow '#8c6c3e' red '#f52a65' muted '#7e97d0' accent '#9854f1') ;;
  github-light)
    PACK_COLORS=(base '#ffffff' surface '#ebebec' text '#1f2328' blue '#0969da' green '#116329' yellow '#4d2d00' red '#cf222e' muted '#7d7f82' accent '#8250df') ;;
  night-owl)
    PACK_COLORS=(base '#011627' surface '#142839' text '#d6deeb' blue '#82aaff' green '#22da6e' yellow '#addb67' red '#ef5350' muted '#7d8a99' accent '#c792ea') ;;
  poimandres)
    PACK_COLORS=(base '#1a1e28' surface '#272b37' text '#a6accd' blue '#89ddff' green '#5de4c7' yellow '#fffac2' red '#d0679d' muted '#6b7088' accent '#fcc5e9') ;;
  material-ocean)
    PACK_COLORS=(base '#0f111a' surface '#1b1d26' text '#8f93a2' blue '#82aaff' green '#c3e88d' yellow '#ffcb6b' red '#ff5370' muted '#595c69' accent '#c792ea') ;;
  oxocarbon)
    PACK_COLORS=(base '#161616' surface '#2a2a2a' text '#f2f4f8' blue '#42be65' green '#33b1ff' yellow '#ee5396' red '#3ddbd9' muted '#969799' accent '#be95ff') ;;
  synthwave)
    PACK_COLORS=(base '#1b102d' surface '#29153e' text '#f2eaff' blue '#8ab4ff' green '#69f5b4' yellow '#ffe08a' red '#ff628e' muted '#795c91' accent '#ff79e9') ;;
  cyberpunk)
    PACK_COLORS=(base '#101a23' surface '#1a2c39' text '#e3faff' blue '#5eaaff' green '#64ffad' yellow '#ffe66d' red '#ff5277' muted '#648c9e' accent '#f56fff') ;;
  aurora)
    PACK_COLORS=(base '#101c25' surface '#1c3440' text '#e0f5ef' blue '#86caff' green '#66e6b1' yellow '#f0da87' red '#ff7fa0' muted '#638a91' accent '#bda3ff') ;;
  laserwave)
    PACK_COLORS=(base '#211529' surface '#39233f' text '#f6eafa' blue '#a0b5ff' green '#80efba' yellow '#ffda86' red '#ff718f' muted '#93799c' accent '#ff83d9') ;;
  *)
    TERMINAL_PACK_THEME=mocha
    PACK_COLORS=(base '#1e1e2e' surface '#313244' text '#cdd6f4' blue '#89b4fa' green '#a6e3a1' yellow '#f9e2af' red '#f38ba8' muted '#7f849c' accent '#cba6f7') ;;
esac

(( ! ${+functions[_gt_effect_prompt]} )) || _gt_effect_prompt

_pack_apply_highlights() {
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$PACK_COLORS[muted]"
  (( ${+ZSH_HIGHLIGHT_STYLES} )) || return 0
  ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=$PACK_COLORS[red],bold"
  ZSH_HIGHLIGHT_STYLES[command]="fg=$PACK_COLORS[green]"
  ZSH_HIGHLIGHT_STYLES[builtin]="fg=$PACK_COLORS[green]"
  ZSH_HIGHLIGHT_STYLES[alias]="fg=$PACK_COLORS[green]"
  ZSH_HIGHLIGHT_STYLES[path]="fg=$PACK_COLORS[blue],underline"
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$PACK_COLORS[yellow]"
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$PACK_COLORS[yellow]"
}

_gt_theme() {
  if [[ ${1:-list} == list && $# -le 1 ]]; then
    local theme
    for theme in $GTTERM_THEMES; do printf '%-20s %s\n' "$theme" "$GTTERM_THEME_LABELS[$theme]"; done
    return 0
  fi
  if [[ ${1:-} == preview && $# == 2 ]]; then
    _gt_setting_valid theme "$2" || { _gt_msg theme_usage >&2; return 1; }
    export TERMINAL_PACK_THEME=$2
    _gt_refresh
    return
  fi
  (( $# == 1 )) || { _gt_msg theme_usage >&2; return 1; }
  _gt_config_set theme "$1"
}

_pack_apply_palette() {
  if [[ ${TERM_PROGRAM:-} == iTerm.app ]]; then
    source "$TERMINAL_PACK_DIR/colors.zsh"
    local color_key
    for color_key in ${(k)PACK_ITERM_COLORS}; do
      printf '\033]1337;SetColors=%s=srgb:%s\007' "$color_key" "$PACK_ITERM_COLORS[$color_key]"
    done
  fi
}
