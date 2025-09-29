local conditions = require("heirline.conditions")

local TabLineOffset = {
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        local bufnr = vim.api.nvim_win_get_buf(win)
        self.winid = win

        if vim.bo[bufnr].filetype == "neo-tree" then
            self.title = ""
            return true
        -- elseif vim.bo[bufnr].filetype == "TagBar" then
        --     ...
        end
    end,

    provider = function(self)
        local title = self.title
        local width = vim.api.nvim_win_get_width(self.winid)
        local pad = math.ceil((width - #title) / 2)
        return string.rep(" ", pad) .. title .. string.rep(" ", pad)
    end,

    hl = function(self)
        if vim.api.nvim_get_current_win() == self.winid then
            return "TablineSel"
        else
            return "Tabline"
        end
    end,
}

local Clock = {
  provider = function()
    return "   " .. os.date("%H:%M") .. "  "
  end,
  hl = { fg = "white", bg = "black", bold = true },
}

local Separator = {
  provider = " ",
  hl = { fg = "white" }
}

local Align = { provider = "%=" }

local Diagnostics = {

    condition = conditions.has_diagnostics,

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and ("  " .. self.errors .. "  ")
        end,
        hl = { fg = "white", bg = "#FF4400", bold = true },
    },
    {
        provider = function(self)
            return self.warnings > 0 and ("  " .. self.warnings .. "  ")
        end,
        hl = { fg = "white", bg = "#FF9900", bold = true },
    },
    {
        provider = function(self)
            return self.info > 0 and ("  " .. self.info .. "  ")
        end,
        hl = { fg = "white", bg = "#4488FF", bold = true },
    },
    {
        provider = function(self)
            return self.hints > 0 and ("  " .. self.hints .. "  ")
        end,
        hl = { fg = "white", bg = "#33AA44", bold = true },
    },
    Separator,
}

local ope_code_cache = ""

-- update function
local function update_ope_code()
  local branch = vim.fn.systemlist(
    "git -C " .. vim.fn.expand("%:p:h") .. " rev-parse --abbrev-ref HEAD"
  )[1] or ""
  local num = branch:match("%-ope%-(%d+)%-")
  ope_code_cache = num and ("OPE-" .. num) or ""
end

-- Replace the sync cache + updater with this (near lines ~88+)

local ope = { cache = nil, updating = false }

local function refresh_ope_code()
  if ope.updating then return end
  ope.updating = true

  local cwd = vim.fn.expand("%:p:h")
  vim.system({ "git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }, function(obj)
    local branch = (obj.stdout or ""):gsub("%s+$", "")
    local num = branch:match("%-ope%-(%d+)%-")
    local new = num and ("OPE-" .. num) or ""

    if new ~= ope.cache then
      ope.cache = new
      vim.schedule(function() vim.cmd("redrawstatus") end)
    end
    ope.updating = false
  end)
end

-- Replace the OpeCode component (near line ~100)
local OpeCode = {
  init = function()
    if ope.cache == nil then refresh_ope_code() end
  end,
  update = { "BufEnter", "DirChanged", "BufWritePost" }, -- when it makes sense to refresh
  provider = function()
    -- keep a minimal stable width even when empty to reduce layout jumps
    local label = (ope.cache and ope.cache ~= "" and (" " .. ope.cache .. " "))
    return label
  end,
  on_click = {
    callback = function()
      if ope.cache and ope.cache ~= "" then
        local url = "https://linear.app/worldcoin/issue/" .. ope.cache
        -- cross-platform open (macOS 'open', Linux 'xdg-open', Windows 'start')
        if vim.fn.has("mac") == 1 then
          vim.fn.jobstart({ "open", url }, { detach = true })
        elseif vim.fn.has("unix") == 1 then
          vim.fn.jobstart({ "xdg-open", url }, { detach = true })
        else
          vim.fn.jobstart({ "cmd", "/c", "start", url }, { detach = true })
        end
      end
    end,
    name = "linear_open",
  },
  hl = { fg = "#ffffff", bg = "#4433CC" },
}


local SearchCount = {
    condition = function()
        return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
    end,
    init = function(self)
        local ok, search = pcall(vim.fn.searchcount)
        if ok and search.total then
            self.search = search
        end
    end,
    provider = function(self)
        local search = self.search
        return string.format("   %d/%d ", search.current, math.min(search.total, search.maxcount))
    end,
    hl = { fg = "black", bg = "yellow" }
}

local StatusLine = {
  TabLineOffset,
  Diagnostics,
  Align,
  -- TODO: Fix cursor flickering
  OpeCode,
  SearchCount,
  Clock,
}

return StatusLine
