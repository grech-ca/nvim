return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  lazy = vim.fn.argc(-1) == 0, -- load treesitter immediately when opening a file from the cmdline
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      ensure_installed = {
        "typescript",
        "tsx",
        "javascript",
        "graphql",
        "css",
        "html",
        "json",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline"
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      indent = { enable = true },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
