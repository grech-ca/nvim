return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      background = {
	dark = "mocha"
      },
      float = {
	transparent = false,
	solid = true
      }
    })

    vim.cmd.colorscheme "catppuccin"
  end,
}
