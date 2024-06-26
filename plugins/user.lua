return {
  {
    "rainbowhxch/accelerated-jk.nvim",
    event = "BufEnter",
    config = function()
      require("astronvim.utils").set_mappings {
        n = {
          ["j"] = { "<Plug>(accelerated_jk_gj)", desc = "Move down" },
          ["k"] = { "<Plug>(accelerated_jk_gk)", desc = "Move up" },
        },
      }
    end,
  },
  {
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    opts = {
      suggestion = {
        auto_trigger = true,
        debounce = 150,
        keymap = {
          accept = "<C-l>",
          accept_word = "<M-l>",
          accept_line = "<M-j>",
        },
      },
    },
  },
  {
    "glacambre/firenvim",
    lazy = not vim.g.started_by_firenvim,
    module = false,
    build = function() vim.fn["firenvim#install"](0) end,
  },
  {
    "ellisonleao/glow.nvim",
    cmd = { "Glow" },
    keys = { { "<M-F5>", ":Glow<CR>", desc = "Render markdown (floating)" } },
    opts = function(_, opts)
      opts.width = vim.o.columns
      opts.height = vim.o.lines
      opts.width_ratio = 0.62
      opts.height_ratio = 0.76
      local style = os.getenv "GLAMOUR_STYLE"
      if vim.uv.fs_access(style, "R") then opts.style = style end
      return opts
    end,
  },
  {
    "mrjones2014/legendary.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    priority = 10000,
    lazy = false,
    keys = {
      {
        "<F1>",
        mode = { "n", "v", "x", "s", "o", "i", "l", "c", "t" },
        function()
          require("legendary").find {
            filters = { require("legendary.filters").current_mode() },
            formatter = function(item, mode)
              local values = require("legendary.ui.format").default_format(item)
              if require("legendary.toolbox").is_keymap(item) then values[1] = mode end
              return values
            end,
          }
        end,
        desc = "Legend for current mode",
      },
      { "<leader>fL", vim.cmd.Legendary, desc = "Legend" },
    },
    opts = function()
      local opts = {
        sort = { frecency = { db_root = vim.fn.stdpath "state" .. "/legendary/" } },
        extensions = {
          lazy_nvim = { auto_register = true },
          which_key = { auto_register = true },
        },
      }
      local is_available = require("astronvim.utils").is_available
      if is_available "diffview.nvim" then opts.extensions.diffview = true end
      if is_available "nvim-tree.lua" then opts.extensions.nvim_tree = true end
      if is_available "op.nvim" then opts.extensions.op_nvim = true end
      if is_available "smart-splits.nvim" then opts.extensions.smart_splits = true end
      return opts
    end,
  },
  --{
  --  "ray-x/lsp_signature.nvim",
  --  init = function()
  --    vim.api.nvim_create_autocmd("LspAttach", {
  --      group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
  --      callback = function(args)
  --        if not (args.data and args.data.client_id) then return end
  --        local client = vim.lsp.get_client_by_id(args.data.client_id)
  --        if not client.server_capabilities.inlayHintProvider then
  --          local lsp_signature = require "lsp_signature"
  --          lsp_signature.on_attach({
  --            hint_enable = false,
  --            select_signature_key = "<M-n>",
  --          }, args.buf)
  --        end
  --      end,
  --    })
  --  end,
  --},
  {
    "iamcco/markdown-preview.nvim",
    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewStop",
      "MarkdownPreviewToggle",
    },
    keys = { { "<F5>", "<Plug>MarkdownPreviewToggle", desc = "Render markdown (web browser)" } },
  },
  {
    "jghauser/mkdir.nvim",
    event = "BufEnter",
  },
  {
    "tamago324/nlsp-settings.nvim",
    dependencies = { "neovim/nvim-lspconfig", "rcarriga/nvim-notify" },
    cmd = "LspSettings",
    event = "BufEnter",
    opts = {
      append_default_schemas = true,
      nvim_notify = { enable = true },
    },
  },
  {
    "code-biscuits/nvim-biscuits",
    event = "BufEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    build = function() vim.cmd.TSUpdate() end,
  },
  {
    "kosayoda/nvim-lightbulb",
    opts = { autocmd = { enabled = true } },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufEnter",
  },
  {
    "cshuaimin/ssr.nvim",
    keys = { { "<leader>rs", mode = { "n", "x" }, desc = "Structural search & replace" } },
    config = function()
      require("astronvim.utils").set_mappings {
        n = { ["<leader>rs"] = { function() require("ssr").open() end, desc = "Structural search & replace" } },
        x = { ["<leader>rs"] = { function() require("ssr").open() end, desc = "Structural search & replace" } },
      }
    end,
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "kkharji/sqlite.lua" },
    opts = {
      database = { path = vim.fn.stdpath "state" },
    },
  },
  { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-file-browser.nvim" },
    keys = {
      { "<leader>ff", function() require("telescope").extensions.file_browser.file_browser() end, desc = "Find files" },
    },
  },
  { "crispgm/telescope-heading.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "crispgm/telescope-heading.nvim" },
    keys = {
      { "<leader>fH", function() require("telescope").extensions.heading.heading() end, desc = "Find headings" },
    },
    opts = { extensions = { heading = { treesitter = true } } },
  },
  { "tsakirist/telescope-lazy.nvim", dependencies = { "nvim-telescope/telescope-file-browser.nvim" } },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "tsakirist/telescope-lazy.nvim" },
    keys = { { "<leader>fp", function() require("telescope").extensions.lazy.lazy() end, desc = "Find packages" } },
  },
  { "z-shell/zi-vim-syntax", ft = { "zsh" } },
}
