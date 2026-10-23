# Tools and workspace presets

[Guide](guide.md) · [Commands](commands.md) · [Türkçe](../tr/tools.md)

## Installation and updates

Extract the new clean ZIP into a separate folder. From its `gtterm` folder, use the same command for a fresh install or an existing installation:

```sh
zsh install.zsh --trust-tools
```

No sudo, Homebrew, package manager, administrator password or installer-time download is used. Both Apple Silicon and Intel executables are bundled; the running architecture is selected automatically. The original five tools require macOS 11+. New upstream lazygit binaries require macOS 12+, jq binaries macOS 14+, current Fastfetch macOS 26+. Bottom supports macOS 11+. On older systems those specific tools report an OS requirement without execution; other features remain available. Only system libraries are used. Existing iTerm, Zsh and Java requirements are unchanged; this does not install a JDK or iTerm itself.

`--trust-tools` is explicit permission to remove the macOS quarantine attribute from only the nine bundled command launchers and the nine selected-architecture executables, after verifying the complete bundled SHA256 manifest. Use it only with a package you trust. It does not change Gatekeeper settings, other files or organization policies. Checksums detect damage; they are not a publisher signature. Upstream release sources, versions, hashes and licenses are recorded in `TOOLS-SOURCES.json` and `tools/licenses/`.

Without the flag, installation preserves quarantine. A blocked tool is reported by `gtterm tools`; shell startup skips its integrations without launching it. Re-run the same installer with the flag to activate verified tools. Company-managed restrictions may still prevent execution; gtterm does not override them. The previous gitstatusd workaround stays enabled.

Updates preserve saved appearance, language, proxy, `local.zsh`, history, selected iTerm default and the zoxide database. They keep a private runtime backup. Do not uninstall first. Reopen a gtterm tab after upgrading to load the new integrations. This is a local package update, not a command that fetches a newer GitHub release.

## Included tools

| Command | Pinned version | Example |
|---|---|---|
| `fzf` | 0.64.0 | `printf 'dev\nstaging\n' | fzf` |
| `zoxide` | 0.10.0 | `gtterm jump backend` |
| `rg` | 15.2.0 | `rg -n 'class .*Service' src` |
| `fd` | 10.5.0 | `fd '\.java$' src` |
| `bat` | 0.26.1 | `bat --paging=never pom.xml` |
| `lazygit` | 0.66.2 | `lazygit` |
| `jq` | 1.8.2 | `jq . file.json` |
| `btm` | 0.14.9 | `gtterm monitor tree` |
| `fastfetch` | 2.70.0 | `gtterm sysinfo` |

These standard executable names are available alongside `gtterm`; no old gtterm shortcut aliases are reintroduced. The package directory is placed before existing versions on PATH in gtterm-enabled shells. Other sessions are unaffected. User overrides can be placed in `local.zsh`.

`rg` and `fd` normally respect ignore files and skip hidden entries. Use their own `--help` for options. `bat` uses ANSI colors so its syntax output follows the active terminal palette. fzf colors follow theme changes; existing user fzf options are retained before gtterm's layout/color options. CPU binaries are bundled rather than compiled on the work Mac.

## Keyboard shortcuts

Full gtterm profiles load the following fzf bindings:

| Shortcut | Action |
|---|---|
| Ctrl+R | Search shell history; Enter inserts the selection, then Enter executes it |
| Ctrl+T | Find a file/directory and insert its safely quoted path; bat previews files |
| Option+C / Alt+C | Select a directory and enter it |
| Esc | Cancel the picker |

Tab remains with the existing Zsh completion system. Option+C requires iTerm's Option key to send Esc+ (configure it in the profile's Keys settings if needed). Normal helper-only shells expose the tool commands without changing keyboard bindings. History/file searches stay local; shell history can contain sensitive values.

## Directory jumping

```sh
gtterm jump                 # Home directory
gtterm jump backend         # Best matching previously visited directory
gtterm jump -i              # Choose interactively with fzf
gtterm jump './folder with spaces'
```

Full gtterm sessions track directory visits through zoxide. Its database stays at `~/.config/iterm-pack/state/zoxide`, is preserved by upgrades and is excluded from the distributable ZIP. New database directories are created privately. No `z` or `zi` aliases are added. If there is no matching visited directory, zoxide reports that rather than guessing. `gtterm tools` shows availability/version; `gtterm tools verify` verifies the installed tool manifest without executing the tools.

## Work, Focus and Presentation

```sh
gtterm preset list
gtterm preset work
gtterm preset focus
gtterm preset presentation
gtterm config
```

| Preset | Prompt | Font | Lines | Icons | Prompt spacing | Suggestions |
|---|---|---|---|---|---|---|
| Work | rounded | 15 | relaxed | on | comfortable | on |
| Focus | minimal | 14 | compact | off | compact | on |
| Presentation | minimal | 20 | relaxed | off | comfortable | off |

Presets save these six existing settings together. They preserve your palette, language, proxy and default iTerm profile. Nord stays the initial default. Prompt changes apply immediately in full profiles; font and line spacing apply in new gtterm tabs. Other open shells can reload saved settings. The settings menu exposes presets under `p`. You can customize any setting afterward; `gtterm config show` displays the actual values. Presentation hides suggestions, but does not hide command history, output or credentials from screen sharing.


## 3.0 CLI workspace

See [Control+Esc hotkey, vivid palettes, optional effects and CLI compatibility](cli.md) and [safe reusable snippets](snippets.md). Commands: `gtterm hotkey`, `gtterm effect`, `gtterm cli`, `gtterm snippet`.

| Additional tool | Pinned version |
|---|---|
| `lazygit` | 0.66.2 |
| `jq` | 1.8.2 |

`lazygit` uses your existing Git installation; gtterm does not install Git or Command Line Tools. `jq` formats/queries JSON. Both ship with CPU binaries, licenses and SHA256 entries.

The bundled lazygit default config disables automatic fetch and update checks. Manual fetch/push actions still work when you select them. Set your own `LG_CONFIG_FILE` to override the defaults. No global Git settings are changed.


## Mac tools and system monitor

[Read the Mac command guide](mac.md): `gtterm monitor`, `gtterm sysinfo`, `gtterm finder`, `gtterm preview`, `gtterm copy-path`, `gtterm copy`, `gtterm disk`, `gtterm awake` and `gtterm background`.


[Native text effects and retro fonts](effects.md) are separate from background image/transparency settings.

## User-installed CLI tools

Starting with 3.0.1, `~/.local/bin` is added automatically in full gtterm profiles and helper-enabled Zsh shells. If already on PATH, its position is preserved; otherwise it is appended. gtterm’s bundled tools keep their existing precedence. No directory is created and no CLI is installed or executed. New tools placed there can be found without another PATH edit.

After updating, open a new gtterm tab or run `gtterm reload`, then `command -v agent`. Both the release ZIP and GitHub Source code ZIP contain the full installer. Do not source your unrelated `~/.zshrc` to refresh PATH inside the isolated gtterm profile: it may load a different Powerlevel10k configuration. Existing personal PATH lines in `local.zsh` remain supported.
