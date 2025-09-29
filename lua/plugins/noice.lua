return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function(_, opts)
    require('noice').setup({
      routes = {
	{
	  filter = {
	    event = "notify",
	    kind = "info",
	    find = "No information available"
	  },
	  opts = { skip = true },
	},
	{
	  filter = {
	    event = "notify",
	    kind = "info",
	    find = "# Plugin Updates"
	  },
	  opts = { skip = true },
	},
	{
	  filter = {
	    event = "msg_show",
	    kind = "emsg",
	    find = "E486"
	  },
	  opts = { skip = true },
	},
	{
	  filter = {
	    event = "msg_show",
	    kind = "emsg",
	    find = "E382"
	  },
	  opts = { skip = true },
	},
	{
	  filter = {
	    event = "msg_show",
	    kind = "",
	    find = "written",
	  },
	  opts = { skip = true },
	},
	{
	  filter = {
	    event = "msg_show",
	    kind = "",
	    find = "line less",
	  },
	  opts = { skip = true },
	},
	{
	  filter = {
	    event = "msg_show",
	    kind = "",
	    find = "written",
	  },
	  opts = { skip = true },
	},
	-- Skip the “N lines more / fewer lines” messages
	{
	  filter = {
	    event = "msg_show",
	    kind = "",
	    any = {
	      { find = "more lines" },
	      { find = "fewer lines" },
	      { find = "%d+L, %d+B" },  -- e.g. “58L, 1404B”
	    },
	  },
	  opts = { skip = true },
	},
	-- Skip search‐count messages (e.g. “[3/10]”) if you don’t want them
	{
	  filter = {
	    event = "msg_show",
	    kind = "search_count",
	  },
	  opts = { skip = true },
	},
	-- You can skip notifications too (if you use Vim plugins or LSP sending via notify)
	{
	  filter = {
	    event = "notify",
	    -- maybe a pattern you often see
	    find = "No information",
	  },
	  opts = { skip = true },
	},
	-- Optionally: skip *all* msg_show with no kind (i.e. general messages)
	{
	  filter = {
	    event = "msg_show",
	    kind = "",
	  },
	  opts = { skip = true },
	},
      },
      presets = {
	-- bottom_search = true, -- use a classic bottom cmdline for search
	-- command_palette = true, -- position the cmdline and popupmenu together
	-- long_message_to_split = true, -- long messages will be sent to a split
	-- inc_rename = false, -- enables an input dialog for inc-rename.nvim
	lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      popupmenu = { backend = "nui" },
    })
  end
}
