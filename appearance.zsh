# Shared colors keep the prompt, suggestions and highlighting in sync.
export TERMINAL_PACK_THEME=${TERMINAL_PACK_THEME:-nord}
[[ $TERMINAL_PACK_THEME == (mocha|nord|latte) ]] || TERMINAL_PACK_THEME=nord
typeset -gA PACK_COLORS
case $TERMINAL_PACK_THEME in
  nord)
    PACK_COLORS=(base '#2e3440' surface '#3b4252' text '#d8dee9' blue '#88c0d0' green '#a3be8c' yellow '#ebcb8b' red '#bf616a' muted '#7b88a1' accent '#b48ead') ;;
  latte)
    PACK_COLORS=(base '#eff1f5' surface '#dce0e8' text '#4c4f69' blue '#1e66f5' green '#40a02b' yellow '#df8e1d' red '#d20f39' muted '#7c7f93' accent '#8839ef') ;;
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
  case ${1:-} in
    mocha|nord|latte) ;;
    *) if (( $+functions[_gt_msg] )); then _gt_msg theme_usage; else print 'Usage: gtterm theme mocha | nord | latte'; fi; return 1 ;;
  esac
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
