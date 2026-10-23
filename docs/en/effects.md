# Native text effects and retro fonts

[Commands](commands.md) · [Background/tabs/status](visual.md) · [Türkçe](../tr/effects.md)

`gtterm effect` changes native text typography, colors and cursor behavior. `gtterm background` independently retains off/glass/frost/retrowave images/transparency/blur. Both are saved; initial defaults remain Nord, background off, effect off. 

```sh
gtterm effect list
gtterm effect retro
gtterm effect fallout
gtterm effect amber
gtterm effect typewriter
gtterm effect neon
gtterm effect status
gtterm effect off
```

| Treatment | Font and colors | Native cursor |
|---|---|---|
| off | Selected theme and normal Meslo font | Your saved cursor shape |
| retro | VT323 pixel-style ASCII font, selected theme colors | Steady block |
| fallout | VT323, green text on dark green | Blinking block, movement animation |
| amber | VT323, amber text on near-black | Blinking block, movement animation |
| typewriter | Courier, warm sepia text and dark brown | Steady block |
| neon | Bold Meslo, pale cyan text and magenta cursor | Blinking block, movement animation |

Before changing an effect, gtterm asks iTerm to reapply the exact current gtterm profile, clearing session-local font/zoom overrides. The subsequent shared-profile update can then change the font in the current tab; new tabs inherit the updated profile. The default profile is not changed. A local interactive iTerm gtterm session is required for this live request; redirected output, SSH, tmux, screen and other terminals receive no profile-switch escape sequence. Profiles for all themes and the hotkey receive the treatment. Turning it off restores each theme’s base colors/font properties and your saved font size, spacing and cursor shape. It does not change your selected theme or background mode. Profile appearance changes made manually outside gtterm may be replaced for the fields managed by these treatments.

```sh
gtterm background glass
gtterm effect fallout
gtterm config set font-size 18
# If iTerm asks to allow profile changes, allow it and run gtterm effect apply.
gtterm effect off                  # Glass remains enabled
gtterm background off              # Independent control
```

The menu exposes separate text-effect/background entries. Settings menu: `e` chooses text treatment, `g` chooses background. `gtterm config set effect amber` and `gtterm config set background frost` are separate preferences; `config reset` resets both.

## CLI compatibility and limits

These are **native iTerm2 treatments, not CRT shaders**. iTerm2 3.6.10 has no supported custom CRT bloom, scanline shader, screen curvature or 3D renderer hook. `gtterm effect crt`, `bloom`, `scanlines` and `3d` explain this limitation without changing settings. No alternative terminal is installed. No fullscreen flashing, periodic OSC/color loops, scripts drawing over the CLI or key remapping are added.

Retro modes use bundled VT323 for ASCII and same-size Meslo for non-ASCII/Unicode/Nerd glyphs, with native Powerline glyph rendering. They do not change Unicode width tables or keyboard/paste protocols. Effect colors alter default text/background/cursor/selection/tab colors; the theme’s sixteen ANSI colors are retained to keep error/warning/diff color distinctions. Applications using explicit truecolor styles can retain their own colors; an effect cannot guarantee monochrome output for every CLI. Dense Unicode interfaces should be checked in your preferred font; `off` restores the normal typography.

While a treatment is active it uses a block cursor; your normal cursor setting stays saved and returns with `effect off`. Native movement animation is cursor stretching, not text glow or phosphor trails. Use `retro` or `typewriter` for a steady cursor, or turn effects off. These modes can be combined with any background; scanline imagery is not added.

## Upgrade and font licensing

The old `state/effect` file meant background; it is retained unchanged as a fallback when there is no explicit new background preference. New background settings use `state/background`; native text treatments use `state/visual-effect`. No old file is sourced as code or destructively rewritten. Repeated upgrades/reloads preserve both preferences. Older open shells should run `gtterm reload` before using the changed commands.

VT323 is bundled under the SIL Open Font License in `fonts/VT323-OFL.txt`. Its pinned upstream source and SHA256 are recorded in `FONT-SOURCES.json`; the normal offline installer copies it only into your user Fonts folder. No sudo, Homebrew or installer-time download. Existing Meslo fonts and font sizes are retained. Courier is provided by macOS.

[VT323 upstream](https://github.com/google/fonts/tree/2da41909d08a7bfeab32cfc163edb7be0c34395d/ofl/vt323) · [iTerm text preferences](https://iterm2.com/documentation-preferences-profiles-text.html) · [iTerm3.6.10 profile keys](https://github.com/gnachman/iTerm2/blob/v3.6.10/sources/ITAddressBookMgr.h).

[Typography preview gallery](../effect-gallery.html) uses the actual bundled fonts; browser rendering can differ from iTerm.

## Font does not change

Fallout and amber deliberately share **VT323**; their colors differ, not their font family. Off restores **MesloLGS NF Regular**; typewriter uses **Courier**, neon **MesloLGS NF Bold**.

iTerm can preserve a local font/zoom override and pass it to new tabs, even when the Dynamic Profiles file has the correct font. Effect changes, font-size/cursor settings, presets and reset now request a native reattachment **before** rewriting profiles, so old overrides do not win over the new shared font. Existing unrelated tabs are left alone. This reapplies the current gtterm profile’s settings and clears that tab’s session-local overrides; it does not switch the default or convert a non-gtterm profile.

```sh
gtterm reload
gtterm effect off
gtterm effect fallout
gtterm effect amber     # Same VT323 family; amber colors
gtterm effect apply     # Reapply current profile without changing selection
```

On first use iTerm may ask whether control sequences may change profiles. If you choose Allow, run `gtterm effect apply` once afterward; the first rejected request is not replayed automatically. gtterm does not alter that permission or request administrator access, Automation, AppleScript or Python API access. If blocked by iTerm policy, manually select the gtterm profile from iTerm’s Profiles menu. Changing a newly generated file alone is not proof of actual session rendering.

## Returning to normal text

`gtterm effect off` explicitly restores Meslo Regular, ASCII/non-ASCII anti-aliasing, the normal theme palette/selection/tab colors, Retina-only thin strokes, normal Powerline glyph behavior, and no cursor blink or movement animation. Your saved cursor shape, font size and line spacing are reapplied. The chosen background remains independent; use `gtterm background off` separately if desired. Effects do not modify the sixteen ANSI colors or keyboard protocols.

If the font is Meslo but text still looks jagged, check **Cmd+I → Text → Anti-aliased** in the actual session, rather than only global Settings. After updating, run `gtterm reload; gtterm effect off; gtterm effect apply`. iTerm may require its existing profile-switch consent; gtterm never changes that policy.
