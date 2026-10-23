# Bundled tools: integrity checks and explicit, narrowly scoped activation.
typeset -ga _GT_TOOLS=(fzf zoxide rg fd bat lazygit jq btm fastfetch)

_gt_install_args() {
  typeset -g GTTERM_INSTALL_LANG= GTTERM_TRUST_TOOLS=0
  while (( $# )); do
    case $1 in
      --trust-tools) GTTERM_TRUST_TOOLS=1; shift ;;
      --lang)
        (( $# >= 2 )) && [[ $2 == (en|tr) ]] || { print -u2 'Usage: zsh install.zsh [--lang en|tr] [--trust-tools]'; return 1; }
        GTTERM_INSTALL_LANG=$2; shift 2 ;;
      *) print -u2 'Usage: zsh install.zsh [--lang en|tr] [--trust-tools]'; return 1 ;;
    esac
  done
}

_gt_tools_arch() {
  typeset -g _GT_TOOL_ARCH=$(/usr/bin/uname -m)
  [[ $_GT_TOOL_ARCH == (arm64|x86_64) ]] || { _gt_msg tools_arch >&2; return 1; }
}

_gt_tools_verify() {
  local location=$1 arch tool digest relative
  local -A checksums
  [[ -d "$location/tools" && ! -L "$location/tools" && -r "$location/tools/SHA256SUMS" && ! -L "$location/tools/SHA256SUMS" ]] || { _gt_msg tools_corrupt >&2; return 1; }
  for arch in bin arm64 x86_64 shell; do
    [[ -d "$location/tools/$arch" && ! -L "$location/tools/$arch" ]] || { _gt_msg tools_corrupt >&2; return 1; }
  done
  while read -r digest relative; do
    [[ $digest =~ '^[0-9a-f]{64}$' && -n $relative && $relative != /* && $relative != *..* && -f "$location/tools/$relative" && ! -L "$location/tools/$relative" ]] || { _gt_msg tools_corrupt >&2; return 1; }
    [[ -z ${checksums[$relative]:-} ]] || { _gt_msg tools_corrupt >&2; return 1; }
    checksums[$relative]=$digest
  done < "$location/tools/SHA256SUMS"
  for arch in bin arm64 x86_64; do
    for tool in $_GT_TOOLS; do
      [[ -n ${checksums[$arch/$tool]:-} ]] || { _gt_msg tools_corrupt >&2; return 1; }
    done
  done
  for relative in shell/fzf-key-bindings.zsh shell/zoxide.zsh versions.tsv lazygit.yml bottom.toml fastfetch.jsonc; do
    [[ -n ${checksums[$relative]:-} ]] || { _gt_msg tools_corrupt >&2; return 1; }
  done
  local file
  for file in "$location/tools"/**/*(DN); do
    [[ ! -L $file ]] || { _gt_msg tools_corrupt >&2; return 1; }
    [[ -d $file ]] && continue
    relative=${file#"$location/tools/"}
    [[ $relative == SHA256SUMS ]] && continue
    [[ -f $file && -n ${checksums[$relative]:-} ]] || { _gt_msg tools_corrupt >&2; return 1; }
  done
  (cd "$location/tools" && /usr/bin/shasum -a 256 -c SHA256SUMS >/dev/null) || { _gt_msg tools_corrupt >&2; return 1; }
}

_gt_tools_prepare() {
  local location=$1 trust=${2:-0} tool file
  _gt_tools_verify "$location" || return
  _gt_tools_arch || return
  for tool in $_GT_TOOLS; do
    for file in "$location/tools/bin/$tool" "$location/tools/$_GT_TOOL_ARCH/$tool"; do
      chmod u+x "$file" || return
      if [[ $trust == 1 ]] && /usr/bin/xattr -p com.apple.quarantine "$file" >/dev/null 2>&1; then
        /usr/bin/xattr -d com.apple.quarantine "$file" || return
      fi
    done
  done
}

_gt_tool_os() {
  local tool=$1
  typeset -g _GT_TOOL_MINIMUM=11
  case $tool in lazygit) _GT_TOOL_MINIMUM=12 ;; jq) _GT_TOOL_MINIMUM=14 ;; fastfetch) _GT_TOOL_MINIMUM=26 ;; esac
  (( ${+_GT_MACOS_VERSION} )) || typeset -g _GT_MACOS_VERSION=$(/usr/bin/sw_vers -productVersion)
  autoload -Uz is-at-least
  is-at-least "$_GT_TOOL_MINIMUM" "$_GT_MACOS_VERSION"
}

_gt_tool_ready() {
  local tool=$1 file
  (( ${_GT_TOOLS[(Ie)$tool]} )) || return 1
  _gt_tool_os "$tool" || return 1
  [[ -n ${_GT_TOOL_ARCH:-} ]] || _gt_tools_arch || return
  for file in "$TERMINAL_PACK_DIR/tools/bin/$tool" "$TERMINAL_PACK_DIR/tools/$_GT_TOOL_ARCH/$tool"; do
    [[ -x $file && ! -L $file ]] || return 1
    /usr/bin/xattr -p com.apple.quarantine "$file" >/dev/null 2>&1 && return 1
  done
  return 0
}

_gt_tools_path() {
  _gt_tools_arch || return
  [[ -d "$TERMINAL_PACK_DIR/tools/bin" ]] || return 0
  path=("$TERMINAL_PACK_DIR/tools/bin" ${path:#$TERMINAL_PACK_DIR/tools/bin})
  (( ${path[(Ie)$HOME/.local/bin]} )) || path+=("$HOME/.local/bin")
  export PATH
  export _ZO_DATA_DIR="$TERMINAL_PACK_DIR/state/zoxide"
  (umask 077; mkdir -p "$_ZO_DATA_DIR") || return
  export BAT_THEME=${BAT_THEME:-ansi}
}

_gt_tools_colors() {
  (( ${+PACK_COLORS} )) || return 0
  (( ${+_GT_FZF_BASE_OPTS} )) || typeset -g _GT_FZF_BASE_OPTS=${FZF_DEFAULT_OPTS:-}
  export FZF_DEFAULT_OPTS="$_GT_FZF_BASE_OPTS --height=50% --layout=reverse --border=rounded --color=fg:$PACK_COLORS[text],bg:$PACK_COLORS[base],hl:$PACK_COLORS[blue],fg+:$PACK_COLORS[text],bg+:$PACK_COLORS[surface],hl+:$PACK_COLORS[accent],pointer:$PACK_COLORS[green],marker:$PACK_COLORS[yellow],prompt:$PACK_COLORS[blue],border:$PACK_COLORS[muted]"
}

_gt_zoxide_init() {
  _gt_tool_ready zoxide || { _gt_msg tools_blocked zoxide >&2; return 1; }
  source "$TERMINAL_PACK_DIR/tools/shell/zoxide.zsh"
}

_gt_tools_shell_init() {
  _gt_tools_path || return
  _gt_tools_colors
  # Load only key bindings: leave existing Tab/autocomplete widgets in charge.
  if _gt_tool_ready fzf; then
    if [[ -z ${FZF_CTRL_T_OPTS+x} ]]; then export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:120 -- {}'"; fi
    source "$TERMINAL_PACK_DIR/tools/shell/fzf-key-bindings.zsh"
  fi
  if _gt_tool_ready zoxide; then _gt_zoxide_init; fi
  return 0
}

_gt_jump() {
  (( ${+functions[__zoxide_z]} )) || _gt_zoxide_init || return
  if [[ ${1:-} == -i ]]; then shift; __zoxide_zi "$@"; else __zoxide_z "$@"; fi
}

_gt_tools_status() {
  local tool version result=0
  while IFS=$'\t' read -r tool version; do
    (( ${_GT_TOOLS[(Ie)$tool]} )) || continue
    if ! _gt_tool_os "$tool"; then
      _gt_msg tools_os "$tool" "$_GT_TOOL_MINIMUM"
      result=1
    elif _gt_tool_ready "$tool"; then
      printf '[%s] %-8s %s\n' "$(_gt_msg doctor_ok)" "$tool" "$version"
    else
      _gt_msg tools_blocked "$tool"
      result=1
    fi
  done < "$TERMINAL_PACK_DIR/tools/versions.tsv"
  return $result
}

_gt_tools_notice() {
  local TERMINAL_PACK_DIR=${1:-$TERMINAL_PACK_DIR}
  local tool
  for tool in $_GT_TOOLS; do
    if ! _gt_tool_os "$tool"; then _gt_msg tools_os "$tool" "$_GT_TOOL_MINIMUM"; continue; fi
    _gt_tool_ready "$tool" || { _gt_msg tools_activation; return 0; }
  done
}
