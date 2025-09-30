return {
  "numToStr/Comment.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

      toggler = {
	  ---Line-comment toggle keymap
	  line = 'gcc',
	  ---Block-comment toggle keymap
	  block = 'gbc',
      },
      opleader = {
	  ---Line-comment keymap
	  line = 'gc',
	  ---Block-comment keymap
	  block = 'gb',
      },
    })
  end,
}
