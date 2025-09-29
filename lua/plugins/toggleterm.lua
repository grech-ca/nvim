return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      winbar = {
	enabled = false
      }
    })

    local lazygit = require("plugins.components.toggleterm.lazygit")
    local regular = require("plugins.components.toggleterm.regular")

    vim.keymap.set("n", "<Leader>lg", lazygit.toggle, { desc = "Move to next buffer" })
    vim.keymap.set("n", "<Leader>tf", regular.toggle, { desc = "Move to next buffer" })
  end
}
