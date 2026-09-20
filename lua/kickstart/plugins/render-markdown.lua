local gh = require('utils.helpers').gh

vim.pack.add {
  gh 'MeanderingProgrammer/render-markdown.nvim',
}

require('render-markdown').setup {
  enabled = true,

  -- Render Markdown in normal mode, but keep the original Markdown
  -- available while editing.
  render_modes = { 'n', 'c', 't' },

  completions = {
    lsp = {
      enabled = true,
    },
  },
}

vim.keymap.set('n', '<leader>mp', '<cmd>RenderMarkdown toggle<cr>', {
  desc = 'Markdown: Toggle rendering',
})

vim.keymap.set('n', '<leader>mP', '<cmd>RenderMarkdown preview<cr>', {
  desc = 'Markdown: Preview',
})
