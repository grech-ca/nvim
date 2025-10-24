vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.fillchars = {eob = " "}
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 2

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.hlsearch = true
vim.o.incsearch = true  -- highlights as you type

vim.opt.ignorecase = true
vim.opt.wrap = false

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 100 }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    vim.bo.indentexpr = ""
  end,
})

