# Native iTerm text treatments only. No shaders, screen timers or keyboard changes.
typeset -ga GTTERM_EFFECTS=(off retro fallout amber typewriter neon)

# Reattach before regeneration: local/zoomed font overrides otherwise survive
# shared-profile changes and can be inherited by new tabs. No security prefs change.
_gt_effect_rebind() {
  [[ ${TERM_PROGRAM:-} == iTerm.app && -t 0 && -t 1 && -z ${SSH_CONNECTION:-}${SSH_TTY:-}${TMUX:-}${STY:-} ]] || return 1
  local current=${ITERM_PROFILE:-} preference
  local -a owned
  [[ -n $current && $current != *[[:cntrl:]]* && -r "$TERMINAL_PACK_DIR/ui/profile-names.txt" ]] || return 1
  owned=("${(@f)$(<"$TERMINAL_PACK_DIR/ui/profile-names.txt")}")
  (( ${owned[(Ie)$current]} )) || return 1
  preference=$(command defaults read com.googlecode.iterm2 PreventEscapeSequenceFromChangingProfile 2>/dev/null) || preference=unset
  if [[ $preference == (1|true) ]]; then _gt_msg effect_rebind_denied >&2; return 2; fi
  builtin printf '\033]1337;SetProfile=%s\007' "$current"
  [[ $preference == (0|false) ]] || _gt_msg effect_rebind_permission
  return 0
}

_gt_effect_spec() {
  typeset -gA GTTERM_EFFECT_COLORS=()
  typeset -g GTTERM_EFFECT_FONT=MesloLGS-NF-Regular GTTERM_EFFECT_AA=true GTTERM_EFFECT_BLINK=false GTTERM_EFFECT_ANIMATE=false
  case $1 in
    off) ;;
    retro) GTTERM_EFFECT_FONT=VT323-Regular; GTTERM_EFFECT_AA=false ;;
    fallout)
      GTTERM_EFFECT_FONT=VT323-Regular; GTTERM_EFFECT_AA=false; GTTERM_EFFECT_BLINK=true; GTTERM_EFFECT_ANIMATE=true
      GTTERM_EFFECT_COLORS=(fg 8aff80 bg 061009 bold b8ffae selbg 23472a selfg e0ffdb curbg a4ff8f curfg 061009 tab 8aff80) ;;
    amber)
      GTTERM_EFFECT_FONT=VT323-Regular; GTTERM_EFFECT_AA=false; GTTERM_EFFECT_BLINK=true; GTTERM_EFFECT_ANIMATE=true
      GTTERM_EFFECT_COLORS=(fg ffc36a bg 160e07 bold ffdda3 selbg 594024 selfg fff0d4 curbg ffd18a curfg 160e07 tab ffc36a) ;;
    typewriter)
      GTTERM_EFFECT_FONT=Courier
      GTTERM_EFFECT_COLORS=(fg e8d8b8 bg 1b1713 bold fff0d4 selbg 514535 selfg fff0d4 curbg e8c68e curfg 1b1713 tab c6a36b) ;;
    neon)
      GTTERM_EFFECT_FONT=MesloLGS-NF-Bold; GTTERM_EFFECT_BLINK=true; GTTERM_EFFECT_ANIMATE=true
      GTTERM_EFFECT_COLORS=(fg d8ffff bg 100c22 bold ffffff selbg 42305e selfg ffffff curbg ff68df curfg 100c22 tab ff68df) ;;
    *) return 1 ;;
  esac
}

_gt_effect_palette() {
  _gt_effect_spec "${GTTERM_EFFECT:-off}" || return
  local key
  for key in ${(k)GTTERM_EFFECT_COLORS}; do PACK_ITERM_COLORS[$key]=$GTTERM_EFFECT_COLORS[$key]; done
}

_gt_effect_prompt() {
  _gt_effect_spec "${GTTERM_EFFECT:-off}" || return
  [[ -n ${GTTERM_EFFECT_COLORS[fg]:-} ]] || return 0
  PACK_COLORS[text]="#$GTTERM_EFFECT_COLORS[fg]"
  PACK_COLORS[base]="#$GTTERM_EFFECT_COLORS[bg]"
  PACK_COLORS[surface]="#$GTTERM_EFFECT_COLORS[selbg]"
  PACK_COLORS[accent]="#$GTTERM_EFFECT_COLORS[curbg]"
}

_gt_effect_color_json() {
  local hex=$1 LC_ALL=C
  builtin printf '{"Red Component":%.9f,"Green Component":%.9f,"Blue Component":%.9f,"Alpha Component":1,"Color Space":"sRGB"}' \
    "$(( 16#${hex[1,2]} / 255.0 ))" "$(( 16#${hex[3,4]} / 255.0 ))" "$(( 16#${hex[5,6]} / 255.0 ))"
}

# Always restore the package base first so off and repeated changes cannot accumulate.
_gt_effect_profile() {
  local file=$1 index=$2 effect=$3 font_size=$4 key value color_key format
  local baseline="$TERMINAL_PACK_DIR/ui/effect-base.json"
  local -A color_keys=('Foreground Color' fg 'Background Color' bg 'Bold Color' bold 'Cursor Color' curbg 'Cursor Text Color' curfg 'Selection Color' selbg 'Selected Text Color' selfg 'Tab Color' tab)
  [[ -r $baseline ]] || return 1
  for key in 'Foreground Color' 'Background Color' 'Bold Color' 'Cursor Color' 'Cursor Text Color' 'Selection Color' 'Selected Text Color' 'Tab Color' 'Use Non-ASCII Font' 'ASCII Anti Aliased' 'Non-ASCII Anti Aliased' 'Thin Strokes' 'Use Bold Font' 'Draw Powerline Glyphs' 'Blinking Cursor' 'Animate Movement' 'Animate Movement Only in Interactive Apps'; do
    format=raw
    (( ! ${+color_keys[$key]} )) || format=json
    if value=$(/usr/bin/plutil -extract "Profiles.$index.$key" "$format" -o - "$baseline" 2>/dev/null); then
      /usr/bin/plutil -replace "Profiles.$index.$key" -json "$value" "$file" || return
    else
      /usr/bin/plutil -remove "Profiles.$index.$key" "$file" >/dev/null 2>&1 || true
    fi
  done
  _gt_effect_spec "$effect" || return
  [[ $effect != off ]] || return 0
  /usr/bin/plutil -replace "Profiles.$index.Normal Font" -string "$GTTERM_EFFECT_FONT $font_size" "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Non Ascii Font" -string "MesloLGS-NF-Regular $font_size" "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Use Non-ASCII Font" -bool true "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Draw Powerline Glyphs" -bool true "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.ASCII Anti Aliased" -bool "$GTTERM_EFFECT_AA" "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Non-ASCII Anti Aliased" -bool true "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Thin Strokes" -integer 0 "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Use Bold Font" -bool true "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Cursor Type" -integer 0 "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Blinking Cursor" -bool "$GTTERM_EFFECT_BLINK" "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Animate Movement" -bool "$GTTERM_EFFECT_ANIMATE" "$file" || return
  /usr/bin/plutil -replace "Profiles.$index.Animate Movement Only in Interactive Apps" -bool false "$file" || return
  for key in ${(k)color_keys}; do
    color_key=$color_keys[$key]
    [[ -n ${GTTERM_EFFECT_COLORS[$color_key]:-} ]] || continue
    value=$(_gt_effect_color_json "$GTTERM_EFFECT_COLORS[$color_key]") || return
    /usr/bin/plutil -replace "Profiles.$index.$key" -json "$value" "$file" || return
  done
}
