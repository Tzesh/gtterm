# Snippets

[CLI workspace](cli.md) · [Türkçe](../tr/snippets.md)

`gtterm snippet list` lists names. `show NAME` prints a snippet, `copy NAME` copies exact plaintext to the local macOS clipboard, and `pick` uses fzf to choose and copy. No snippet is evaluated or executed. Existing clipboard content is replaced when you choose copy/pick. Paste into the intended agent/editor and review it; pasting command snippets into a shell can run commands when Enter is pressed.

Built-in names: `review`, `plan`, `debug`, `explain`, `verify`, `handoff`, `git-status`, `git-diff`. Prompt text follows `gtterm lang en|tr`; command names stay English. These are plain prompts, not provider slash commands.

For a personal snippet, save a regular UTF-8 file at `~/.config/iterm-pack/state/snippets/NAME.txt`. Create the directory privately (`mkdir -m 700 -p ~/.config/iterm-pack/state/snippets`). Names are 1–48 lowercase letters/digits/underscore/hyphen, starting with a letter or digit. Files are limited to 32 KiB. Symbolic links are rejected. A personal file with the same name overrides the bundled snippet in either language. Personal snippets survive upgrades and stay out of the clean ZIP. Never store tokens/passwords in shared snippets.

Examples:

```sh
gtterm snippet show review
gtterm snippet copy handoff
gtterm snippet pick
```


[Native text effects and retro fonts](effects.md) are separate from background image/transparency settings.
