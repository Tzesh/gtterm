# Themes and settings

[Guide](guide.md) · [Commands](commands.md) · [Türkçe](../tr/themes.md)

40 themes and five independent prompt styles are included. Initial defaults are **Nord + rounded**, font size 15, relaxed line spacing, icons and suggestions enabled. No administrator access, Homebrew, network connection or new runtime is required.

```sh
gtterm config                      # Interactive settings menu.
gtterm config show                 # Display preferences without opening the menu.
gtterm theme list
gtterm theme kanagawa-wave          # Apply and save.
gtterm theme preview dracula        # Try in this shell without saving.
gtterm style minimal               # Apply and save independently of theme.
gtterm config set font-size 17
gtterm config set icons off
```

A saved theme is used by all new full gtterm sessions, including named iTerm profiles. Without a saved theme, the selected iTerm profile supplies its original color. Preview never changes the saved theme. Choosing a different style while previewing keeps the current preview; opening a new session uses the saved theme. An already-open shell keeps its settings until you change them or run `gtterm reload`.

## Prompt styles

| Name | Appearance |
| --- | --- |
| `rounded` | Colored capsules, rounded ends and a two-line guide |
| `minimal` | Two lines, colored text with no colored blocks |
| `powerline` | Colored blocks with angular separators |
| `compact` | One line, short prompt and fewer right-hand segments |
| `ascii` | Plain ASCII separators and prompt character; no icon font required for the prompt |

Use `gtterm style list` and Tab completion to discover styles. All styles retain the Git branch/status fallback without starting gitstatusd. `compact` always disables the extra blank line. `ascii` always hides icons regardless of the saved icons preference; changing to another style restores that preference.

## Settings

| Key | Accepted values | Default |
| --- | --- | --- |
| `theme` | Any name listed below | `nord` |
| `style` | `rounded`, `minimal`, `powerline`, `compact`, `ascii` | `rounded` |
| `font-size` | Integer 12–22 | `15` |
| `line-spacing` | `compact`, `normal`, `relaxed` | `relaxed` |
| `icons` | `on`, `off` | `on` |
| `prompt-spacing` | `comfortable`, `compact` | `comfortable` |
| `suggestions` | `on`, `off` | `on` |

Use `gtterm config set <key> <value>`. Font size and line spacing update only gtterm’s profiles; open a new gtterm tab/window to reliably apply them. Other appearance settings apply to the current shell immediately. The settings menu also includes English/Turkish language selection. `gtterm config reset` restores appearance defaults while preserving language, proxy and unrelated personal settings.

Preferences are individual validated text files under `~/.config/iterm-pack/state/`. They are preserved by `zsh install.zsh` upgrades and excluded from distributed ZIPs. Invalid stored values fall back to safe defaults and are never evaluated as shell code. `gtterm config show` reports stored preferences; `gtterm status` reports the current active theme/style.

## Theme catalog

| Command name | Profile |
| --- | --- |
| `mocha` | Mocha |
| `nord` | Nord |
| `latte` | Latte |
| `frappe` | Catppuccin Frappe |
| `macchiato` | Catppuccin Macchiato |
| `dracula` | Dracula |
| `tokyo-night` | Tokyo Night |
| `tokyo-storm` | Tokyo Night Storm |
| `gruvbox-dark` | Gruvbox Dark |
| `gruvbox-light` | Gruvbox Light |
| `rose-pine` | Rose Pine |
| `rose-pine-moon` | Rose Pine Moon |
| `rose-pine-dawn` | Rose Pine Dawn |
| `solarized-dark` | Solarized Dark |
| `solarized-light` | Solarized Light |
| `one-dark` | One Dark |
| `github-dark` | GitHub Dark |
| `monokai` | Monokai |
| `kanagawa-wave` | Kanagawa Wave |
| `kanagawa-dragon` | Kanagawa Dragon |
| `kanagawa-lotus` | Kanagawa Lotus |
| `everforest-dark` | Everforest Dark Soft |
| `everforest-light` | Everforest Light Soft |
| `nightfox` | Nightfox |
| `carbonfox` | Carbonfox |
| `dawnfox` | Dawnfox |
| `ayu-mirage` | Ayu Mirage |
| `ayu-light` | Ayu Light |
| `iceberg-dark` | Iceberg Dark |
| `iceberg-light` | Iceberg Light |
| `tokyo-day` | Tokyo Night Day |
| `github-light` | GitHub Light Default |
| `night-owl` | Night Owl |
| `poimandres` | Poimandres |
| `material-ocean` | Material Ocean |
| `oxocarbon` | Oxocarbon |
| `synthwave` | Synthwave |
| `cyberpunk` | Cyberpunk |
| `aurora` | Aurora |
| `laserwave` | Laserwave |


All palettes are bundled for offline use. Source revisions, hashes and attribution are in `THEME-SOURCES.json` and `themes/`. The browser gallery approximates the terminal; actual glyph rendering depends on iTerm and the selected font.

[Interactive offline gallery](../theme-gallery.html).


[Native text effects and retro fonts](effects.md) are separate from background image/transparency settings.
