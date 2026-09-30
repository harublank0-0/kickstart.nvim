-- Codex CLI in a persistent right-side split, using the existing Snacks UI.
local M = {}
local sessions = {}

function M.open(resume)
  if vim.fn.executable('codex') ~= 1 then
    vim.notify('Codex CLI is not on Neovim PATH.', vim.log.levels.ERROR)
    return
  end
  local cwd = vim.fn.getcwd()
  local terminal = sessions[cwd]
  if terminal and terminal:buf_valid() then
    terminal:toggle()
    return
  end
  local cmd = resume and { 'codex', 'resume' } or { 'codex' }
  sessions[cwd] = require('snacks').terminal.open(cmd, {
    cwd = cwd,
    win = {
      position = 'right',
      width = 0.40,
      border = 'none',
      keys = {
        codex_hide = {
          '<C-g>',
          function(self) self:hide() end,
          mode = { 'n', 't' },
          desc = 'Hide Codex (keep session running)',
        },
        codex_editor = {
          '<C-h>',
          function()
            vim.cmd.stopinsert()
            vim.cmd.wincmd 'h'
          end,
          mode = 't',
          desc = 'Focus editor beside Codex',
        },
      },
    },
  })
end

vim.api.nvim_create_user_command('Codex', function() M.open(false) end, { desc = 'Toggle Codex split' })
vim.api.nvim_create_user_command('CodexResume', function() M.open(true) end, { desc = 'Open Codex session picker (when no session is running)' })
vim.keymap.set('n', '<leader>ax', '<cmd>Codex<cr>', { desc = 'Codex: Toggle' })
vim.keymap.set('n', '<leader>aR', '<cmd>CodexResume<cr>', { desc = 'Codex: Resume' })

-- Reload external edits on returning to code; modified buffers remain protected.
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'TermLeave' }, {
  group = vim.api.nvim_create_augroup('kickstart-codex-reload', { clear = true }),
  callback = function()
    if vim.bo.buftype == '' then
      vim.cmd.checktime()
    end
  end,
})
return M
