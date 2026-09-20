local gh = require('utils.helpers').gh

vim.pack.add {
  gh 'folke/snacks.nvim',
}

-- ============================================================
-- Snacks
-- ============================================================
--
-- Snacks provides the terminal UI used by Claude Code.
-- We also enable a few useful general-purpose developer features.
--

require('snacks').setup {
  bigfile = {
    enabled = true, -- Improves performance when opening very large files.
  },

  input = {
    enabled = true, -- Provides a nicer floating UI for prompts and input dialogs.
  },

  notifier = {
    enabled = true, -- Shows Neovim notifications in a nicer UI.
    timeout = 3000, -- Notifications stay visible for 3 seconds.
  },

  picker = {
    enabled = true, -- Enables Snacks' fuzzy finder for files, grep, buffers, etc.
    ui_select = true, -- Uses Snacks picker for vim.ui.select() menus.
  },

  quickfile = {
    enabled = true, -- Opens files quickly by optimizing the initial file-loading process.
  },

  scope = {
    enabled = true, -- Visually highlights and manages the current code scope/block.
  },

  scroll = {
    enabled = true, -- Provides smoother scrolling animations in Neovim.
  },

  statuscolumn = {
    enabled = true, -- Enhances the sign/number/fold column beside the editor.
  },

  words = {
    enabled = true, -- Highlights the word under the cursor and its other occurrences.
  },

  -- We already use Neo-tree for file exploration, so Snacks Explorer is disabled.
  explorer = {
    enabled = false,
  },

  dashboard = {
    enabled = true, -- Shows a customizable startup dashboard when Neovim opens without a file.
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
    },
  },

  -- Enables previews/rendering for images, PDFs, LaTeX/math, and Mermaid diagrams.
  image = {
    enabled = true,
  },
}
