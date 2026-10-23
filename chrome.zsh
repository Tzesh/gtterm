# Native iTerm directory metadata updates on cd; no prompt redraw or periodic process.
_gt_directory_report() {
  emulate -L zsh
  [[ ${TERM_PROGRAM:-} == iTerm.app && -t 1 ]] || return 0
  unsetopt MULTIBYTE
  local LC_ALL=C character encoded uri=
  local -i index
  for (( index=1; index <= ${#PWD}; ++index )); do
    character=$PWD[$index]
    if [[ $character == [a-zA-Z0-9/._~-] ]]; then uri+=$character
    else builtin printf -v encoded '%%%02X' "'$character"; uri+=$encoded; fi
  done
  builtin printf '\033]7;file://localhost%s\007' "$uri"
}

_gt_directory_init() {
  [[ ${TERM_PROGRAM:-} == iTerm.app && -t 1 ]] || return 0
  autoload -Uz add-zsh-hook
  add-zsh-hook -d chpwd _gt_directory_report 2>/dev/null
  add-zsh-hook chpwd _gt_directory_report
  _gt_directory_report
}

_gt_menu() {
  _gt_tool_ready fzf || { _gt_msg tools_blocked fzf >&2; return 1; }
  local selected action choice
  selected=$(_gt_msg menu_actions | fzf --delimiter=$'\t' --with-nth=2 --no-multi --prompt='gtterm menu > ') || return
  action=${selected%%$'\t'*}
  case $action in
    theme) choice=$(print -rl -- $GTTERM_THEMES | fzf --no-multi --prompt='theme > ') && gtterm theme "$choice" ;;
    background) choice=$(print -rl -- off glass frost retrowave | fzf --no-multi --prompt='background > ') && gtterm background "$choice" ;;
    effect) choice=$(print -rl -- $GTTERM_EFFECTS | fzf --no-multi --prompt='effect > ') && gtterm effect "$choice" ;;
    statusbar) choice=$(print -rl -- off minimal dashboard | fzf --no-multi --prompt='statusbar > ') && gtterm statusbar "$choice" ;;
    tabs) choice=$(print -rl -- smart profile | fzf --no-multi --prompt='tabs > ') && gtterm tabs "$choice" ;;
    snippet) gtterm snippet pick ;;
    cli) gtterm cli ;;
    tools) gtterm tools ;;
    monitor|sysinfo|finder|disk) gtterm "$action" ;;
    *) return 1 ;;
  esac
}

# iTerm hides its tab bar for a single tab by default. Keep one owned preference reversible.
_gt_tabs_install() {
  local location=$1 previous
  [[ ! -f "$location/state/previous-hide-tab" ]] || return 0
  previous=$(command defaults read com.googlecode.iterm2 HideTab 2>/dev/null) || previous=__unset__
  [[ $previous == (0|1|__unset__) ]] || return 0
  (umask 077; print -r -- "$previous" > "$location/state/previous-hide-tab") || return 1
  if command defaults write com.googlecode.iterm2 HideTab -bool false; then
    return 0
  fi
  rm -f -- "$location/state/previous-hide-tab"
  _gt_msg tabs_visibility_failed >&2
  return 0
}

_gt_tabs_restore() {
  local location=$1 current previous
  [[ -r "$location/state/previous-hide-tab" ]] || return 0
  current=$(command defaults read com.googlecode.iterm2 HideTab 2>/dev/null) || return 0
  [[ $current == 0 ]] || return 0
  previous=$(<"$location/state/previous-hide-tab")
  case $previous in
    __unset__) command defaults delete com.googlecode.iterm2 HideTab ;;
    0|1) command defaults write com.googlecode.iterm2 HideTab -bool "$previous" ;;
    *) return 0 ;;
  esac
}
