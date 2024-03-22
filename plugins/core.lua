return {
  { "max397574/better-escape.nvim", enabled = false },
  { "numToStr/Comment.nvim", opts = { padding = false } },
  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        get_config = function(opts)
          if opts.kind == "legendary.nvim" then
            return {
              telescope = {
                sorter = require("telescope.sorters").fuzzy_with_index_bias {},
              },
            }
          else
            return {}
          end
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = vim.fn.executable "tree-sitter" ~= 0,
      textobjects = {
        select = {
          keymaps = {
            ["a/"] = { query = "@comment.outer", desc = "around comment" },
            ["i/"] = { query = "@comment.inner", desc = "inside comment" },
            ["ah"] = { query = "@statement.outer", desc = "around statement" },
            ["al"] = { query = "@class.outer", desc = "around class" },
            ["il"] = { query = "@class.inner", desc = "inside class" },
            ["a%"] = { query = "@loop.outer", desc = "around loop" },
            ["i%"] = { query = "@loop.inner", desc = "inside loop" },
            ["a_"] = { query = "@return.outer", desc = "around return" },
            ["i_"] = { query = "@return.inner", desc = "inside return" },
            ["a=e"] = { query = "@assignment.outer", desc = "around assignment" },
            ["i=e"] = { query = "@assignment.inner", desc = "inside assignment" },
            ["a=<"] = { query = "@assignment.lhs", desc = "left side of assignment" },
            ["i=<"] = { query = "@assignment.lhs", desc = "left side of assignment" },
            ["a=>"] = { query = "@assignment.rhs", desc = "right side of assignment" },
            ["i=>"] = { query = "@assignment.rhs", desc = "right side of assignment" },
            ["ar"] = { query = "@attribute.outer", desc = "around attribute" },
            ["ir"] = { query = "@attribute.inner", desc = "inside attribute" },
            ["a&"] = { query = "@call.outer", desc = "around call" },
            ["i&"] = { query = "@call.inner", desc = "inside call" },
            ["a*"] = { query = "@regex.outer", desc = "around regex" },
            ["i*"] = { query = "@regex.inner", desc = "inside regex" },
            ["i#"] = { query = "@number.inner", desc = "number" },
          },
        },
        move = {
          goto_next_start = {
            ["]h"] = { query = "@statement.outer", desc = "Next statement start" },
            ["]l"] = { query = "@class.outer", desc = "Next class start" },
            ["]r"] = { query = "@attribute.outer", desc = "Next attribute start" },
          },
          goto_next_end = {
            ["]H"] = { query = "@statement.outer", desc = "Next statement end" },
            ["]L"] = { query = "@class.outer", desc = "Next class end" },
            ["]R"] = { query = "@attribute.outer", desc = "Next attribute end" },
          },
          goto_previous_start = {
            ["[h"] = { query = "@statement.outer", desc = "Previous statement start" },
            ["[l"] = { query = "@class.outer", desc = "Previous class start" },
            ["[r"] = { query = "@attribute.outer", desc = "Previous attribute start" },
          },
          goto_previous_end = {
            ["[H"] = { query = "@statement.outer", desc = "Previous statement end" },
            ["[L"] = { query = "@class.outer", desc = "Previous class end" },
            ["[R"] = { query = "@attribute.outer", desc = "Previous attribute end" },
          },
        },
        swap = {
          swap_next = {
            [">H"] = { query = "@statement.outer", desc = "Swap next statement" },
            [">L"] = { query = "@class.outer", desc = "Swap next class" },
            [">R"] = { query = "@attribute.outer", desc = "Swap next attribute" },
          },
          swap_previous = {
            ["<H"] = { query = "@statement.outer", desc = "Swap previous statement" },
            ["<L"] = { query = "@class.outer", desc = "Swap previous class" },
            ["<R"] = { query = "@attribute.outer", desc = "Swap previous attribute" },
          },
        },
      },
    },
  },
  --{
  --  "goolord/alpha-nvim",
  --  opts = function(_, opts)
  --    -- customize the dashboard header
  --    opts.section.header.val = {
  --      " █████  ███████ ████████ ██████   ██████",
  --      "██   ██ ██         ██    ██   ██ ██    ██",
  --      "███████ ███████    ██    ██████  ██    ██",
  --      "██   ██      ██    ██    ██   ██ ██    ██",
  --      "██   ██ ███████    ██    ██   ██  ██████",
  --      " ",
  --      "    ███    ██ ██    ██ ██ ███    ███",
  --      "    ████   ██ ██    ██ ██ ████  ████",
  --      "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
  --      "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
  --      "    ██   ████   ████   ██ ██      ██",
  --    }
  --    return opts
  --  end,
  --},
  --
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  --{
  --  "L3MON4D3/LuaSnip",
  --  config = function(plugin, opts)
  --    require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --    -- add more custom luasnip configuration such as filetype extend or custom snippets
  --    local luasnip = require "luasnip"
  --    luasnip.filetype_extend("javascript", { "javascriptreact" })
  --  end,
  --},
  --{
  --  "windwp/nvim-autopairs",
  --  config = function(plugin, opts)
  --    require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --    -- add more custom autopairs configuration such as custom rules
  --    local npairs = require "nvim-autopairs"
  --    local Rule = require "nvim-autopairs.rule"
  --    local cond = require "nvim-autopairs.conds"
  --    npairs.add_rules(
  --      {
  --        Rule("$", "$", { "tex", "latex" })
  --          -- don't add a pair if the next character is %
  --          :with_pair(cond.not_after_regex "%%")
  --          -- don't add a pair if  the previous character is xxx
  --          :with_pair(
  --            cond.not_before_regex("xxx", 3)
  --          )
  --          -- don't move right when repeat character
  --          :with_move(cond.none())
  --          -- don't delete if the next character is xx
  --          :with_del(cond.not_after_regex "xx")
  --          -- disable adding a newline when you press <cr>
  --          :with_cr(cond.none()),
  --      },
  --      -- disable for .vim files, but it work for another filetypes
  --      Rule("a", "a", "-vim")
  --    )
  --  end,
  --},
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  --{
  --  "folke/which-key.nvim",
  --  config = function(plugin, opts)
  --    require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
  --    -- Add bindings which show up as group name
  --    local wk = require "which-key"
  --    wk.register({
  --      b = { name = "Buffer" },
  --    }, { mode = "n", prefix = "<leader>" })
  --  end,
  --},
}
