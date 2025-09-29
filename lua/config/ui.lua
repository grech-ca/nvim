local border = "rounded"

vim.lsp.util.open_floating_preview = (function(original)
  return function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return original(contents, syntax, opts, ...)
  end
end)(vim.lsp.util.open_floating_preview)

vim.diagnostic.config({
  float = {
    border = border,
    header = "",
    prefix = "",
    source = "if_many",
    format = function(diagnostic)
      return diagnostic.message -- <-- Only show the message, no error codes
    end,
  },
})

-- Override FloatBorder highlight group
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
