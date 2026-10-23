# Changelog

## 3.0.1 — 2026-10-23

- Recognize `~/.local/bin` automatically in gtterm profiles and helper-enabled shells, including reload; append only when missing and retain existing PATH order.
- Keep bundled tool precedence and existing `local.zsh` PATH overrides; no CLI execution, installation or user dotfile edits.
- Document GitHub Source code ZIP installation and how to refresh PATH without sourcing an unrelated Powerlevel10k configuration.

## 3.0.0 — 2026-10-23

- 40 coordinated palettes and five prompt styles, persistent settings/menu and Work, Focus and Presentation presets.
- Native text effects: retro, fallout, amber, typewriter and neon; bundled OFL VT323 with Meslo Unicode fallback. Independent background off/glass/frost/retrowave modes.
- Complete effect-off restoration: Meslo, ASCII/non-ASCII smoothing, native Powerline rendering, thin strokes, theme colors, saved cursor shape and normal cursor animation/blink. Font size, spacing and background stay selected.
- Correct native Powerline preference key. Native current-profile reapplication clears session overrides, with explicit apply and existing iTerm permission handling.
- Control+Esc top dropdown, native status bar/CPU-RAM dashboard, smart directory/job tab titles and command palette.
- Nine pinned offline tools for Intel/Apple Silicon: fzf, zoxide, rg, fd, bat, lazygit, jq, bottom and Fastfetch. Read-only resource monitor and compact system summary.
- Reusable bilingual snippets, AI CLI availability report, Finder/Quick Look/clipboard/disk/awake helpers.
- One installer for fresh installs and in-place upgrades, with private backup/rollback and preserved user settings. No sudo, Homebrew or installer-time download.
- Validate generated profiles as native property lists; empty background paths prevent the iTerm startup crash caused by JSON null.
- Updated English/Turkish documentation, README and offline galleries. No shader/alternate terminal, provider installation, new Java/JBoss features or input remapping.

## 2.5.0 — offline tools and workspace presets

- Bundle fzf, zoxide, ripgrep, fd and bat for Apple Silicon and Intel; no sudo, Homebrew or installer-time downloads.
- Pinned release archives, SHA256 integrity manifest, upstream sources and licenses.
- Explicit `--trust-tools` activation limited to verified tool executables; quarantined integrations are skipped by default.
- Fuzzy history/file/directory bindings, bat previews, theme-aware colors and `gtterm jump`.
- Persistent Work, Focus and Presentation presets; palette, language and proxy retained.
- Same installer upgrades in place and preserves private preferences/database; bilingual tools documentation and gallery presets.
- README unchanged; no JBoss log coloring.

## 2.4.0 — 36 themes and persistent customization

- Added 18 bundled palettes; all 36 original/named profiles have stable identifiers.
- Five independent prompt styles: rounded, minimal, powerline, compact and ASCII.
- Persistent theme/style, font size, line spacing, icons, prompt spacing and suggestions.
- Added `gtterm config` menu, validated show/set/reset commands and complete tab completion.
- Temporary theme preview does not overwrite the saved theme; updates preserve preferences.
- Updated bilingual documentation and theme/style gallery; README unchanged.

## 2.3.0 — rounded workspace and one-command upgrades

- Rounded Powerlevel10k prompt capsules, a subtle two-line guide and clearer error/duration blocks.
- Larger 15-point font, more line spacing and theme-colored tabs across all 18 profiles.
- `zsh install.zsh` installs fresh or upgrades in place, preserving personal settings, user dotfiles and the selected iTerm default.
- Upgrades stage replacement files, keep a private backup and roll back failed runtime/profile switches.
- Nord default, user settings and the gitstatusd workaround are preserved.

## 2.2.0 — 18 coordinated themes

- Added 15 themes with matching iTerm palettes, Powerlevel10k colors, suggestions and syntax highlights.
- Added `gtterm theme list` and tab completion for every theme.
- Kept Nord as the default and preserved the original three profile identifiers.
- All theme files are bundled; install and switching require no downloads, sudo or Homebrew.
- Retained the 2.1.1 fix that avoids launching gitstatusd.

## 2.1.1 — Git prompt without gitstatusd

- Use Powerlevel10k’s Zsh `vcs_info` backend instead of executing the bundled unnotarized gitstatusd binary.
- Avoid the macOS verification alert after browser downloads without changing Gatekeeper settings or removing quarantine attributes.
- Keep the Git branch/status prompt; large repositories may update more slowly.

## 2.1.0 — one entrypoint, Nord by default

- Installer selects gtterm - Nord as the saved default profile and restores the previous preference on removal. Existing sessions are preserved.
- Removed the former aliases and public helper functions. Use only `gtterm …`.
- Reload removes old package shortcuts from the current shell; unrelated user/plugin aliases are preserved.
- Updated English/Turkish help and reference documentation.

## 2.0.0 — gtterm

- Introduced `gtterm` as the main shell command, with help, status, doctor, local documentation, version and reload actions.
- Added persistent English/Turkish language selection; English is the default. Command and alias names remain English.
- Routed themes, proxy controls, Chrome mapping and Java/port inspection through the main command while retaining existing shortcuts.
- Added tab completion for gtterm subcommands and a complete offline guide, reference and troubleshooting manual in both languages.
- Renamed visible iTerm profiles to gtterm while preserving their identifiers and existing local storage paths.
- Kept existing local proxy preferences, personal shell settings and browser data during the in-place development update. These are not distributed.

## Earlier Terminal Pack releases

1.3 added Java/JBoss port inspection and fixed theme availability in ordinary Zsh sessions. 1.2 added global proxy/Chrome helpers. 1.1 introduced three coordinated themes. 1.0 bundled the initial shell/appearance setup.
