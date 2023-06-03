return {
  "rebelot/kanagawa.nvim",
  commit = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92",
  -- name = "kanagawa",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- Using protected call
    local status_ok, kanagawa = pcall(require, "kanagawa")


    if not status_ok then
      return
    end

    kanagawa.setup({
      theme = { all = { ui = { bg_gutter = 'none' } } },
      transparent = true,
      dimInactive = false,
    })
    vim.cmd("colorscheme kanagawa")
  end,
}
