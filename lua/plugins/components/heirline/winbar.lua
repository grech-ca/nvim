local FilePath = {
  init = function (self)
    local absolutePath = vim.api.nvim_buf_get_name(0)
    local relativePath = vim.fn.system("git ls-files --full-name -- \"" .. absolutePath .. "\""):gsub("%z", ""):gsub("\n", "")
    self.filepath = " " .. relativePath or absolutePath .. " "
  end,
  condition = function ()
    local bt = vim.api.nvim_get_option_value("buftype", { buf = 0 })
    local ft = vim.bo.filetype
    local excluded_filetypes = {
      "TelescopePrompt",
      "TelescopeResults",
      "NvimTree",
      "neo-tree",
      "lazy",
      "help",
      "qf",
      "netrw",
      "fugitive",
      "Outline",
      "toggleterm",
      "Trouble",
      "",
    }

    return bt == "" and not vim.tbl_contains(excluded_filetypes, ft)
  end,
  provider = function(self)
    return self.filepath
  end,
  hl = {bg = "#4433CC", fg = "#CCCCCC"}
}

local WinBar = {
  -- TODO: Fix flickering
  -- FilePath,
}

return WinBar
