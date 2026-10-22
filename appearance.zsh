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
  *)
    TERMINAL_PACK_THEME=mocha
    PACK_COLORS=(base '#1e1e2e' surface '#313244' text '#cdd6f4' blue '#89b4fa' green '#a6e3a1' yellow '#f9e2af' red '#f38ba8' muted '#7f849c' accent '#cba6f7') ;;
esac

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
  if [[ ${1:-list} == list ]]; then
    local theme
    for theme in $GTTERM_THEMES; do
      printf '%-20s %s\n' "$theme" "$GTTERM_THEME_LABELS[$theme]"
    done
    return 0
  fi
  (( ${GTTERM_THEMES[(Ie)${1:-}]} )) || { _gt_msg theme_usage; return 1; }
  export TERMINAL_PACK_THEME=$1
  source "$TERMINAL_PACK_DIR/appearance.zsh"
  source "$TERMINAL_PACK_DIR/p10k.zsh"
  _pack_apply_highlights
  (( ${+functions[p10k]} )) && p10k reload
  _pack_apply_palette
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
