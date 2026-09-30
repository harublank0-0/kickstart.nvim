local gh = require('utils.helpers').gh

vim.pack.add {
  gh 'pwntester/octo.nvim',
}

require('octo').setup {
  picker = 'telescope',
  enable_builtin = true,
}

require('which-key').add {
  { '<leader>o', group = 'GitHub (Octo)' },
}

vim.keymap.set('n', '<leader>op', '<cmd>Octo pr list<cr>', { desc = 'GitHub: List pull requests' })
vim.keymap.set('n', '<leader>or', '<cmd>Octo review<cr>', { desc = 'GitHub: Start or resume PR review' })
vim.keymap.set('n', '<leader>oa', '<cmd>Octo actions<cr>', { desc = 'GitHub: Available actions' })
