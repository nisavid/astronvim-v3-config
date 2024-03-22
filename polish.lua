return function()
  local cmd_abbrevs = {
    h = "vert h",
    help = "vertical help",
  }
  for lhs, rhs in pairs(cmd_abbrevs) do
    vim.cmd.cnoreabbrev(
      "<expr>",
      lhs,
      "getcmdtype() == ':' && getcmdline() ==# '" .. lhs .. "' ? '" .. rhs .. "' : '" .. lhs .. "'"
    )
  end

  vim.api.nvim_create_autocmd("OptionSet", {
    desc = "Update breakindent to match effective shiftwidth",
    pattern = { "shiftwidth", "tabstop" },
    callback = function() vim.opt_local.breakindentopt = { shift = vim.fn.shiftwidth() } end,
  })

  vim.api.nvim_create_autocmd("WinEnter", {
    desc = "Enable cursorcolumn in current window",
    callback = function()
      vim.opt_local.cursorcolumn = true
      vim.opt_local.cursorline = true
    end,
  })
  vim.api.nvim_create_autocmd("WinLeave", {
    desc = "Disable cursorcolumn in non-current window",
    callback = function()
      vim.opt_local.cursorcolumn = false
      vim.opt_local.cursorline = false
    end,
  })

  -- Workaround for https://github.com/folke/trouble.nvim/issues/253
  vim.api.nvim_create_autocmd("QuitPre", {
    desc = "Close Trouble window before quitting",
    callback = function()
      if require("lazy.core.config").plugins["trouble.nvim"]._.loaded then vim.cmd.TroubleClose() end
    end,
  })

  if vim.g.started_by_firenvim then
    vim.g.firenvim_config = {
      globalSettings = { alt = "all" },
      localSettings = {
        [".*"] = {
          cmdline = "neovim",
          content = "text",
          priority = 0,
          selector = 'textarea:not([readonly], [aria-readonly]), div[role="textbox"]',
          takeover = "never",
        },
      },
    }
  end
end
