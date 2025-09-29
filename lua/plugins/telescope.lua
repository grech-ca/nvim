return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
	build = 'make',
      },
    },
    opts = {
      defaults = {
        layout_config = {
          prompt_position = "top",
        },
	sorting_strategy = "ascending"
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",         -- or "ignore_case" or "respect_case"
        },
	["ui-select"] = {
	  require("telescope.themes").get_dropdown {}
	}
      },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('fzf')
      telescope.load_extension("ui-select")

      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
      -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>lD', builtin.diagnostics, { desc = 'Telescope diagnostics' })
      -- vim.keymap.set('n', '<leader>fI', builtin.lsp_implementations, { desc = 'Telescope implementations' })
    end
  },
}
