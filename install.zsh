#!/bin/zsh
emulate -LR zsh
setopt ERR_EXIT NO_UNSET PIPE_FAIL
umask 077
root=${0:A:h}
TERMINAL_PACK_DIR=$root
source "$root/i18n.zsh"
source "$root/themes.zsh"
if (( $# )); then
  [[ $# == 2 && $1 == --lang && ($2 == en || $2 == tr) ]] || { print -u2 'Usage: zsh install.zsh [--lang en|tr]'; exit 1; }
  GTTERM_LANG=$2
fi
[[ $OSTYPE == darwin* ]] || { _gt_msg install_macos >&2; exit 1; }
autoload -Uz is-at-least
is-at-least 5.8 || { _gt_msg install_zsh >&2; exit 1; }
target="$HOME/.config/iterm-pack"
profiles="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
profile="$profiles/terminal-pack.json"
[[ ! -e "$target" && ! -e "$profile" ]] || { _gt_msg install_exists >&2; exit 1; }
[[ -f "$root/vendor/oh-my-zsh/oh-my-zsh.sh" && -f "$root/profile.json" ]] || { _gt_msg install_incomplete >&2; exit 1; }
mkdir -p "$HOME/.config" "$profiles" "$HOME/Library/Fonts"
# A failed installation removes only files created by this run.
typeset -a added_fonts=()
hook_added=0
_rollback() {
  if (( hook_added )); then
    if [[ -f "$target/original.zshrc" ]]; then cat "$target/original.zshrc" > "$HOME/.zshrc"; else rm -f "$HOME/.zshrc"; fi
  fi
  rm -rf -- "$target"
  rm -f -- "$profile"
  for font in "${added_fonts[@]}"; do rm -f -- "$font"; done
}
trap _rollback ZERR
mkdir "$target"
cp -R "$root/vendor" "$root/fonts" "$root/themes" "$root/docs" "$root/completions" "$target/"
for name in .zprofile .zshrc p10k.zsh appearance.zsh themes.zsh colors.zsh devtools.zsh gtterm.zsh i18n.zsh README.md CHANGELOG.md VERIFICATION.txt FONT-SOURCES.json GITSTATUS-SOURCES.json SOURCES.json THEME-SOURCES.json VERSION uninstall.zsh; do cp "$root/$name" "$target/$name"; done
mkdir -p "$target/cache/omz" "$target/custom" "$target/state"
print -r -- "$GTTERM_LANG" > "$target/state/language"
for font in "$root"/fonts/*.ttf; do
  dest="$HOME/Library/Fonts/${font:t}"
  if [[ ! -e "$dest" ]]; then
    added_fonts+=("$dest")
    cp "$font" "$dest"
  fi
done
print -rl -- "${added_fonts[@]}" > "$target/installed-fonts.txt"
cp "$root/profile.json" "$target/profile.json"
for (( index=0; index < ${#GTTERM_THEMES}; ++index )); do
  theme=$GTTERM_THEMES[$((index + 1))]
  command="/usr/bin/env ZDOTDIR=${(q)target} TERMINAL_PACK_THEME=$theme /bin/zsh -l"
  /usr/bin/plutil -replace "Profiles.$index.Command" -string "$command" "$target/profile.json"
done
/usr/bin/plutil -convert json "$target/profile.json"
cp "$target/profile.json" "$profile"
if ! /usr/bin/grep -Fqx '# >>> terminal-pack aliases >>>' "$HOME/.zshrc" 2>/dev/null; then
  [[ ! -e "$HOME/.zshrc" ]] || cp -p "$HOME/.zshrc" "$target/original.zshrc"
  hook_added=1
  printf '\n%s\n%s\n%s\n' '# >>> terminal-pack aliases >>>' '[[ ! -r "$HOME/.config/iterm-pack/devtools.zsh" ]] || source "$HOME/.config/iterm-pack/devtools.zsh"' '# <<< terminal-pack aliases <<<' >> "$HOME/.zshrc"
fi
# Save the previous preference before selecting Nord; do not close running sessions.
previous_default=$(command defaults read com.googlecode.iterm2 'Default Bookmark Guid' 2>/dev/null) || previous_default=__unset__
print -r -- "$previous_default" > "$target/state/previous-default-profile"
command defaults write com.googlecode.iterm2 'Default Bookmark Guid' -string 2DF59236-48AA-42B7-8FE2-93DF59A5DAD4
trap - ZERR
_gt_msg installed
_gt_msg install_preserved
_gt_msg install_remove
