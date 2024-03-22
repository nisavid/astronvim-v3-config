local M = {}

M.eslint_filetypes = {
  "javascript",
  "javascriptreact",
  "json",
  "json5",
  "jsonc",
  "markdown",
  "markdown.mdx",
  "typescript",
  "typescriptreact",
  "vue",
}

M.prettier_filetypes = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "json5",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

M.null_ls_filetypes = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "json5",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

local config_extractors = {
  JSON = function(filepath, query)
    if query:sub(1, 1) == "." then query = query:sub(2) end

    local file = io.open(filepath, "r")
    if not file then return nil end

    local content = file:read "*all"
    file:close()

    local json_parsed, config = pcall(vim.json.decode(content, { luanil = { object = true, array = true } }))
    if not json_parsed then return nil end

    return vim.tbl_get(config, query:split ".")
  end,
}

local function config_in_dir(path, patterns)
  local match, extractor, file
  for pattern in vim.iter(patterns) do
    match = pattern:match "(.+):(.+):(.+)"
    if match then
      extractor = config_extractors[match[1]]
      if extractor then
        file = vim.fs.joinpath(path, match[2])
        if vim.fn.filereadable(file) == 1 and extractor(file, match[3]) ~= nil then return file end
      end
    else
      file = vim.fs.joinpath(path, pattern)
      if vim.fn.filereadable(file) == 1 then return file end
    end
  end
  return nil
end

M.find_config = function(name, path, patterns)
  path = path or vim.fn.getcwd()
  patterns = vim
    .iter(patterns or {
      "JSON:package.json:%s",
      ".%src",
      ".%src.json",
      ".%src.yaml",
      ".%src.yml",
      ".%src.js",
      ".%src.mjs",
      ".%src.cjs",
      "%s.config.js",
      "%s.config.mjs",
      "%s.config.cjs",
    })
    :map(function(pattern) return string.format(pattern, name) end)
    :totable()

  local config
  if vim.fn.isdirectory(path) ~= 0 then
    config = config_in_dir(path, patterns)
    if config then return config end
  end

  for dir in vim.fs.parents(path) do
    config = config_in_dir(dir, patterns)
    if config then return config end
  end
end

M.find_eslint_flat_config = function(path) return M.find_config("eslint", path, { "eslint.config.js" }) end

M.find_eslintrc_config = function(path)
  return M.find_config("eslint", path, {
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "JSON:package.json:eslintConfig",
  })
end

M.find_eslint_config = function(path)
  local use_flat_config = os.getenv "ESLINT_USE_FLAT_CONFIG"
  if use_flat_config == "true" then
    return M.find_eslint_flat_config(path)
  elseif use_flat_config == "false" then
    return M.find_eslintrc_config(path)
  else
    return M.find_eslint_flat_config(path) or M.find_eslintrc_config(path)
  end
end

M.find_prettier_config = function(path)
  return M.find_config("prettier", path, {
    "JSON:package.json:prettier",
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    "prettier.config.js",
    ".prettierrc.mjs",
    "prettier.config.mjs",
    ".prettierrc.cjs",
    "prettier.config.cjs",
    ".prettierrc.toml",
  })
end

M.should_use_eslint = function(path) return M.find_eslint_flat_config(path) ~= nil end
M.should_use_eslint_d = function(path) return M.find_eslintrc_config(path) ~= nil end
M.should_use_prettierd = function(path) return M.find_prettier_config(path) ~= nil end

return M
