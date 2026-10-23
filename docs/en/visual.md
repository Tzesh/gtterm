# Tabs, native status bar and retrowave

[CLI guide](cli.md) · [Türkçe](../tr/visual.md)

## What is enabled

The initial 3.0 package included palette tab colors but no status bar. This updated, unpublished 3.0 includes a native minimal status bar and useful tab titles by default. Existing saved preferences, theme, hotkey and iTerm default are retained.

```sh
gtterm statusbar minimal
gtterm statusbar dashboard
gtterm statusbar off
gtterm tabs smart
gtterm tabs profile
gtterm menu
```

`minimal` contains current directory, foreground job and clock. `dashboard` adds iTerm's native CPU and memory graphs. `off` hides the bar. On narrow panes, iTerm may compress or omit lower-priority items. These are local iTerm resource readings, not remote SSH server metrics, agent thinking states or account usage limits. No shell polling service is added.

`smart` uses native directory + foreground job title components; `profile` uses the profile name. Full command arguments are excluded, so long prompts are not intentionally copied into titles. The tab tint continues to follow the theme. The full gtterm shell publishes percent-encoded local directory metadata on startup/cd; it does not redraw over a running CLI or track remote SSH directories. Ordinary helper-only shells do not register this hook.

Existing sessions may have per-session settings that override the profile. Open a new gtterm window after updating. The app's tab shape/position/visibility is global: if you cannot see a single tab, check **Settings → Appearance → Tabs → Show tab bar even when there is only one tab** (the exact label can vary with iTerm version). The installer makes the single-tab bar visible once by setting iTerm's global `HideTab` preference to false. It privately backs up the prior value and restores it on uninstall if you have not changed it. This visibility preference applies to other iTerm profiles too; other global appearance settings are unchanged. Upgrades retain a later manual visibility choice.

Official references: [Status Bar](https://iterm2.com/documentation-status-bar.html), [Appearance](https://iterm2.com/documentation-preferences-appearance.html), [Profile titles](https://iterm2.com/documentation-preferences-profiles-general.html).

## Optional retrowave scene

```sh
gtterm theme synthwave
gtterm background retrowave
gtterm statusbar dashboard
```

The scene is original, static artwork: a striped sunset disc, dark horizon and perspective neon grid. It uses iTerm's background-image support with conservative blending, no shader, overlay process or flashing text. Native automatic status-bar colors are enabled in this mode. The background is independent of the palette; Synthwave is a suggested pairing, not a forced theme change. CPU/RAM graphs reflect actual activity; the wallpaper is not animated.

`gtterm background off` clears the image and returns to an opaque terminal. `glass` and `frost` also clear the image and apply their existing effects. The default stays Nord with effects off. Settings persist through upgrades; `gtterm config reset` restores minimal status bar and smart tab titles too. Native rendering and background blending vary by iTerm version; the browser gallery is an approximation. The bundled PNG and its editable SVG source are in `assets/`, with an MIT license. No graphics runtime, sudo, Homebrew or download is needed on the work Mac. See [iTerm background images](https://iterm2.com/documentation-preferences-profiles-window.html).

## Searchable command palette

`gtterm menu` uses the existing fzf to select a theme, effect, status-bar mode, tab-title style, snippet, CLI detection report or tools status. Menus use the selected English/Turkish language, while command names stay English. Esc cancels the active picker. Only explicit validated actions are dispatched; the menu never evaluates text as code and does not start an AI provider.

## More CLI ideas reviewed

The most useful later additions would be a previewed selection of files/search results for context, private project bookmarks and provider-native session continuation. These are not installed here. For current daily use, `rg`/`fd` narrow the files, `bat` previews them, `jq` filters JSON, lazygit shows the diff and the prompt snippets provide reusable review/plan/handoff requests. Avoid enabling a second history/completion framework over the existing one. Avoid global key remapping for provider-specific multiline shortcuts; use the CLI's own documented configuration when needed.

Shell Integration command marks/copy-last-output can be evaluated separately; this release only sends directory metadata and does not claim the full shell integration feature set. No environment labels, notifications, ready-made pane layouts or Java/JBoss additions are enabled.

Additional researched options (not installed): [Cmd-click file/editor navigation](https://iterm2.com/documentation-preferences-profiles-advanced.html), [inline image preview with imgcat](https://iterm2.com/documentation-utilities.html), [select/copy command output with full Shell Integration](https://iterm2.com/documentation-command-selection.html).

Run gtterm commands in Zsh, not in an AI chat input. While an agent is running, use another terminal tab for the menu/snippet copy, then paste the selected text into the agent. No provider-specific shell escape is assumed.


## Mac tools and system monitor

[Read the Mac command guide](mac.md): `gtterm monitor`, `gtterm sysinfo`, `gtterm finder`, `gtterm preview`, `gtterm copy-path`, `gtterm copy`, `gtterm disk`, `gtterm awake` and `gtterm background`.


[Native text effects and retro fonts](effects.md) are separate from background image/transparency settings.
