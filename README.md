# gtterm

A portable iTerm2 + Zsh workspace for macOS: 40 coordinated themes, five prompt styles, native retro text effects and nine bundled command-line tools. No sudo or Homebrew required.

English is the default. Use `gtterm lang tr` for Turkish; command names stay in English.

## Install or update

Install iTerm2 separately if needed; gtterm includes Oh My Zsh, Powerlevel10k, completion/suggestion plugins, fonts and tools, but does not install the iTerm2 application.

Download and extract **gtterm-macos.zip** from [Releases](https://github.com/Tzesh/gtterm/releases/latest). From the extracted `gtterm` folder, use the same command for a first install or an update:

```sh
zsh install.zsh --trust-tools
```

Add `--lang tr` for Turkish setup. Installation makes no downloads and requests no administrator password. `--trust-tools` verifies the bundled SHA256 manifest and removes quarantine only from the bundled launchers and the current CPU's tool executables. It does not change Gatekeeper or bypass company policies. Omit the flag to preserve quarantine; blocked tool integrations remain disabled. See [tools and updates](docs/en/tools.md).

Open **iTerm → Profiles → gtterm - Nord**, then run:

```sh
gtterm doctor
gtterm tools verify
gtterm help
```

A first install selects Nord as the saved iTerm default. Updates preserve your selected default, saved settings, proxy, language, history, `local.zsh` and directory database, with a private rollback backup. Your existing `.zshrc` lines are preserved; gtterm adds a marked helper block. Do not uninstall before updating. After an update, open a new gtterm tab to load the full workspace; `gtterm reload` refreshes helpers in an existing shell.

## Appearance

```sh
gtterm config                       # Settings menu
gtterm theme tokyo-night
gtterm style rounded
gtterm preset work                  # Also focus or presentation
gtterm effect fallout               # Also retro, amber, typewriter or neon
gtterm effect off                   # Restore normal text rendering
gtterm background retrowave         # Independent of text effects
gtterm statusbar dashboard
gtterm tabs smart
gtterm hotkey on                    # Control+Esc: top dropdown terminal
```

Nord, rounded prompt, normal Meslo typography and no background/text effect are the initial defaults. Appearance choices persist across updates. `effect off` restores theme colors, Meslo, text smoothing and the saved cursor shape/size/spacing; it leaves your background selection intact. Fallout and amber share VT323 and differ in color. These are native iTerm font/color/cursor treatments; CRT bloom, screen curvature and 3D shaders are not included. See [effects](docs/en/effects.md).

## Everyday tools

Bundled for Apple Silicon and Intel: **fzf, zoxide, rg, fd, bat, lazygit, jq, bottom and Fastfetch**.

```sh
gtterm jump backend                 # Jump to a previously visited directory
gtterm monitor tree                 # Read-only CPU/RAM/process monitor
gtterm sysinfo                      # Compact system summary; macOS 26+
gtterm snippet pick                 # Reusable command/prompt snippets
gtterm cli                          # Detect installed AI CLIs
gtterm finder                       # Reveal current directory
gtterm copy-path
gtterm proxy on 127.0.0.1:8080       # Example; supply your own proxy
gtterm proxy auto on
gtterm chrome                       # jboss.local -> 127.0.0.1, HTTP port 80
```

Ctrl+R searches history; Ctrl+T finds files with previews; Option+C selects a directory when Option sends Esc+. Normal Tab completion and inline suggestions remain available. AI readiness checks do not install or authenticate Cursor, Codex, Copilot or Claude Code. Use a separate tab for helpers while an interactive CLI owns the input.

## Documentation

| English | Türkçe |
|---|---|
| [Setup and daily workflow](docs/en/guide.md) | [Kurulum ve günlük kullanım](docs/tr/guide.md) |
| [Commands](docs/en/commands.md) | [Komutlar](docs/tr/commands.md) |
| [Themes and settings](docs/en/themes.md) | [Temalar ve ayarlar](docs/tr/themes.md) |
| [Text effects](docs/en/effects.md) | [Yazı efektleri](docs/tr/effects.md) |
| [Background, tabs and status](docs/en/visual.md) | [Arka plan, sekmeler ve durum](docs/tr/visual.md) |
| [Tools and updates](docs/en/tools.md) | [Araçlar ve güncelleme](docs/tr/tools.md) |
| [Mac helpers](docs/en/mac.md) | [Mac yardımcıları](docs/tr/mac.md) |
| [Troubleshooting](docs/en/troubleshooting.md) | [Sorun giderme](docs/tr/troubleshooting.md) |

Use `gtterm docs <topic>` inside the terminal; **q** closes the pager. [Theme gallery](docs/theme-gallery.html) · [Effect gallery](docs/effect-gallery.html).

## Compatibility and portability

- macOS with Zsh 5.8+ and iTerm2 for the full workspace. Tool minimums vary: base tools/bottom macOS 11+, lazygit 12+, jq 14+, Fastfetch 26+. macOS 26/27 meet these requirements.
- Apple Silicon tools have been exercised locally; Intel binaries are bundled and inspected, without an Intel runtime test.
- Runtime stays at `~/.config/iterm-pack` for upgrades; existing profile identifiers and `terminal-pack.json` are retained.
- Private settings, proxy endpoints, history, local overrides, backups and Chrome data are excluded from release assets.
- Pinned upstream sources and licenses are included in the `*-SOURCES.json` manifests and component folders. Automatic Oh My Zsh updates are disabled. Git status uses Zsh's backend without starting gitstatusd.

See [CHANGELOG.md](CHANGELOG.md) and [VERIFICATION.txt](VERIFICATION.txt).
