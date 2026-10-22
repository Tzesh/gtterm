#!/bin/zsh
emulate -LR zsh
setopt ERR_EXIT NO_UNSET
root=${0:A:h}
TERMINAL_PACK_DIR=$root
source "$root/i18n.zsh"
[[ "$root" == "$HOME/.config/iterm-pack" ]] || { _gt_msg uninstall_location >&2; exit 1; }
if [[ -r "$root/state/previous-default-profile" ]]; then
  current_default=$(command defaults read com.googlecode.iterm2 'Default Bookmark Guid' 2>/dev/null) || current_default=
  if [[ $current_default == (A3D55D3B-9211-4B9F-A85C-ED99B2F6F845|2DF59236-48AA-42B7-8FE2-93DF59A5DAD4|3E7D7CB0-418C-43DD-9CF4-4C89196607ED) ]]; then
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
