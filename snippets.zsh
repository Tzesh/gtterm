# Snippets are plaintext: showing/copying never executes their contents.
_gt_snippet_file() {
  local name=$1 directory="$TERMINAL_PACK_DIR/state/snippets" file
  [[ $name =~ '^[a-z0-9][a-z0-9_-]{0,47}$' && ! -L $directory ]] || { _gt_msg snippet_missing "$name" >&2; return 1; }
  file="$directory/$name.txt"
  if [[ ! -e $file && ! -L $file ]]; then file="$TERMINAL_PACK_DIR/snippets/$GTTERM_LANG/$name.txt"; fi
  [[ -f $file && ! -L $file ]] || { _gt_msg snippet_missing "$name" >&2; return 1; }
  (( $(/usr/bin/stat -f %z "$file") <= 32768 )) || { _gt_msg snippet_large >&2; return 1; }
  REPLY=$file
}

_gt_snippet_names() {
  local file name
  local -a names=()
  for file in "$TERMINAL_PACK_DIR/snippets/$GTTERM_LANG/"*.txt(N) "$TERMINAL_PACK_DIR/state/snippets/"*.txt(N); do
    [[ -f $file && ! -L $file ]] || continue
    name=${file:t:r}
    [[ $name =~ '^[a-z0-9][a-z0-9_-]{0,47}$' ]] && names+=("$name")
  done
  print -rl -- ${(ou)names}
}

_gt_snippet() {
  local action=${1:-list} REPLY selected
  (( $# )) && shift
  case $action in
    list) (( $# == 0 )) || { _gt_msg snippet_usage >&2; return 1; }; _gt_snippet_names ;;
    show|copy)
      (( $# == 1 )) || { _gt_msg snippet_usage >&2; return 1; }
      _gt_snippet_file "$1" || return
      if [[ $action == show ]]; then /bin/cat "$REPLY"; else
        command pbcopy < "$REPLY" || return
        _gt_msg snippet_copied "$1"
      fi ;;
    pick)
      (( $# == 0 )) || { _gt_msg snippet_usage >&2; return 1; }
      _gt_tool_ready fzf || { _gt_msg tools_blocked fzf >&2; return 1; }
      selected=$(_gt_snippet_names | fzf --no-multi --prompt='gtterm snippet > ') || return
      [[ -n $selected ]] || return 1
      _gt_snippet copy "$selected" ;;
    *) _gt_msg snippet_usage >&2; return 1 ;;
  esac
}

_gt_cli() {
  local name executable
  _gt_msg cli_local
  for name in agent cursor-agent codex copilot claude; do
    if (( $+commands[$name] )); then
      executable=$commands[$name]
      printf '[%s] %-14s %s\n' "$(_gt_msg doctor_ok)" "$name" "$executable"
    else
      printf '[%s] %s\n' "$(_gt_msg doctor_optional)" "$name"
    fi
  done
}
