return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    -- vsnip users
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",

    -- if you want luasnip instead of vsnip, replace with:
    -- "L3MON4D3/LuaSnip",
    -- "saadparwaiz1/cmp_luasnip",
  },
  config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            -- for vsnip
            vim.fn["vsnip#anonymous"](args.body)
            -- for luasnip:
            -- require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
	  -- Tab and Shift-Tab to navigate completion
	  ["<Tab>"] = cmp.mapping(function(fallback)
	    if cmp.visible() then
	      cmp.select_next_item()
	    else
	      fallback() -- insert tab if not in completion
	    end
	  end, { "i", "s" }),

	  ["<S-Tab>"] = cmp.mapping(function(fallback)
	    if cmp.visible() then
	      cmp.select_prev_item()
	    else
	      fallback() -- insert shift-tab normally
	    end
	  end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          -- { name = "vsnip" }, -- or luasnip/ultisnips/snippy
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })

      -- Extend LSP capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      -- replace <YOUR_LSP_SERVER> with your servers (e.g. tsserver, eslint)
      lspconfig["ts_ls"].setup({ capabilities = capabilities })
      lspconfig["eslint"].setup({ capabilities = capabilities })
    end,
}
