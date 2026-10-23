#!/bin/zsh
emulate -LR zsh
setopt ERR_EXIT NO_UNSET PIPE_FAIL
umask 077
root=${0:A:h}
target="$HOME/.config/iterm-pack"
TERMINAL_PACK_DIR=$root
source "$root/tools.zsh"
_gt_install_args "$@" || exit 1
requested_language=$GTTERM_INSTALL_LANG
if [[ -n $requested_language ]]; then
  GTTERM_LANG=$requested_language
elif [[ -r "$target/state/language" ]]; then
  GTTERM_LANG=$(<"$target/state/language")
fi
source "$root/i18n.zsh"
[[ $OSTYPE == darwin* ]] || { _gt_msg install_macos >&2; exit 1; }
autoload -Uz is-at-least
is-at-least 5.8 || { _gt_msg install_zsh >&2; exit 1; }
[[ -d $target && ! -L $target && $root != $target && "$root/" != "$target/"* && -r "$target/VERSION" && -r "$target/devtools.zsh" ]] || { _gt_msg upgrade_invalid >&2; exit 1; }
# Validate incoming code before changing the working installation.
typeset -a runtime_files=(.zprofile .zshrc p10k.zsh appearance.zsh themes.zsh settings.zsh tools.zsh snippets.zsh chrome.zsh mac.zsh effects.zsh colors.zsh devtools.zsh gtterm.zsh i18n.zsh README.md CHANGELOG.md VERIFICATION.txt FONT-SOURCES.json GITSTATUS-SOURCES.json SOURCES.json THEME-SOURCES.json TOOLS-SOURCES.json VERSION uninstall.zsh upgrade.zsh)
for name in $runtime_files profile.json vendor/oh-my-zsh/oh-my-zsh.sh vendor/powerlevel10k/powerlevel10k.zsh-theme; do
  [[ -r "$root/$name" ]] || { _gt_msg install_incomplete >&2; exit 1; }
done
for name in .zprofile .zshrc p10k.zsh appearance.zsh themes.zsh settings.zsh tools.zsh snippets.zsh chrome.zsh mac.zsh effects.zsh colors.zsh devtools.zsh gtterm.zsh i18n.zsh uninstall.zsh upgrade.zsh; do
  /bin/zsh -n "$root/$name"
done
/usr/bin/plutil -extract Profiles json -o /dev/null "$root/profile.json"
_gt_tools_verify "$root" || exit 1
source "$root/themes.zsh"
source "$root/settings.zsh"
lock="$HOME/.config/.gtterm-upgrade.lock"
mkdir "$lock" 2>/dev/null || { _gt_msg upgrade_locked >&2; exit 1; }
backup=
stage=
old_moved=0
new_moved=0
committed=0
had_profile=0
typeset -a added_fonts=()
profile="$HOME/Library/Application Support/iTerm2/DynamicProfiles/terminal-pack.json"
_gt_upgrade_finish() {
  local result=$1 font
  trap - EXIT INT TERM
  if (( ! committed && old_moved )); then
    (( ! new_moved )) || /bin/rm -rf -- "$target"
    if /bin/mv -- "$backup/runtime" "$target"; then
      if (( had_profile )); then
        /bin/cp -p "$backup/dynamic-profile.json" "$profile"
      else
        /bin/rm -f -- "$profile"
      fi
      _gt_msg upgrade_rolled_back >&2
    else
      _gt_msg upgrade_restore "$backup/runtime" >&2
    fi
  fi
  if (( ! committed )); then
    for font in $added_fonts; do /bin/rm -f -- "$font"; done
  fi
  [[ -z $stage || ! -d $stage ]] || /bin/rm -rf -- "$stage"
  /bin/rmdir "$lock" 2>/dev/null || true
  return $result
}
trap '_gt_upgrade_finish $?' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
mkdir -p "$HOME/.config/iterm-pack-backups"
backup=$(/usr/bin/mktemp -d "$HOME/.config/iterm-pack-backups/upgrade-$(/bin/date +%Y%m%d-%H%M%S).XXXXXX")
stage=$(/usr/bin/mktemp -d "$HOME/.config/.gtterm-stage.XXXXXX")
for name in vendor fonts themes docs completions tools snippets ui assets; do cp -R "$root/$name" "$stage/"; done
for name in $runtime_files; do cp "$root/$name" "$stage/$name"; done
mkdir -p "$stage/cache/omz" "$stage/custom" "$stage/state"
# Preserve machine-local preferences and the original uninstall ownership records.
for name in state local.zsh custom original.zshrc installed-fonts.txt; do
  [[ ! -e "$target/$name" ]] || cp -Rp "$target/$name" "$stage/"
done
[[ -z $requested_language ]] || print -r -- "$requested_language" > "$stage/state/language"
_gt_tools_prepare "$stage" "$GTTERM_TRUST_TOOLS"
cp "$root/profile.json" "$stage/profile.json"
for (( index=0; index <= ${#GTTERM_THEMES}; ++index )); do
  theme=${GTTERM_THEMES[$((index + 1))]:-nord}
  command="/usr/bin/env ZDOTDIR=${(q)target} TERMINAL_PACK_THEME=$theme /bin/zsh -l"
  /usr/bin/plutil -replace "Profiles.$index.Command" -string "$command" "$stage/profile.json"
done
_gt_settings_load "$stage"
_gt_profile_settings "$stage/profile.json"
mkdir -p "${profile:h}" "$HOME/Library/Fonts"
if [[ -e $profile ]]; then
  cp -p "$profile" "$backup/dynamic-profile.json"
  had_profile=1
fi
for font in "$root"/fonts/*.ttf; do
  dest="$HOME/Library/Fonts/${font:t}"
  if [[ ! -e $dest ]]; then
    added_fonts+=("$dest")
    cp "$font" "$dest"
    print -r -- "$dest" >> "$stage/installed-fonts.txt"
  fi
done
# Rename only after the complete replacement is ready; preserve the old tree as a private backup.
mv "$target" "$backup/runtime"
old_moved=1
mv "$stage" "$target"
new_moved=1
cp "$target/profile.json" "$profile"
committed=1
_gt_msg upgraded "$(cat "$target/VERSION")"
_gt_msg upgrade_backup "$backup"
_gt_msg upgrade_reopen
_gt_tools_notice "$target"

source "$root/chrome.zsh"
_gt_tabs_install "$target"
