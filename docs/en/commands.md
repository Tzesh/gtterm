# Command reference

[Guide](guide.md) · [Troubleshooting](troubleshooting.md) · [Türkçe](../tr/commands.md)

All commands run as shell functions so proxy changes affect your current terminal. Command names, subcommands, `on/off/status` and language codes remain English in both languages. The only public entrypoint is `gtterm`; old short commands were removed in 2.1.0.

## Discover and inspect

| Command | Behavior |
|---|---|
| `gtterm`, `gtterm help`, `gtterm --help` | Show the command overview |
| `gtterm version`, `gtterm --version` | Print the packaged version |
| `gtterm status` | Show version, language, current theme selection, runtime path and HTTP/HTTPS/auto proxy status |
| `gtterm doctor` | Check required files, optional `lsof`/JDK tools and full-profile versus helper-only mode |
| `gtterm reload` | Reload helpers and saved language in this shell; enabled proxy auto-start is reapplied |
| `gtterm docs` | Read the guide in the selected language |
| `gtterm docs commands` | Read this reference |
| `gtterm docs troubleshooting` | Read the troubleshooting guide |

`doctor` is local and read-only: no network probe, server startup, process termination or configuration repair. Missing required package files return a nonzero exit status; optional tools or helper-only mode do not. It does not certify that a proxy/JBoss service is reachable.

## Language

```sh
gtterm lang
gtterm lang en
gtterm lang tr
```

No argument shows the language. `en`/`tr` saves it to `state/language` and applies it to this shell. Existing other shells can run `gtterm reload`. Invalid values are rejected without changing the preference. English is the fallback when a saved preference is invalid.

## Theme

```sh
gtterm theme mocha
gtterm theme nord
gtterm theme latte
```

Exactly one theme is required. The command changes gtterm's prompt colors, available highlighting/suggestion colors, and the iTerm palette for the current session. The theme command does not install missing plugins into an ordinary shell, change the default profile, save a theme for all future windows or change your macOS theme. The installer separately selects Nord as the saved default profile. Palette control requires iTerm; it is not forwarded through tmux/screen by this version.


## Proxy

| Command | Effect |
|---|---|
| `gtterm proxy` | Same as `gtterm proxy status` |
| `gtterm proxy on host:port` | Validate/save the endpoint, then set HTTP/HTTPS variables in this shell |
| `gtterm proxy on` | Reuse the saved endpoint; error if none exists |
| `gtterm proxy off` | Unset HTTP/HTTPS and ALL_PROXY variables in this shell; auto preference is unchanged |
| `gtterm proxy auto on` | Enable now and save automatic startup as on; requires a saved endpoint |
| `gtterm proxy auto off` | Disable now and save automatic startup as off |
| `gtterm proxy auto`, `gtterm proxy auto status` | Show startup preference |
| `gtterm proxy status` | Show HTTP, HTTPS and startup preference |

Accepted examples: `127.0.0.1:8080`, `proxy.example.test:3128`, `http://proxy.example.test:3128`, `https://proxy.example.test:443`. A scheme-less address gets `http://`. Ports must be 1–65535. Credentials, paths, SOCKS URLs and IPv6 proxy hosts are rejected.

`http_proxy`, `https_proxy`, `HTTP_PROXY` and `HTTPS_PROXY` receive the same endpoint. Local bypass values are combined with existing exclusions in `no_proxy` and `NO_PROXY`. No proxy endpoint or auto setting is configured in a fresh installation.


## Local Chrome mapping

```sh
gtterm chrome                  # jboss.local → 127.0.0.1
gtterm chrome app.local        # app.local → 127.0.0.1
```

At most one plain hostname is accepted; do not pass a URL, path or port. gtterm opens `http://<hostname>` in an isolated Chrome profile for that name, using Chrome's host-resolver rules. Chrome is looked up in `/Applications` or `~/Applications`. The hostname must contain a dot and valid hostname characters. There is no wildcard mapping.

Ports-free HTTP uses 80; use the address bar for `http://jboss.local:8080` if the server requires it. Normal Chrome history/cookies, macOS hosts/DNS and the running JBoss server are not changed. Certificate validation remains enabled. System/browser proxy policies can affect whether Chrome resolves a name locally; terminal proxy variables are a separate feature.


## Java and ports

| Command | Output |
|---|---|
| `gtterm ports` | Visible listening TCP sockets, process IDs/names, addresses and optional port hints |
| `gtterm ports 8080` | Exact numeric port only |
| `gtterm ports java` | Listeners whose process name is `java`, including custom ports |
| `gtterm ports jboss` | Common candidate ports: 8080, 8443, 9990, 9993, 8009 and 8787 |
| `gtterm java`, `gtterm java list` | `jps -l` JVM listing; Java-process fallback if JDK tools are absent |

The JBoss filter is a port filter, not positive identification of a server. Ports can be changed and offsets can apply. Standard bindings are described in the [WildFly administration guide](https://docs.wildfly.org/26/Admin_Guide.html). Port 8787 is included as a common Java debug candidate, not an assertion that debugging is enabled.

Java tools prefer `$JAVA_HOME/bin/jps`, then `jps` on PATH. gtterm excludes the listing tool itself. macOS/JVM permissions limit process visibility. JVM arguments, thread dumps, heap dumps, deployments, restarts and process termination are outside these commands.


## Exit status and state

Successful inspection/actions normally return 0. Invalid arguments, invalid proxy/host input, missing required data/files or a failed launcher return nonzero. An empty process/listener list is a valid result, not an error.

State is plain local data under `~/.config/iterm-pack/state`; it is never evaluated as shell code. Preferences affect this Mac, not other machines. To share the setup, copy the clean ZIP rather than zipping your installed directory.
