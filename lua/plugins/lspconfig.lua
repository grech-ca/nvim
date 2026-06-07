local util = require('lspconfig.util')
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
	-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
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
      lspconfig.graphql.setup {
        on_attach = on_attach,
        filetypes = { "graphql", "typescriptreact", "typescript", "javascriptreact", "javascript" },
        root_dir = util.root_pattern('.graphqlrc*', 'graphql.config.*'),
      }
      lspconfig.tailwindcss.setup{
	on_attach = on_attach,
	root_dir = util.root_pattern('tailwind.config.ts','tailwind.config.js','package.json','.git'),
	on_new_config = function(new_config, new_root_dir)
	  local globals_css = new_root_dir .. "/app/globals.css"
	  local index_css = new_root_dir .. "/src/index.css"
	  local tailwind_ts = new_root_dir .. "/tailwind.config.ts"
	  local tailwind_js = new_root_dir .. "/tailwind.config.js"

	  if vim.uv.fs_stat(globals_css) then
	    new_config.settings.tailwindCSS.experimental.configFile = globals_css
	  elseif vim.uv.fs_stat(index_css) then
	    new_config.settings.tailwindCSS.experimental.configFile = index_css
	  elseif vim.uv.fs_stat(tailwind_ts) then
	    -- For Tailwind v4, we don't want to use an empty tailwind.config.ts as the config file.
	    -- Check package.json dependencies to see if we're using Tailwind v4.
	    local has_v4 = false
	    local package_json = new_root_dir .. "/package.json"
	    if vim.uv.fs_stat(package_json) then
	      local f = io.open(package_json, "r")
	      if f then
		local content = f:read("*a")
		f:close()
		if content:find('"tailwindcss":%s*"%^4') or content:find('"@tailwindcss/postcss":%s*"%^4') then
		  has_v4 = true
		end
	      end
	    end

	    if has_v4 then
	      new_config.settings.tailwindCSS.experimental.configFile = nil
	    else
	      new_config.settings.tailwindCSS.experimental.configFile = tailwind_ts
	    end
	  elseif vim.uv.fs_stat(tailwind_js) then
	    new_config.settings.tailwindCSS.experimental.configFile = tailwind_js
	  else
	    new_config.settings.tailwindCSS.experimental.configFile = nil
	  end
	end,
	settings = {
	  tailwindCSS = {
	    experimental = {
	      configFile = nil, -- dynamically set in on_new_config
	    },
	    classAttributes = {
	      "(([a-zA-Z\\d]+C)|c)lassName"
	    }
	  },
	},
      }
      lspconfig.cssls.setup { on_attach = on_attach, }
      lspconfig.css_variables.setup { on_attach = on_attach, }
      lspconfig.prismals.setup { on_attach = on_attach, }
    end,
  }
}
