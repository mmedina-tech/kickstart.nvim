# Repository Guidelines

## Project Structure & Module Organization
`init.lua` bootstraps the whole configuration, pulls in `lua/config/` for options, keymaps, autocmds, and the dark-theme manager, then hands control to Lazy. Core behavior belongs in `lua/config/`, while plugin specs stay in `lua/plugins/specs/` (group related specs: e.g., UI, LSP, completion). Shared utilities can sit in `lua/plugins/utils/`, and experimental or user-specific plugins belong in `lua/custom/plugins/` so they can be toggled independently. Documentation is split between `README.md` (overview), this guide, and any `doc/*.txt` files that expose `:help` topics.

## Build, Test, and Development Commands
Run `nvim` from this directory to exercise the config in-place. Inside Neovim, use `:Lazy sync` after editing anything under `lua/plugins/`, `:Lazy check` to verify lockfile drift, and `:checkhealth` before filing bugs. Theme development relies on `:ThemePicker` (`<leader>up`) for Telescope previews, `:ThemeToggle` (`<leader>ut`) to advance through the catalog, and `:ThemeSync` (`<leader>us`) to re-read desktop settings. Reformat Lua with `stylua init.lua lua` prior to commits.

## Coding Style & Naming Conventions
Follow the Kickstart defaults: two-space indentation, trailing commas in Lua tables, and snake_case locals. Each module returns a table or function; avoid polluting the global namespace. Keymaps should use `vim.keymap.set` with descriptive `<leader>` prefixes (`<leader>u` for UI/toggles). Plugin spec tables read best when ordered `event → dependencies → opts → config`. For docs, wrap prose at ~100 columns, use `-` for unordered lists, and prefer present tense.

## Testing Guidelines
There is no automated suite, so manual smoke tests are mandatory. Launch Neovim, trigger keymaps touched by the change, and watch `:messages` for stack traces. After theme work, delete the cache (`rm -f ~/.local/state/nvim/theme.json`) and restart to ensure persistence and system detection still work. For LSP or formatter updates, run `:checkhealth` and inspect `:Mason` (if enabled) to confirm tools install cleanly.

## Commit & Pull Request Guidelines
Recent history (`git log --oneline`) shows short, lowercase summaries (`new neovim config`, `adding themes`). Keep that tone: imperative, ≤60 characters, and scoped to one logical change. Reference related files in the body when helpful (`touches lua/config/theme.lua`). PRs should describe motivation, list manual verification (e.g., “Ran :Lazy sync, cycled themes”), attach screenshots for UI tweaks (Alpha dashboard, Telescope pickers), and link issues or TODO items. Remember to mention any follow-up work if the change is intentionally incremental.
