return {
  "rebelot/heirline.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.o.showtabline = 2      -- global statusline
    vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

    vim.o.laststatus = 3      -- global statusline

    local heirline = require("heirline")
    local statusline = require("plugins.components.heirline.statusline")
    local tabline = require("plugins.components.heirline.tabline")
    local winbar = require("plugins.components.heirline.winbar")

    heirline.setup({
      statusline = statusline,
      tabline = tabline,
      winbar = winbar,
      update = {
	statusline = { "BufEnter", "WinEnter", "ModeChanged" },
	winbar = { "BufEnter", "WinEnter", "ModeChanged" },
	-- or even { "BufWritePost" } if you only need redraw on save
      },
   })

    -- Redraw every 1 minute to make the clock component work
    vim.fn.timer_start(60000, function()
      -- force a regular statusline redraw
      vim.schedule(function()
	vim.cmd("redrawstatus")
      end)
    end, { ["repeat"] = -1 })
  end
}
