-- Linting

vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }

local lint = require 'lint'
local project_tools = require 'utils.project_tools'
local web_filetypes = { javascript = true, typescript = true, javascriptreact = true, typescriptreact = true, json = true, jsonc = true }
lint.linters_by_ft = {
  markdown = { 'markdownlint' }, -- Make sure to install `markdownlint` via mason / npm
}

-- To allow other plugins to add linters to require('lint').linters_by_ft,
-- instead set linters_by_ft like this:
-- lint.linters_by_ft = lint.linters_by_ft or {}
-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
--
-- However, note that this will enable a set of default linters,
-- which will cause errors unless these tools are available:
-- {
--   clojure = { "clj-kondo" },
--   dockerfile = { "hadolint" },
--   inko = { "inko" },
--   janet = { "janet" },
--   json = { "jsonlint" },
--   markdown = { "vale" },
--   rst = { "vale" },
--   ruby = { "ruby" },
--   terraform = { "tflint" },
--   text = { "vale" }
-- }
--
-- You can disable the default linters by setting their filetypes to nil:
-- lint.linters_by_ft['clojure'] = nil
-- lint.linters_by_ft['dockerfile'] = nil
-- lint.linters_by_ft['inko'] = nil
-- lint.linters_by_ft['janet'] = nil
-- lint.linters_by_ft['json'] = nil
-- lint.linters_by_ft['markdown'] = nil
-- lint.linters_by_ft['rst'] = nil
-- lint.linters_by_ft['ruby'] = nil
-- lint.linters_by_ft['terraform'] = nil
-- lint.linters_by_ft['text'] = nil

-- Create autocommand which carries out the actual linting
-- on the specified events.
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    -- Only run the linter in buffers that you can modify in order to
    -- avoid superfluous noise, notably within the handy LSP pop-ups that
    -- describe the hovered symbol using Markdown.
    if not vim.bo.modifiable or vim.bo.buftype ~= '' then return end
    if web_filetypes[vim.bo.filetype] then
      -- ESLint and Biome can coexist: each runs only when the project declares it.
      for _, tool in ipairs { 'eslint', 'biome' } do
        local selected, root = project_tools.detect(0, { tool })
        local linter_name = tool == 'biome' and 'biomejs' or tool
        if selected then
          local command = project_tools.command(0, tool)
          lint.try_lint(linter_name, {
            cwd = root,
            wrap_linter = function(linter)
              linter.cmd = command
              return linter
            end,
          })
        else
          vim.diagnostic.reset(lint.get_namespace(linter_name), 0)
        end
      end
    else
      lint.try_lint(nil, {
        cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
        wrap_linter = function(linter)
          if type(linter.cmd) == 'string' then linter.cmd = project_tools.command(0, linter.cmd) end
          return linter
        end,
      })
    end
  end,
})
