# gtterm: isolated from the normal ~/.zshrc.
typeset -g TERMINAL_PACK_DIR=${${(%):-%x}:A:h}
export ZSH="$TERMINAL_PACK_DIR/vendor/oh-my-zsh"
export ZSH_CUSTOM="$TERMINAL_PACK_DIR/custom"
export ZSH_CACHE_DIR="$TERMINAL_PACK_DIR/cache/omz"
ZSH_COMPDUMP="$TERMINAL_PACK_DIR/cache/zcompdump-$ZSH_VERSION"
ZSH_THEME=""
zstyle ':omz:update' mode disabled
plugins=(git colored-man-pages)
bindkey -e
fpath=("$TERMINAL_PACK_DIR/completions" $fpath)
fpath=("$TERMINAL_PACK_DIR/vendor/zasync" $fpath)
autoload -Uz +X zasync
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)
zstyle ':autocomplete:*' delay 0.25
zstyle ':autocomplete:*' min-input 2
zstyle ':autocomplete:*' list-lines 8
source "$TERMINAL_PACK_DIR/vendor/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$ZSH/oh-my-zsh.sh"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_IGNORE_ALL_DUPS
source "$TERMINAL_PACK_DIR/appearance.zsh"
source "$TERMINAL_PACK_DIR/p10k.zsh"
source "$TERMINAL_PACK_DIR/vendor/powerlevel10k/powerlevel10k.zsh-theme"
_pack_apply_highlights
ZSH_AUTOSUGGEST_STRATEGY=(history)
source "$TERMINAL_PACK_DIR/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^[[C' forward-char
bindkey '^[f' forward-word
[[ -r "$TERMINAL_PACK_DIR/local.zsh" ]] && source "$TERMINAL_PACK_DIR/local.zsh"
source "$TERMINAL_PACK_DIR/devtools.zsh"
source "$TERMINAL_PACK_DIR/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
_pack_apply_highlights
_pack_apply_palette
