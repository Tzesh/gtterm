# Explicit Mac actions only; no startup probes, clipboard reads or background jobs.
_gt_mac_path() {
  local candidate=$1
  [[ -e $candidate ]] || { _gt_msg mac_path "$candidate" >&2; return 1; }
  REPLY=${candidate:A}
}

_gt_mac_tool() {
  _gt_tool_os "$1" || { _gt_msg tools_os "$1" "$_GT_TOOL_MINIMUM" >&2; return 1; }
  _gt_tool_ready "$1" || { _gt_msg tools_blocked "$1" >&2; return 1; }
}

_gt_mac() {
  emulate -L zsh
  local action=$1 REPLY mode
  shift
  case $action in
    monitor)
      (( $# <= 1 )) && [[ ${1:-normal} == (normal|tree|basic) ]] || { _gt_msg mac_usage 'monitor [tree|basic]' >&2; return 1; }
      [[ -t 0 && -t 1 ]] || { _gt_msg mac_tty >&2; return 1; }
      _gt_mac_tool btm || return
      mode=${1:-normal}
      local -a monitor_args=(--config "$TERMINAL_PACK_DIR/tools/bottom.toml" --read_only --rate 2s)
      case $mode in tree) monitor_args+=(--tree) ;; basic) monitor_args+=(--basic) ;; esac
      btm "${monitor_args[@]}" ;;
    sysinfo)
      (( $# == 0 )) || { _gt_msg mac_usage sysinfo >&2; return 1; }
      _gt_mac_tool fastfetch || return
      fastfetch --config "$TERMINAL_PACK_DIR/tools/fastfetch.jsonc" ;;
    finder)
      (( $# <= 1 )) || { _gt_msg mac_usage 'finder [PATH]' >&2; return 1; }
      _gt_mac_path "${1:-$PWD}" || return
      # Reveal every path: plain open would execute application/package bundles.
      /usr/bin/open -R "$REPLY" ;;
    preview)
      (( $# == 1 )) || { _gt_msg mac_usage 'preview FILE' >&2; return 1; }
      _gt_mac_path "$1" || return
      /usr/bin/qlmanage -p "$REPLY" ;;
    copy-path)
      (( $# <= 1 )) || { _gt_msg mac_usage 'copy-path [PATH]' >&2; return 1; }
      _gt_mac_path "${1:-$PWD}" || return
      builtin printf '%s' "$REPLY" | /usr/bin/pbcopy ;;
    copy)
      (( $# == 0 )) || { _gt_msg mac_usage 'copy < FILE  |  COMMAND | gtterm copy' >&2; return 1; }
      [[ ! -t 0 ]] || { _gt_msg mac_copy_pipe >&2; return 1; }
      /usr/bin/pbcopy ;;
    disk)
      (( $# <= 1 )) || { _gt_msg mac_usage 'disk [PATH]' >&2; return 1; }
      _gt_mac_path "${1:-$PWD}" || return
      /bin/df -h "$REPLY" ;;
    awake)
      (( $# >= 2 )) && [[ $1 == -- && -n $2 && $2 != -* ]] || { _gt_msg mac_usage 'awake -- COMMAND [ARG…]' >&2; return 1; }
      shift
      /usr/bin/caffeinate -i -- "$@" ;;
    *) return 1 ;;
  esac
}
