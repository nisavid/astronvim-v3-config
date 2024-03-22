local buffer = require "astronvim.utils.buffer"

return {
  c = {
    ["<M-h>"] = "<Left>",
    ["<M-j>"] = "<Down>",
    ["<M-k>"] = "<Up>",
    ["<M-l>"] = "<Right>",
  },
  n = {
    ["<C-h>"] = { function() buffer.nav(-(vim.v.count > 0 and vim.v.count or 1)) end, desc = "Previous buffer" },
    ["<C-l>"] = { function() buffer.nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" },
    ["<leader>r"] = { name = "Refactor" },
    ["<leader>r/"] = { name = "Replace all" },
    ["<leader>r/e"] = { ":%s/\\m\\k\\@<!\\V<C-r>=expand('<cexpr>')<cr>\\m\\k\\@!/", desc = "C expression" },
    ["<leader>r/f"] = { ":%s/\\m\\f\\@<!\\V<C-r>=expand('<cfile>')<cr>\\m\\f\\@!/", desc = "path name" },
    ["<leader>r/w"] = { ":%s/\\m\\k\\@<!\\V<C-r>=expand('<cword>')<cr>\\m\\k\\@!/", desc = "word" },
    ["<leader>r/W"] = { ":%s/\\m\\k\\@<!\\V<C-r>=expand('<cWORD>')<cr>\\m\\k\\@!/", desc = "WORD" },
  },
  o = {
    ["a="] = { name = "assignment" },
    ["i="] = { name = "assignment" },
  },
  x = {
    ["<leader>r"] = { name = "Refactor" },
    ["<leader>r/"] = { name = "Replace all" },
    ["<leader>r//"] = { '"sy:%s/\\V<C-r>s/', desc = "Replace all" },
    ["<leader>r/w"] = { '"sy:%s/\\m\\k\\@<!\\V<C-r>s\\m\\k\\@!/', desc = "Replace all (keyword match)" },
  },
}
