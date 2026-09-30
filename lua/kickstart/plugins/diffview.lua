local gh = require('utils.helpers').gh

vim.pack.add {
  gh 'sindrets/diffview.nvim',
}

require('diffview').setup {
  file_panel = {
    listing_style = 'list',
    win_config = {
      position = 'left',
      width = 35,
    },
  },
}

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Git: Open diff and changed files' })
vim.keymap.set('n', '<leader>ge', '<cmd>DiffviewFocusFiles<cr>', { desc = 'Git: Focus changed files' })
vim.keymap.set('n', '<leader>gq', '<cmd>DiffviewClose<cr>', { desc = 'Git: Close diff view' })
