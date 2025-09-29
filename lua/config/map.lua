-- ANCHOR: Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<Leader>w",  "<Cmd>w<CR>", {desc = "Save"})
vim.keymap.set("n", "<Leader>q",  "<Cmd>confirm q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<Leader>c", require("config.my-utils").smart_bdelete, { desc = "Close buffer safely" })
vim.keymap.set("n", "<Leader>ld", vim.diagnostic.open_float)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", "<Cmd>bprev<CR>", { desc = "Move to previous buffer" })
vim.keymap.set("n", "<S-l>", "<Cmd>bnext<CR>", { desc = "Move to next buffer" })

vim.keymap.set("n", "grn", function()
  if vim.lsp.buf.rename then
    vim.lsp.buf.rename()
  else
    vim.notify("LSP rename not available", vim.log.levels.WARN)
  end
end, { desc = "LSP: Rename symbol" })
