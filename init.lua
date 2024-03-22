--local utils = require "user.utils"

local rtp = {}
if vim.env.NVIM_QT_RUNTIME_PATH then table.insert(rtp, vim.env.NVIM_QT_RUNTIME_PATH) end

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "catppuccin",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        paths = rtp,
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  lsp = {
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {},
        ignore_filetypes = {},
      },
      disabled = {},
      timeout_ms = 5000,
      --filter = function(client)
      --  if vim.list_contains(utils.null_ls_filetypes, vim.bo.filetype) then return client.name == "null-ls" end
      --  return true
      --end,
    },
    -- Enable servers installed without mason
    servers = {
      -- "pyright"
    },
    config = {
      bashls = function(opts)
        opts.init_options = { bashIde = { shellcheckPath = "" } }
        opts.on_attach = function(client, bufnr)
          for other_client in vim.iter(vim.lsp.get_clients { bufnr = bufnr }) do
            if other_client.name == "pkgbuild_language_server" then
              vim.lsp.buf_detach_client(bufnr, client.id)
              break
            end
          end
        end
        return opts
      end,

      cssls = function(opts)
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        opts.capabilities = capabilities
        return opts
      end,

      --denols = function(opts)
      --  opts.root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
      --  return opts
      --end,

      pkgbuild_language_server = function(opts)
        opts.filetypes = { "bash" }
        opts.root_dir = require("lspconfig.util").root_pattern "PKGBUILD"
        opts.on_attach = function(_, bufnr)
          for other_client in vim.iter(vim.lsp.get_clients { bufnr = bufnr }) do
            if other_client.name == "bashls" then vim.lsp.buf_detach_client(bufnr, other_client.id) end
          end
        end
        return opts
      end,

      taplo = function(opts)
        -- Add `.*.toml` to root patterns in order to work around <https://github.com/tamasfe/taplo/issues/439>
        opts.root_dir = require("lspconfig.util").root_pattern("*.toml", ".*.toml", ".git")
        return opts
      end,

      tsserver = {
        settings = function(opts)
          opts.javascript.inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          }
          opts.typescript.inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          }
          return opts
        end,
      },
    },
  },
}
