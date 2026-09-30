local gh = require('utils.helpers').gh
local project_tools = require 'utils.project_tools'
-- ============================================================
-- SECTION 6: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
-- [[ Formatting ]]
vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = true,
  -- A missing project formatter must not silently invoke a different LSP formatter.
  formatters = {
    biome = { command = function(_, ctx) return project_tools.command(ctx.buf, 'biome') end },
    prettier = { command = function(_, ctx) return project_tools.command(ctx.buf, 'prettier') end },
  },
  format_on_save = function(bufnr)
    -- You can specify filetypes to autoformat on save here:
    local enabled_filetypes = {
      lua = true,
      python = true,
      typescript = true,
      javascript = true,
      javascriptreact = true,
      typescriptreact = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500, lsp_format = project_tools.detect(bufnr, { 'biome', 'prettier' }) and 'never' or 'fallback' }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    -- rust = { 'rustfmt' },
    -- Conform can also run multiple formatters sequentially
    python = { 'isort', 'black' },
    --
    javascript = project_tools.formatters,
    typescript = project_tools.formatters,
    javascriptreact = project_tools.formatters,
    typescriptreact = project_tools.formatters,
    json = project_tools.formatters,
    jsonc = project_tools.formatters,
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true, lsp_format = project_tools.detect(0, { 'biome', 'prettier' }) and 'never' or 'fallback' } end, { desc = '[F]ormat buffer' })
