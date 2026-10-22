#!/bin/zsh
emulate -LR zsh
setopt ERR_EXIT NO_UNSET
root=${0:A:h}
TERMINAL_PACK_DIR=$root
source "$root/i18n.zsh"
source "$root/themes.zsh"
[[ "$root" == "$HOME/.config/iterm-pack" ]] || { _gt_msg uninstall_location >&2; exit 1; }
if [[ -r "$root/state/previous-default-profile" ]]; then
  current_default=$(command defaults read com.googlecode.iterm2 'Default Bookmark Guid' 2>/dev/null) || current_default=
  if [[ -n ${GTTERM_THEME_GUIDS[(re)$current_default]} ]]; then
    previous_default=$(<"$root/state/previous-default-profile")
    if [[ $previous_default == __unset__ ]]; then
      command defaults delete com.googlecode.iterm2 'Default Bookmark Guid'
    else
      command defaults write com.googlecode.iterm2 'Default Bookmark Guid' -string "$previous_default"
    fi
  fi
fi
rm -f -- "$HOME/Library/Application Support/iTerm2/DynamicProfiles/terminal-pack.json"
if [[ -f "$HOME/.zshrc" ]]; then
  temporary=$(/usr/bin/mktemp "$root/zshrc.XXXXXX")
  /usr/bin/awk '
    $0 == "# >>> terminal-pack aliases >>>" { skip=1; next }
    $0 == "# <<< terminal-pack aliases <<<" { skip=0; next }
    !skip { print }
  ' "$HOME/.zshrc" > "$temporary"
  cat "$temporary" > "$HOME/.zshrc"
fi
rm -rf -- "$root"
_gt_msg uninstalled
_gt_msg uninstall_chrome
_gt_msg uninstall_fonts
