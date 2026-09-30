local M = {}

local configs = {
  biome = { 'biome.json', 'biome.jsonc', '.biome.json', '.biome.jsonc' },
  prettier = { '.prettierrc', '.prettierrc.json', '.prettierrc.json5', '.prettierrc.yml', '.prettierrc.yaml', '.prettierrc.toml', '.prettierrc.js', '.prettierrc.cjs', '.prettierrc.mjs', '.prettierrc.ts', '.prettierrc.cts', '.prettierrc.mts', 'prettier.config.js', 'prettier.config.cjs', 'prettier.config.mjs', 'prettier.config.ts', 'prettier.config.cts', 'prettier.config.mts' },
  eslint = { 'eslint.config.js', 'eslint.config.mjs', 'eslint.config.cjs', 'eslint.config.ts', 'eslint.config.mts', 'eslint.config.cts', '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', '.eslintrc.yml', '.eslintrc.yaml' },
}

-- Walk from the buffer, not Neovim's working directory; include monorepo roots.
local function directories(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == '' then return {} end
  local dirs = {}
  local dir = vim.fs.dirname(filename)
  while dir do
    dirs[#dirs + 1] = dir
    if vim.uv.fs_stat(dir .. '/.git') then break end
    local parent = vim.fs.dirname(dir)
    if parent == dir then break end
    dir = parent
  end
  return dirs
end

local function package_json(dir)
  local ok, lines = pcall(vim.fn.readfile, dir .. '/package.json')
  if not ok then return {} end
  local decoded, value = pcall(vim.json.decode, table.concat(lines, '\n'))
  return decoded and type(value) == 'table' and value or {}
end

function M.detect(bufnr, tools)
  local dirs = directories(bufnr)
  -- Explicit configuration beats a dependency declaration.
  for _, dir in ipairs(dirs) do
    local package = package_json(dir)
    for _, tool in ipairs(tools) do
      for _, name in ipairs(configs[tool] or {}) do
        if vim.uv.fs_stat(dir .. '/' .. name) then return tool, dir end
      end
      local key = tool == 'eslint' and 'eslintConfig' or tool
      if package[key] ~= nil then return tool, dir end
    end
  end
  for _, dir in ipairs(dirs) do
    local package = package_json(dir)
    for _, tool in ipairs(tools) do
      local name = tool == 'biome' and '@biomejs/biome' or tool
      for _, group in ipairs { 'devDependencies', 'dependencies' } do
        if type(package[group]) == 'table' and package[group][name] then return tool, dir end
      end
    end
  end
end

function M.command(bufnr, name)
  for _, dir in ipairs(directories(bufnr)) do
    local binary = dir .. '/node_modules/.bin/' .. name
    if vim.fn.executable(binary) == 1 then return binary end
  end
  return name
end

function M.formatters(bufnr)
  return { M.detect(bufnr, { 'biome', 'prettier' }) or 'biome' }
end

return M
