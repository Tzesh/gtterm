# AI CLI workspace

[Guide](guide.md) · [Snippets](snippets.md) · [Türkçe](../tr/cli.md)

## Top hotkey terminal

With iTerm2 running, press **Control+Esc** to toggle `gtterm - Hotkey`. It slides from the top, spans 100% of the screen width and uses 55% of its height. The window stays open when focus changes; press the same shortcut to hide it. A CLI running inside continues while the window is hidden. It can float above fullscreen applications and joins Spaces. It opens a normal interactive gtterm Zsh session; no agent is started automatically.

```sh
gtterm hotkey status
gtterm hotkey off
gtterm hotkey on
```

The shortcut belongs only to the hotkey profile. Regular gtterm profiles keep their normal window layout and the saved iTerm default is preserved on upgrade. The hotkey uses the saved palette when present, otherwise Nord. Native iTerm2 animation is used; no helper daemon or global keyboard monitor is installed. After updating, allow Dynamic Profiles to reload or reopen iTerm when safe. Never quit a terminal running important jobs just to refresh settings.

If the shortcut does not respond, check **Settings → Profiles → gtterm - Hotkey → Keys → Configure Hotkey Window**, verify Control+Esc, and check for a conflicting macOS/application shortcut. iTerm2 must be running. Company keyboard restrictions may apply. Configuration is verified against upstream iTerm2 profile keys; automated checks cannot prove the physical shortcut/animation on your display. Official reference: [iTerm2 hotkeys](https://iterm2.com/documentation-hotkey.html).

## Optional vivid palettes and effects

```sh
gtterm theme synthwave
gtterm theme cyberpunk
gtterm theme aurora
gtterm theme laserwave
gtterm background glass
gtterm background frost
gtterm background off
gtterm config set cursor block
```

There are 40 palettes, five prompt styles and Work/Focus/Presentation presets. The four new palettes are original gtterm designs, not upstream theme reproductions. Nord, the beam cursor and effects off remain the initial defaults. Palettes and window effects are independent and persistent. Preview a palette with `gtterm theme preview NAME` without saving it.

| Effect | Transparency | Native blur radius |
|---|---|---|
| off | 0% | disabled |
| glass | 12% | 8 |
| frost | 22% | 14 |

Only the default background uses transparency; colored panels in TUIs stay opaque. Effects use native iTerm background rendering, with no periodic shell repaint, custom shader or animation over text. Background visibility depends on what is behind the window. Font, cursor and effect settings are most reliably observed in a new gtterm window; pre-existing per-session overrides may win. Blur can increase GPU use: select `off` for maximum contrast/performance. See [iTerm2 window settings](https://iterm2.com/documentation-preferences-profiles-window.html).

## CLI compatibility

```sh
gtterm cli
gtterm snippet copy review
```

`gtterm cli` checks only PATH for `agent`, `cursor-agent`, `codex`, `copilot` and `claude`. It never launches them, checks accounts, sends prompts or probes a network. These AI CLIs are separate applications; their installation, authentication, subscriptions and organization policies are not changed by gtterm. A found executable is not proof of a valid account or working installation.

The pack does not replace Enter, Esc, Shift+Enter, mouse handling, bracketed paste or alternate-screen behavior. Zsh fzf bindings act at the shell prompt; foreground CLI applications handle their own keys. Control+Esc is the requested global hotkey and hides/shows the window even while an agent runs. Existing iTerm key settings inherited from your own default profile may still affect applications.

Actual bundled lazygit and a local full-screen terminal harness are checked. Live authenticated Cursor/Codex/Copilot/Claude sessions are not run or certified. If an agent's shell output is noisy, `gtterm style minimal` or `gtterm style ascii` and `gtterm background off` are useful options; agent child shells may use their own environment.

## Useful CLI habits and optional next steps

- Copy one of the review, plan, debug, explain, verify or handoff snippets; paste it into the active agent input and review before submitting. Command snippets are copied as text too.
- Keep concise project instructions in the project's own rules files. gtterm does not create or overwrite `AGENTS.md`, `CLAUDE.md` or `.cursor/rules`.
- Use the CLI's own session history/resume feature instead of a second gtterm session database. Codex documents `codex resume`; see [official OpenAI documentation](https://developers.openai.com/codex/cli/features).
- Check multiline input inside the CLI before changing global keys. Current Claude Code docs describe Ctrl+J as a universal newline option and native Shift+Enter in iTerm2; Copilot exposes `/terminal-setup` where needed. Behavior depends on installed versions: [Claude terminal settings](https://code.claude.com/docs/en/terminal-config), [Copilot command reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-command-reference).
- Cursor's current CLI supports project rules and planning: [Cursor CLI](https://cursor.com/docs/cli/using). Keep provider-specific setup with that provider.

Possible later additions: selected-file/context bundles with a preview and size limit, user-owned project bookmarks, and a command palette. These are recommendations, not features installed in 3.0. No automatic transcript export, clipboard history capture, notifications, environment labels, saved pane layouts or new Java/JBoss helpers are included.


[Native status bar, tab titles, retrowave and command palette](visual.md).


[Native text effects and retro fonts](effects.md) are separate from background image/transparency settings.
