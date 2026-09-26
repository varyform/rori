# Changelog

Notable changes to rori, newest first. Each entry names who it's for:
**Users** (people working in the desk) and **Developers** (apps building on
it). History before the gem got its own repository lives in
[rori-demo's changelog](https://github.com/varyform/rori-demo/blob/main/CHANGELOG.md).

## Unreleased (0.1.0)

The first release.

### The desk
- **Users:** every page opens as a window in endlessly scrolling column strips, one strip per workspace, stacked vertically: keyboard focus and moves, column widths, stacking, full width, centring, an overview and a column minimap. The layout survives a reload.
- **Users:** ⌘K palette and a drop-down terminal (`` ` ``) over one command tree — pages, recent records, desk actions, UI settings — with fuzzy matching across nested lists (`uthen` → UI › Theme › Nord), frecency, shortcuts shown next to commands, Tab completion and history in the terminal.
- **Users:** Blender-style hover keys (opt-in): bare keys act on the window under the pointer while the cursor stays in your field — `W` close, `U` reopen, `R` width, `F` full, `C` centre, `[` `]` stack, `1–9` switch workspace, `⇧1–9` move the column there and follow it.
- **Users:** a keyboard shortcuts modal (`⌥?`) generated from the live keymap; closed windows reopen where they were (`⌥⇧T`); unsaved forms ask before closing.
- **Users:** 14 bundled Ghostty colour themes with live preview; optional Unsplash wallpapers (safe / cover menu bar / off, next, pin); the menu bar at the top or bottom.
- **Users:** notifications in the desk's corner for server-side commands and background work.

### For host apps
- **Developers:** `bin/rails g rori:install` wires an app up: initializer, `Rori::Windowed`, `draw :rori`, the root route and the Stimulus registration.
- **Developers:** pages declare how they're shown (`window size:, mode:, workspace:, key:`); windows with the same key are reused; broadcast refreshes reload only the windows showing the changed data.
- **Developers:** `Rori.records` lists recent records in ⌘K; a labelled parameterless GET route becomes a command; `Rori.commands` adds entries; `Rori.command :name, confirm: true do … end` runs code on the server, and `Rori.notify` reports back from anywhere (e.g. a job).
- **Developers:** one keymap (`Rori.keymap`, `Mod` = `Rori.modifier`), a native-shell modifier by user agent (`Rori.native_user_agent`, `Rori.native_modifier`, `Rori.keymap_overrides`).
- **Developers:** self-contained CSS in one `rori` cascade layer with `--rori-*` tokens that fall back to the host's tokens; `rori-` prefixed classes; `Rori.themes_folder` and `Rori.wallpapers_folder` for the app's own themes and photos.
