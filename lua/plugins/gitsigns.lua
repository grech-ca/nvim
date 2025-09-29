-- lua/plugins/gitsigns.lua
return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = "VeryLazy",
  config = function()
    local gitsigns = require('gitsigns')
    gitsigns.setup({
      preview_config = {
	border = "rounded",
	style = "minimal",
      },
    })

    vim.keymap.set('n', '<Leader>gl', function()
      gitsigns.blame_line({ full = false,})
    end, { desc = 'Git blame (hash • author • message)' })
  end
}
