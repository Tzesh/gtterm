# Official terminal palettes, applied to the current session.
typeset -gA PACK_ITERM_COLORS
case $TERMINAL_PACK_THEME in
  mocha) PACK_ITERM_COLORS=(fg cdd6f4 bg 1e1e2e bold cdd6f4 selbg 585b70 selfg cdd6f4 curbg f5e0dc curfg 1e1e2e tab cba6f7 black 45475a red f38ba8 green a6e3a1 yellow f9e2af blue 89b4fa magenta f5c2e7 cyan 94e2d5 white a6adc8 br_black 585b70 br_red f37799 br_green 89d88b br_yellow ebd391 br_blue 74a8fc br_magenta f2aede br_cyan 6bd7ca br_white bac2de) ;;
  nord) PACK_ITERM_COLORS=(fg d8dee9 bg 2e3440 bold d8dee9 selbg 434c5e selfg d8dee9 curbg d8dee9 curfg 2e3440 tab 88c0d0 black 3b4252 red bf616a green a3be8c yellow ebcb8b blue 81a1c1 magenta b48ead cyan 88c0d0 white e5e9f0 br_black 4c566a br_red bf616a br_green a3be8c br_yellow ebcb8b br_blue 81a1c1 br_magenta b48ead br_cyan 8fbcbb br_white eceff4) ;;
  latte) PACK_ITERM_COLORS=(fg 4c4f69 bg eff1f5 bold 4c4f69 selbg acb0be selfg 4c4f69 curbg dc8a78 curfg eff1f5 tab 8839ef black 5c5f77 red d20f39 green 40a02b yellow df8e1d blue 1e66f5 magenta ea76cb cyan 179299 white acb0be br_black 6c6f85 br_red de293e br_green 49af3d br_yellow eea02d br_blue 456eff br_magenta fe85d8 br_cyan 2d9fa8 br_white bcc0cc) ;;
esac
