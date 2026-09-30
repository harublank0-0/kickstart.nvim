local gh = require('utils.helpers').gh

vim.pack.add {
  gh 'MagicDuck/grug-far.nvim',
  gh 'folke/trouble.nvim',
  gh 'windwp/nvim-ts-autotag',
}

require('grug-far').setup {}
require('trouble').setup {}
require('nvim-ts-autotag').setup {}

require('which-key').add {
  { '<leader>x', group = 'Diagnostics' },
}

vim.keymap.set('n', '<leader>sR', '<cmd>GrugFar<cr>', { desc = 'Search and replace across files' })
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics: All reported problems' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Diagnostics: Current buffer' })
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Diagnostics: Quickfix list' })
