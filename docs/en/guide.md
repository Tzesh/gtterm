# gtterm guide

[README](../../README.md) · [Commands](commands.md) · [Troubleshooting](troubleshooting.md) · [Türkçe](../tr/guide.md)

## What gtterm includes

The full iTerm profiles combine Oh My Zsh, Powerlevel10k, MesloLGS NF, zsh-autosuggestions, zsh-autocomplete, zasync and syntax highlighting. The collection includes 40 profiles, including **gtterm - Mocha** (dark pastel), **gtterm - Nord** (cool gray/blue) and **gtterm - Latte** (light). Colors, suggestions and prompt segments follow the same palette. Previous prompts collapse to leave more room for output.

The helper commands are also available in ordinary Zsh sessions. Helpers alone do not load the full prompt/plugins into those sessions. `gtterm doctor` reports which mode you are using.

## Installation

Extract the ZIP. Run `zsh /path/to/gtterm/install.zsh`, or type `zsh ` and drag the actual installer file into Terminal. `/path/to` is a placeholder, not a literal directory.

Use `zsh /path/to/gtterm/install.zsh --lang tr` for Turkish setup. The default is English. The installer checks for macOS/Zsh, copies the bundled files, adds missing user fonts and registers 40 theme profiles plus a dedicated hotkey profile. It backs up an existing `.zshrc` in the installation directory and appends a marked helper block without replacing your lines.

The installer saves **gtterm - Nord** as the default iTerm profile and stores the previous default for removal. Open **iTerm → Profiles → gtterm - Nord** immediately, or reopen iTerm when safe for the saved default to take effect. Changing the default does not convert existing sessions. gtterm does not close/restart iTerm or interrupt your running jobs.

A new ordinary Zsh terminal loads the helper block. To load helpers in an already-open shell:

```sh
source ~/.config/iterm-pack/devtools.zsh
```

## Language

```sh
gtterm lang        # Show the current choice.
gtterm lang tr     # Turkish messages and docs.
gtterm lang en     # English messages and docs.
```

The preference is saved per Mac in `state/language`. It changes the current shell and future sessions. Other already-open shells use `gtterm reload` to pick it up. The supported language values are only `en` and `tr`; an invalid saved value falls back to English. Upstream plugin dialogs and operating-system messages are not translated by gtterm.

## A typical Java/JBoss session

```sh
gtterm doctor
gtterm java
gtterm ports java
gtterm ports 8080
gtterm chrome
```

`gtterm java` shows JVM identifiers and main class/JAR names through JDK `jps -l`. It does not request JVM arguments or environment variables. If JDK tools are missing, it falls back to Java process names. `gtterm ports` lists visible listening TCP sockets, process IDs and process names. Neither command kills processes or changes the server.

The JBoss filter checks common ports, not server identity. A proxy might also use 8080. Custom ports/port offsets require `gtterm ports java` or a specific number. Access to other users' processes is limited by macOS permissions.

`gtterm chrome` opens `http://jboss.local` and maps that hostname to 127.0.0.1 in a separate Chrome development profile. There is no hosts-file change. HTTP without an explicit port uses 80. If JBoss listens on 8080, enter `http://jboss.local:8080` in that browser or use a service forwarding port 80. gtterm does not create that forwarding service.

## Proxy workflow

```sh
gtterm proxy on 127.0.0.1:8080   # Example: use your actual HTTP proxy.
gtterm proxy auto on            # Also enable on future shell startup.
gtterm proxy status
gtterm proxy off                # Only this shell; auto preference stays unchanged.
gtterm proxy auto off           # Disable in this shell and stop auto-start.
```

Both HTTP and HTTPS requests use the chosen HTTP proxy endpoint. gtterm sets lowercase/uppercase environment variables for compatible command-line clients. It does not start a proxy server, configure the macOS network service or reconfigure applications already running elsewhere. Browser/system proxy rules are separate.

Localhost, 127.0.0.1, ::1 and `.local` names are added to `no_proxy`/`NO_PROXY`, preserving existing exclusions. Turning off clears HTTP/HTTPS proxy variables and inherited `ALL_PROXY`/`all_proxy`; bypass exclusions remain. Other open shells retain their own environments. A child launched from another proxy-enabled process can inherit its environment even when automatic startup is disabled.

Credentials, SOCKS URLs and IPv6 proxy hosts are not supported by this version's endpoint validator. Use a hostname or IPv4 address with a port. Saved endpoints/preferences never enter the distributable ZIP.

## Keyboard and appearance

