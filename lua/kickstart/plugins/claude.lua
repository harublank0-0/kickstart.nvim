-- ============================================================
-- Dependencies
-- ============================================================

local gh = require('utils.helpers').gh

vim.pack.add {
  -- Claude Code uses Snacks as its terminal UI provider.
  gh 'coder/claudecode.nvim',
}

-- ============================================================
-- Claude Code
-- ============================================================

require('claudecode').setup {
  -- Claude Code CLI
  --
  -- `claude` is available in Neovim's PATH, so this can remain nil.
  --
  -- You can verify with:
  -- :echo exepath('claude')
  --
  terminal_cmd = nil,

  -- Start the Claude Code integration automatically.
  auto_start = true,

  -- Port range used for the Claude Code connection.
  port_range = {
    min = 10000,
    max = 65535,
  },

  -- Logging level.
  log_level = 'info',

  -- Claude terminal configuration.
  terminal = {
    -- Put Claude on the right side of the editor.
    split_side = 'right',

    -- Terminal takes 30% of the editor width.
    split_width_percentage = 0.30,

    -- Use Snacks for the terminal UI.
    provider = 'snacks',

    -- Automatically close the terminal when Claude exits.
    auto_close = true,

    -- Automatically enter terminal/insert mode when the terminal
    -- receives focus.
    auto_insert = true,

    -- Show Claude's native terminal exit tip.
    show_native_term_exit_tip = true,

    -- Environment variables passed to Claude.
    env = {},

    -- Floating window configuration for Snacks.
    snacks_win_opts = {
      position = 'float',
      width = 0.85,
      height = 0.85,
      border = 'rounded',
      backdrop = 60,

      keys = {
        -- Hide Claude with Ctrl+,
        claude_hide = {
          '<C-,>',
          function(self) self:hide() end,
          mode = 't',
          desc = 'Hide Claude',
        },
      },
    },
  },
}

-- ============================================================
-- Keymaps
-- ============================================================

local map = vim.keymap.set

-- Toggle / focus Claude
map('n', '<leader>ac', '<cmd>ClaudeCode<cr>', {
  desc = 'Claude: Toggle',
})

map({ 'n', 'x' }, '<leader>af', '<cmd>ClaudeCodeFocus<cr>', {
  desc = 'Claude: Focus',
})

-- Resume / continue previous Claude sessions
map('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', {
  desc = 'Claude: Resume',
})

map('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', {
  desc = 'Claude: Continue',
})

-- Select Claude model
map('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', {
  desc = 'Claude: Select model',
})

-- Add current buffer to Claude context
map('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', {
  desc = 'Claude: Add current buffer',
})

-- Send visual selection to Claude
map('x', '<leader>as', '<cmd>ClaudeCodeSend<cr>', {
  desc = 'Claude: Send selection',
})

-- Accept / reject Claude's proposed diff
map('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', {
  desc = 'Claude: Accept diff',
})

map('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', {
  desc = 'Claude: Deny diff',
})

-- Claude status
map('n', '<leader>at', '<cmd>ClaudeCodeStatus<cr>', {
  desc = 'Claude: Status',
})
