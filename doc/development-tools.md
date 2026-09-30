# Development tools

Normal-mode shortcuts; leader is `Space`.

| Shortcut | Action |
|---|---|
| `Space s R` | Search and replace across files (capital R) |
| `Space x x` | Toggle all reported diagnostics |
| `Space x X` | Toggle current-file diagnostics (capital X) |
| `Space x q` | Toggle quickfix panel |
| `Space f` | Format the current file |

## Search and replace — grug-far

Open Neovim at the project root. Press `Space s R`, fill Search and Replace, inspect the preview, then press `Space r` in normal mode to apply. Use Files Filter (for example `*.tsx`) or Paths to narrow the scope. Review the result with `Space g d` (Diffview).

## Problems panel — Trouble

Press `Space x x`, select an entry, then `Enter` to jump to it. Trouble displays diagnostics already reported by your tools; it does not run a full-project typecheck.

## JSX/HTML tags — autotag

Closing tags are inserted automatically. Renaming an opening tag updates its closing tag. Uses Treesitter parsers; your config installs missing parsers when their filetype opens.

## Lua formatting — StyLua

Lua formats on save or with `Space f`. Mason installs StyLua; Conform runs it. Inspect with `:ConformInfo`.
