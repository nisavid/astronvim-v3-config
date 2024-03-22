return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.automatic_installation = true
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "awk_ls",
        "elmls",
        "grammarly",
        "graphql",
        --"jsonld-lsp",
        "lemminx",
        --"ltex",
        --"nginx-language-server",
        "perlnavigator",
        "pkgbuild_language_server",
        "puppet",
        "sqlls",
        "stylelint_lsp",
        "texlab",
        "vimls",
        "zls",
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.automatic_installation = true
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "actionlint",
        "codespell",
        "commitlint",
        "editorconfig-checker",
        "vacuum",
      })

      -- Disable handlers that are configured in `null-ls.lua`
      opts.handlers.eslint = function() end
      opts.handlers.eslint_d = function() end
      opts.handlers.prettier = function() end
      opts.handlers.prettierd = function() end
      opts.handlers.shellcheck = function() end

      return opts
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {})
    end,
  },
}
