return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
	  library = {
	    -- See the configuration section for more details
	    -- Load luvit types when the `vim.uv` word is found
	    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
	  },
	},
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Define on_attach
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }

        vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
        vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, opts)
        vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>la', require("config.lsp-utils").filtered_code_action, opts)
        vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

	-- Try to remove unwanted code actions
	-- local caps = client.server_capabilities
	-- if caps.codeActionProvider and caps.codeActionProvider.codeActionKinds then
	--   caps.codeActionProvider.codeActionKinds =
	--     vim.tbl_filter(function(kind)
	--       return kind ~= "source.organizeImports"
	--     end, caps.codeActionProvider.codeActionKinds)
	-- end
      end

      lspconfig.lua_ls.setup { on_attach = on_attach, }
      lspconfig.ts_ls.setup { on_attach = on_attach, }
      lspconfig.eslint.setup { on_attach = on_attach, }
      lspconfig.jsonls.setup { on_attach = on_attach, }
      lspconfig.graphql.setup { on_attach = on_attach, }
      lspconfig.tailwindcss.setup { on_attach = on_attach, }
      lspconfig.cssls.setup { on_attach = on_attach, }
      lspconfig.css_variables.setup { on_attach = on_attach, }
    end,
  }
}
