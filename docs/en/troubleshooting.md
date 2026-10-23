# Troubleshooting

[Guide](guide.md) · [Commands](commands.md) · [Türkçe](../tr/troubleshooting.md)

## `gtterm: command not found`

The terminal may have been open before installation, or may not be Zsh. In an existing Zsh shell:

```sh
source ~/.config/iterm-pack/devtools.zsh
gtterm doctor
```

New Zsh sessions load the marked helper block in `~/.zshrc`. Bash/Fish are not supported by the loader. If the file is missing, extract a complete package and follow the installation guide; do not copy only a few shell files.

## The terminal still looks old

The old package registered full appearance only in a separate iTerm profile. gtterm now also exposes the theme command through the normal Zsh helper block. Load the helpers as above, then run `gtterm theme mocha`.

For completion menus, full prompt, spacing and fonts together, open **Profiles → gtterm - Nord**. Helpers in a normal profile do not automatically install those visual features. Run `gtterm doctor` to distinguish the two modes.

Installation now saves **gtterm - Nord** as the default. To choose a different profile later, use **Settings → Profiles → your chosen profile → Other Actions → Set as Default**. A preference written outside a running iTerm process may not take effect until iTerm is fully restarted. gtterm never closes sessions on your behalf. Existing windows retain their current shells.

## Theme changes disappear in a new window

`gtterm theme <name>` now saves the choice. `gtterm theme preview <name>` is temporary. Check `gtterm config show`, then open a new full gtterm profile. A saved theme overrides the named profile’s startup palette; otherwise the profile supplies its initial colors. Other open shells retain their own view until reloaded. macOS appearance is unchanged.

## Icons are squares or the prompt looks misaligned

Check the profile font is **MesloLGS NF** and that all four font files were installed in your user Fonts directory. Reopen the profile after font registration. A custom font, tmux/screen, changed character spacing or unsupported terminal can affect icons/layout.

## Proxy appears enabled, but traffic fails

`gtterm proxy status` reports environment settings; it does not verify that a proxy server exists or is listening. Check `gtterm ports <proxy-port>` for a local proxy. Confirm the endpoint with your workplace's configuration. gtterm does not start a proxy or manage a system VPN.

Local and `.local` destinations intentionally bypass the proxy. Programs already running elsewhere do not inherit a new shell's settings. Java tools that require JVM-specific proxy properties and Docker daemon settings may need their own configuration; gtterm does not claim to configure every application.

## Proxy returns after `gtterm proxy off`

`gtterm proxy off` affects only that shell. Run `gtterm proxy auto off` to disable it for that shell and turn off future automatic activation. Other open shells retain their environments. A child process can inherit proxies from a different already-enabled parent; inspect with `gtterm proxy status` in the actual shell you use.

## `jboss.local` opens an error page

The mapping is not a server. Check `gtterm ports java` and the port where JBoss listens. `gtterm chrome` opens HTTP on port 80. For JBoss on 8080, use `http://jboss.local:8080` in the separate browser. A port offset also changes the actual port.

Use the Chrome development window opened by gtterm; the rule does not affect normal Chrome/Safari or your system DNS. If a company-managed proxy handles the hostname remotely, its local-domain bypass settings/policies may need adjustment. An HTTPS URL still requires an appropriate valid certificate. No security-bypass flags are added.

## JVMs or listeners are missing

The commands show only what your account can inspect. JDK `jps` is preferred, and a different JAVA_HOME or JVM configuration can affect visibility. `gtterm ports java` filters the process name; `gtterm ports <number>` remains useful for nonstandard launchers. The JBoss filter can miss customized ports and can include unrelated programs using the same common ports.

An empty list is not proof that all system users have no listeners. No sudo is requested.

## `gtterm doctor` shows helper-only mode

This is expected in a normal Zsh profile. All helper commands can still work. Open a gtterm iTerm profile for the complete appearance/plugins. Missing required files are different: restore them from the same release or follow the upgrade steps.

## Language did not change in another tab

Language is stored per Mac. `gtterm lang tr` updates the current shell and future sessions. Run `gtterm reload` in another existing shell. gtterm's own messages/docs are translated; upstream plugin and OS dialogs may remain English. Command names stay English.

## Installation already exists

Older installers refused existing installations. Extract the new package into a separate folder and run its `zsh install.zsh`; it now upgrades in place with a private backup. Do not delete the existing runtime. See the [upgrade guide](guide.md).

## Where to find details

`gtterm status` shows the runtime path/version. `gtterm docs commands` lists the exact supported inputs and limits. `VERIFICATION.txt` records the release checks. Runtime state, personal settings and Chrome data should stay private and out of shared ZIPs.

## Apple could not verify `gitstatusd-darwin-arm64`

macOS can block the unnotarized gitstatusd executable in a browser-downloaded archive. Starting with 2.1.1, gtterm uses Powerlevel10k’s Zsh `vcs_info` backend and never starts gitstatusd. Git branch/status information remains available; large repositories may update more slowly. No administrator access or Gatekeeper changes are needed.

For an existing 2.1.0 installation, add `typeset -g POWERLEVEL9K_DISABLE_GITSTATUS=true` to `~/.config/iterm-pack/p10k.zsh`, then open a new gtterm session. `gtterm reload` reloads helpers only, so it does not apply this prompt change.


## Tools and workspace presets

See [tools, keyboard shortcuts, presets and the single-command update](tools.md). Use `gtterm docs tools` to read this documentation locally.


## 3.0 CLI workspace

See [Control+Esc hotkey, vivid palettes, optional effects and CLI compatibility](cli.md) and [safe reusable snippets](snippets.md). Commands: `gtterm hotkey`, `gtterm effect`, `gtterm cli`, `gtterm snippet`.


[Native text effects and retro fonts](effects.md) are separate from background image/transparency settings.

## Text remains jagged after an effect

See [normal text restoration and session font checks](effects.md#returning-to-normal-text). The 3.0.0 installer includes explicit smoothing and cursor restoration.