- Type at least two characters for the completion list; Tab completes, Down selects.
- Right arrow at end of line accepts the faded history suggestion; Option+F accepts/moves a word.
- Ctrl+R searches history.
- Cmd+D / Cmd+Shift+D split the iTerm pane vertically/horizontally.
- Cmd+Option+arrow moves between panes; Cmd+Shift+Enter zooms/restores the current pane.
- `gtterm theme <name>` saves the theme for this and future gtterm sessions. `gtterm theme preview <name>` changes only this session.

Edit `p10k.zsh` in the installation folder for prompt segments, or edit the dynamic profile JSON for profile appearance. Avoid `p10k configure` here: its wizard may write to your normal default dotfiles rather than the package's prompt file.

## Personal settings and storage

The full profile uses its own `.zshrc`. Your `~/.zprofile` is loaded, while your normal `~/.zshrc` is not sourced a second time. Put machine-specific PATH, JAVA_HOME and aliases in `~/.config/iterm-pack/local.zsh`. Do not load Oh My Zsh, a second completion initializer or another theme from that file.

| Location | Contents |
|---|---|
| `~/.config/iterm-pack/` | gtterm runtime; legacy path retained for compatibility |
| `state/language`, `state/proxy-url`, `state/proxy-auto` | Local plain-data preferences |
| `local.zsh` | Optional personal shell settings |
| `~/Library/Application Support/iTerm2/DynamicProfiles/terminal-pack.json` | gtterm profiles; stable GUIDs |
| `~/Library/Application Support/Terminal Pack/Chrome/<hostname>` | Separate Chrome history/cookies for each mapped hostname |
| `~/.zsh_history` | This Mac's existing shell history |

## Moving to a work Mac

Copy the clean ZIP and install there. It contains both CPU architectures' gitstatus binaries and the fonts/plugins/docs. It contains none of your local proxy values, history, personal settings, passwords, original `.zshrc` backups or Chrome data. Set the workplace's proxy endpoint and optional language there. Corporate restrictions on launching Chrome with flags may still apply.

## Upgrading or restoring an existing installation

Extract the new ZIP into a separate folder and run the same command for installation and updates:

```sh
zsh install.zsh
```

An existing installation is detected and upgraded automatically. Do not uninstall first. `state/` (language, proxy and original default-profile record), `local.zsh`, `custom/`, the original shell snapshot, installed-font records, the current `.zshrc` and your selected iTerm default are preserved. Use `--lang en` or `--lang tr` only if you want to change the saved language.

New files are staged before switching. A private backup under `~/.config/iterm-pack-backups/` keeps the previous runtime and dynamic profile; its exact path is printed on completion. Backups contain personal settings: do not share them. A failed runtime/profile switch restores the previous installation automatically. Successful backups remain until you remove them yourself; uninstall leaves them in place.

Open a new gtterm profile, then run `gtterm version` and `gtterm doctor`. Existing sessions keep already-loaded code until a new session opens. Do not run simultaneous updates. Bundled program files and gtterm profile appearance are replaced; keep machine-specific customization in `local.zsh`.

For manual rollback after success, exit gtterm sessions, move the new runtime somewhere safe, restore the backup’s `runtime` to `~/.config/iterm-pack`, and restore its `dynamic-profile.json` to `~/Library/Application Support/iTerm2/DynamicProfiles/terminal-pack.json` if present. The update does not change the shell hook or default-profile preference.

## Removal

From an ordinary terminal outside the gtterm profile:

```sh
zsh ~/.config/iterm-pack/uninstall.zsh
```

The uninstaller removes the gtterm dynamic profiles, the marked helper block and the installed runtime. It preserves other `.zshrc` lines, shared Meslo fonts and Chrome development data. If this Mac has a saved previous default profile and the current default is still gtterm, it restores that saved preference. Existing shells retain already-loaded functions until they close. Local preferences inside the installation folder are deleted, so back them up first if needed.


[All 40 themes and examples](themes.md).


## Tools and workspace presets

See [tools, keyboard shortcuts, presets and the single-command update](tools.md). Use `gtterm docs tools` to read this documentation locally.


## 3.0 CLI workspace

See [Control+Esc hotkey, vivid palettes, optional effects and CLI compatibility](cli.md) and [safe reusable snippets](snippets.md). Commands: `gtterm hotkey`, `gtterm effect`, `gtterm cli`, `gtterm snippet`.


[Native status bar, tab titles, retrowave and command palette](visual.md).


## Mac tools and system monitor

[Read the Mac command guide](mac.md): `gtterm monitor`, `gtterm sysinfo`, `gtterm finder`, `gtterm preview`, `gtterm copy-path`, `gtterm copy`, `gtterm disk`, `gtterm awake` and `gtterm background`.


[Native text effects and retro fonts](effects.md) are separate from background image/transparency settings.
