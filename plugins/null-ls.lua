--local utils = require "user.utils"

return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"
    --local node_bin = "node_modules/.bin"
    --local eslint_extra_filetypes = null_ls.builtins.formatting.prettier.filetypes
    ---- Prefer eslint iff flat config is present---until eslint_d supports it
    --local eslint_config = {
    --  extra_filetypes = eslint_extra_filetypes,
    --  condition = function() return utils.should_use_eslint(require("null-ls.utils").get_root()) end,
    --  prefer_local = node_bin,
    --}
    --local eslint_d_config = {
    --  extra_filetypes = eslint_extra_filetypes,
    --  condition = function() return utils.should_use_eslint_d(require("null-ls.utils").get_root()) end,
    --  runtime_condition = function(params)
    --    if vim.list_contains(null_ls.builtins.formatting.prettierd.filetypes, params.filetype) then
    --      return not utils.find_prettier_config(params.root)
    --    end
    --    return true
    --  end,
    --  prefer_local = node_bin,
    --}
    opts.sources = {
      --null_ls.builtins.code_actions.eslint.with(eslint_config),
      --null_ls.builtins.code_actions.eslint_d.with(eslint_d_config),
      null_ls.builtins.diagnostics.checkmake,
      null_ls.builtins.diagnostics.dotenv_linter,
      --null_ls.builtins.diagnostics.eslint.with(eslint_config),
      --null_ls.builtins.diagnostics.eslint_d.with(eslint_d_config),
      null_ls.builtins.diagnostics.fish,
      null_ls.builtins.diagnostics.qmllint,
      null_ls.builtins.diagnostics.rpmspec,
      null_ls.builtins.diagnostics.rstcheck,
      -- Disable shellcheck because bashls already includes it
      null_ls.builtins.diagnostics.shellcheck.with { condition = function() return false end },
      null_ls.builtins.diagnostics.tfsec,
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.cabal_fmt,
      --null_ls.builtins.formatting.eslint.with(eslint_config),
      --null_ls.builtins.formatting.eslint_d.with(eslint_d_config),
      null_ls.builtins.formatting.fish_indent,
      null_ls.builtins.formatting.nginx_beautifier,
      null_ls.builtins.formatting.pg_format,
      ---- Prefer prettierd
      --null_ls.builtins.formatting.prettier.with { condition = function() return false end },
      ---- Disable prettierd if eslint config is present.  Presume that the workspace will configure eslint to use prettier if desired.
      --null_ls.builtins.formatting.prettierd.with {
      --  condition = function() return utils.should_use_prettierd(require("null-ls.utils").get_root()) end,
      --  --runtime_condition = function(params)
      --  --  if vim.list_contains(null_ls.builtins.formatting.eslint_d.filetypes, params.filetype) then
      --  --    return not utils.find_eslint_config(params.root)
      --  --  end
      --  --  return true
      --  --end,
      --  prefer_local = node_bin,
      --},
      null_ls.builtins.formatting.qmlformat,
      null_ls.builtins.formatting.shellharden,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.xmllint,
    }
    return opts
  end,
}
