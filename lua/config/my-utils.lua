local M = {}

M.smart_bdelete = function ()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs > 1 then
    vim.cmd("bp | bd #")      -- go to previous buffer, delete the one we were on
  else
    vim.cmd("enew | bd #")    -- open a new empty buffer, then delete the old one
  end
end

return M
