# Changelog

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
