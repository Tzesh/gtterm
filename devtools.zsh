# Standalone helpers: usable in both Terminal Pack and normal Zsh sessions.
typeset -g TERMINAL_PACK_DIR=${TERMINAL_PACK_DIR:-$HOME/.config/iterm-pack}
source "$TERMINAL_PACK_DIR/i18n.zsh" || return

# Remove only the former package entrypoints when reloading an existing shell.
for _gt_legacy_name in pon poff jboss jboss-ports proxy-on proxy-off proxy-auto proxy-status chrome-local ports jvms pack-theme; do
  unalias "$_gt_legacy_name" 2>/dev/null || true
  unfunction "$_gt_legacy_name" 2>/dev/null || true
done
unset _gt_legacy_name

_pack_proxy_endpoint() {
  local endpoint=$1
  [[ $endpoint == *://* ]] || endpoint="http://$endpoint"
  if [[ ! $endpoint =~ '^https?://[A-Za-z0-9][A-Za-z0-9.-]*:[0-9]{1,5}$' ]]; then
    _gt_msg proxy_format >&2
    return 1
  fi
  local -i port_number=$((10#${endpoint##*:}))
  (( port_number > 0 && port_number <= 65535 )) || { _gt_msg port_range >&2; return 1; }
  REPLY=$endpoint
}

_gt_proxy_on() {
  local endpoint=${1:-} REPLY
  (( $# <= 1 )) || { _gt_msg proxy_usage >&2; return 1; }
  if [[ -z $endpoint && -r "$TERMINAL_PACK_DIR/state/proxy-url" ]]; then
    endpoint=$(<"$TERMINAL_PACK_DIR/state/proxy-url")
  fi
  [[ -n $endpoint ]] || { _gt_msg proxy_first >&2; return 1; }
  _pack_proxy_endpoint "$endpoint" || return
  endpoint=$REPLY
  if (( $# )); then
    (umask 077; mkdir -p "$TERMINAL_PACK_DIR/state" && print -r -- "$endpoint" > "$TERMINAL_PACK_DIR/state/proxy-url") || return
  fi
  export http_proxy=$endpoint https_proxy=$endpoint HTTP_PROXY=$endpoint HTTPS_PROXY=$endpoint
  local -aU exclusions=("${(@s:,:)${no_proxy:-${NO_PROXY:-}}}" localhost 127.0.0.1 ::1 .local jboss.local)
  exclusions=("${(@)exclusions:#}")
  export no_proxy="${(j:,:)exclusions}" NO_PROXY="${(j:,:)exclusions}"
  _gt_msg proxy_on "$endpoint"
}

_gt_proxy_off() {
  unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY
  _gt_msg proxy_off
}

_gt_proxy_auto() {
  case ${1:-status} in
    on)
      _gt_proxy_on || return
      (umask 077; mkdir -p "$TERMINAL_PACK_DIR/state" && print on > "$TERMINAL_PACK_DIR/state/proxy-auto") || return
      _gt_msg auto_on ;;
    off)
      (umask 077; mkdir -p "$TERMINAL_PACK_DIR/state" && print off > "$TERMINAL_PACK_DIR/state/proxy-auto") || return
      _gt_proxy_off
      _gt_msg auto_off ;;
    status)
      local preference=off
      [[ ! -r "$TERMINAL_PACK_DIR/state/proxy-auto" ]] || preference=$(<"$TERMINAL_PACK_DIR/state/proxy-auto")
      _gt_msg auto_status "$preference" ;;
    *) _gt_msg auto_usage >&2; return 1 ;;
  esac
}

_gt_proxy_status() {
  local off=$(_gt_msg off)
  print -r -- "HTTP: ${http_proxy:-$off}"
  print -r -- "HTTPS: ${https_proxy:-$off}"
  _gt_proxy_auto status
}

_gt_chrome() {
  local domain=${1:-jboss.local}
  (( $# <= 1 )) || { _gt_msg chrome_usage >&2; return 1; }
  if (( ${#domain} > 253 )) || [[ ! $domain =~ '^[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?(\.[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?)+$' ]]; then
    _gt_msg chrome_domain >&2
    return 1
  fi
  local chrome_app
  for chrome_app in '/Applications/Google Chrome.app' "$HOME/Applications/Google Chrome.app"; do
    [[ -d $chrome_app ]] && break
  done
  [[ -d $chrome_app ]] || { _gt_msg chrome_missing >&2; return 1; }
  domain=${domain:l}
  local browser_state="$HOME/Library/Application Support/Terminal Pack/Chrome/$domain"
  (umask 077; mkdir -p "$browser_state") || return
  open -na "$chrome_app" --args \
    "--user-data-dir=$browser_state" \
    "--host-resolver-rules=MAP $domain 127.0.0.1, EXCLUDE localhost" \
    --no-first-run --no-default-browser-check --new-window "http://$domain"
}

_gt_ports() {
  local filter=${1:-all}
  (( $# <= 1 )) || { _gt_msg ports_usage >&2; return 1; }
  case $filter in
    all|java|jboss) ;;
    <->)
      (( ${#filter} <= 5 )) && (( 10#$filter > 0 && 10#$filter <= 65535 )) || { _gt_msg port_range >&2; return 1; }
      filter=$((10#$filter)) ;;
    *) _gt_msg ports_usage >&2; return 1 ;;
  esac
  [[ $filter != jboss ]] || _gt_msg jboss_hint
  local listeners
  listeners=$(command lsof -nP -iTCP -sTCP:LISTEN -Fpcn 2>/dev/null) || {
    [[ -z $listeners ]] && { _gt_msg listeners_none; return 0; }
  }
  print -r -- "$listeners" | /usr/bin/awk -v filter="$filter" -v process="$(_gt_msg process)" -v address="$(_gt_msg address)" -v note="$(_gt_msg note)" -v port_http="$(_gt_msg port_http)" -v port_https="$(_gt_msg port_https)" -v port_management_http="$(_gt_msg port_management_http)" -v port_management_https="$(_gt_msg port_management_https)" -v port_ajp="$(_gt_msg port_ajp)" -v port_debug="$(_gt_msg port_debug)" -v ports_none="$(_gt_msg ports_none)" '
    BEGIN { printf "%-8s %-25s %-28s %s\n", "PID", process, address, note }
    /^p/ { pid=substr($0,2) }
    /^c/ { process=substr($0,2) }
    /^n/ {
      address=substr($0,2); port=address; sub(/^.*:/,"",port)
      if (seen[pid SUBSEP address]++) next
      if (filter=="java" && tolower(process)!="java") next
      common=(port==8080 || port==8443 || port==9990 || port==9993 || port==8009 || port==8787)
      if (filter=="jboss" && !common) next
      if (filter!="all" && filter!="java" && filter!="jboss" && port!=filter) next
      note=""
      if (port==8080) note=port_http
      if (port==8443) note=port_https
      if (port==9990) note=port_management_http
      if (port==9993) note=port_management_https
      if (port==8009) note=port_ajp
      if (port==8787) note=port_debug
      printf "%-8s %-25s %-28s %s\n", pid, process, address, note
      count++
    }
    END { if (!count) print ports_none }
  '
}

_gt_java() {
  local jps_bin
  if [[ -n ${JAVA_HOME:-} && -x "$JAVA_HOME/bin/jps" ]]; then
    jps_bin="$JAVA_HOME/bin/jps"
  elif (( $+commands[jps] )); then
    jps_bin=$commands[jps]
  else
    _gt_msg jps_missing
    /bin/ps -axo pid=,comm= | /usr/bin/awk -v empty="$(_gt_msg java_none)" '$0 ~ /\/java$/ {print; found=1} END {if (!found) print empty}'
    return
  fi
  "$jps_bin" -l | /usr/bin/awk -v empty="$(_gt_msg jvm_none)" '$2 !~ /(^|[.\/])Jps$/ {print; found=1} END {if (!found) print empty}'
}


# Load appearance only when requested from a normal Zsh profile.
_gt_theme() {
  source "$TERMINAL_PACK_DIR/appearance.zsh" || return
  _gt_theme "$@"
}

source "$TERMINAL_PACK_DIR/gtterm.zsh" || return


if [[ -r "$TERMINAL_PACK_DIR/state/proxy-auto" && $(<"$TERMINAL_PACK_DIR/state/proxy-auto") == on ]]; then
  _gt_proxy_on >/dev/null
fi
