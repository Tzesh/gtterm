# gtterm

A portable iTerm2 + Zsh workspace for macOS, with a Powerlevel10k prompt, three coordinated themes, inline suggestions, completion menus, proxy controls and Java/JBoss tools. No sudo or Homebrew required.

**English is the default.** Run `gtterm lang tr` for Turkish; command names stay in English. Only `gtterm` is exposed; the former short commands have been removed.

## Start

1. Extract `gtterm-macos.zip`.
2. In Terminal, type `zsh `, drag `install.zsh` into the window, then press Enter. For Turkish installation messages, add ` --lang tr` before pressing Enter.
3. Nord is selected as the default iTerm profile. Open **iTerm → Profiles → gtterm - Nord** immediately, or reopen iTerm when safe. Mocha and Latte are also available.
4. Run:

```sh
gtterm doctor
gtterm help
gtterm docs
```

The installer preserves your existing `.zshrc` lines, adds a marked helper block and sets **gtterm - Nord** as the saved default iTerm profile. The previous default is saved for removal. Running iTerm sessions are not restarted; reopen iTerm when safe if it still uses its cached old default.

## Everyday commands

```sh
gtterm theme mocha
gtterm proxy on 127.0.0.1:8080   # Replace with your proxy address.
gtterm proxy auto on
gtterm ports 8080
gtterm ports java
gtterm java
gtterm chrome                   # Opens http://jboss.local mapped to 127.0.0.1.
gtterm lang tr                  # Optional; gtterm lang en switches back.
```

The proxy endpoint above is an example. Ports are read-only diagnostics. Chrome does not start JBoss; a ports-free HTTP URL requires a server on port 80.

## Documentation

| English | Türkçe |
|---|---|
| [Setup and daily workflow](docs/en/guide.md) | [Kurulum ve günlük kullanım](docs/tr/guide.md) |
| [Complete command reference](docs/en/commands.md) | [Tüm komutlar](docs/tr/commands.md) |
| [Troubleshooting](docs/en/troubleshooting.md) | [Sorun giderme](docs/tr/troubleshooting.md) |

Run `gtterm docs guide`, `gtterm docs commands` or `gtterm docs troubleshooting` to read these inside your terminal. Press **q** to close the pager.

## Compatibility and portability

- macOS with Zsh 5.8+; iTerm2 for the full appearance. Existing helpers also load in normal Zsh terminals.
- Intel and Apple Silicon gitstatus binaries are bundled. This package has been exercised on Apple Silicon; an Intel machine has not been tested.
- No downloads during installation/startup. JDK and Chrome are optional, already-installed applications used by the corresponding helpers.
- Installation remains at `~/.config/iterm-pack` to preserve existing gtterm/Terminal Pack setups and open shells. Existing profile GUIDs and the `terminal-pack.json` filename are retained.
- Local proxy settings, language preference, history, `local.zsh`, original shell backups and Chrome profile data are excluded from the portable ZIP.
- Bundled upstream versions are pinned in `SOURCES.json`, `THEME-SOURCES.json`, `FONT-SOURCES.json` and `GITSTATUS-SOURCES.json`. Each component retains its license. Automatic Oh My Zsh updates are disabled for the offline bundle.

See [CHANGELOG.md](CHANGELOG.md) and [VERIFICATION.txt](VERIFICATION.txt) for this release.
