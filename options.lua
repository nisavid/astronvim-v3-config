return function(vim_)
  vim.opt.updatetime = 100

  vim.opt.splitbelow = true
  vim.opt.splitright = true
  vim.opt.diffopt = vim.opt.diffopt + "vertical"

  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.breakindent = true

  vim.opt.cursorcolumn = true
  vim.opt.cursorline = true

  vim.opt.title = true
  vim.opt.list = true
  vim.opt.listchars = {
    tab = "󰌒",
    trail = "·",
    nbsp = "␣",
    extends = "…",
    precedes = "…",
  }

  return vim_
end
