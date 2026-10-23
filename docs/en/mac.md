# Mac tools

[Commands](commands.md) · [Tools and updates](tools.md) · [Türkçe](../tr/mac.md)

These actions run only when requested. No system banner, process monitor, clipboard reader or sleep-prevention service runs at shell startup. Use a separate tab while an AI CLI owns the current input.

## Resource monitor

```sh
gtterm monitor
gtterm monitor tree
gtterm monitor basic
```

Bottom 0.14.9 shows CPU, memory, disk, network and processes. The tree view helps follow an agent and its child processes; basic fits a smaller terminal. All three modes use a two-second refresh, the bundled configuration and `--read_only`, which disables process signals/termination. Press `q` to exit; `/` searches processes. Full process arguments are not enabled by gtterm. It requires an interactive input/output terminal and never starts in a pipeline.

macOS restricts some process information without extra privileges. GPU/temperature and other users’ complete process details are not promised. No elevated access is requested. The existing `gtterm statusbar dashboard` offers smaller native CPU/RAM graphs while you work.

## System summary

```sh
gtterm sysinfo
```

Fastfetch 2.70.0 prints a compact Apple logo and OS, kernel, uptime, CPU, memory, battery and terminal details. Its bundled universal executable requires **macOS 26+**, including macOS 27. Older systems receive a requirement message; the rest of gtterm remains available. Bottom supports the pack’s macOS 11+ baseline.

`gtterm sysinfo` explicitly uses `tools/fastfetch.jsonc`. It excludes username/hostname/title, serial number, network/IP, environment and command modules. The direct `fastfetch` executable remains available and follows its own configuration; its output can differ. No summary is automatically copied or sent anywhere.

## Finder, preview and clipboard

```sh
gtterm finder                      # Reveal the current directory
gtterm finder './report.pdf'       # Reveal a file in Finder
gtterm preview './report.pdf'      # Quick Look for supported formats
gtterm copy-path                   # Copy current directory, no trailing newline
gtterm copy-path './report.pdf'    # Copy the absolute file path
printf '%s' 'text to copy' | gtterm copy
gtterm copy < './notes.txt'
```

Paths must exist; spaces, Unicode and leading hyphens are kept as path data. Symlinks resolve to their actual target. `copy` reads only the stdin you supply and rejects interactive terminal input. These commands never read your clipboard or execute copied text. Finder reveals every path with `open -R`, including application/package bundles, so selecting an app does not launch it. Quick Look/Finder may launch their native UI.

## Disk space and keeping a command awake

```sh
gtterm disk
gtterm disk '/Volumes/Work'
gtterm awake -- codex
gtterm awake -- /bin/zsh './long-task.zsh'
```

`disk` reports the filesystem containing the selected path using macOS `df -h`, not a recursive file scan. `awake` uses `caffeinate -i` only for the command’s lifetime and returns its exit status. Arguments are passed literally; no shell expression is evaluated. Launch an explicit shell script if you need shell operators. This prevents idle system sleep; it does not guarantee continued execution when closing the lid or under managed policies.

## Background naming

```sh
gtterm background list
gtterm background glass
gtterm background retrowave
gtterm background off
```

`background` controls images/transparency/blur independently of the native text/font/cursor treatments in `gtterm effect`. Existing background choices are preserved on update. See [text effects](effects.md) and [visual settings](visual.md).

## Sources and installation

Both CPU architectures, upstream digests, pinned licenses and tool minimum OS values are recorded in `TOOLS-SOURCES.json`. Installation/upgrades use the same offline `zsh install.zsh --trust-tools` command from a fresh extracted package; no sudo, Homebrew or administrator prompt. See [tool integrity and quarantine handling](tools.md).

[Bottom](https://github.com/ClementTsang/bottom/releases/tag/0.14.9) · [Bottom options](https://bottom.pages.dev/stable/configuration/command-line-options/) · [Fastfetch](https://github.com/fastfetch-cli/fastfetch/releases/tag/2.70.0). Native helpers use macOS `open`, `qlmanage`, `pbcopy`, `df` and `caffeinate`; their installed manual pages document the platform behavior.


[Native text effects and retro fonts](effects.md) are separate from background image/transparency settings.
