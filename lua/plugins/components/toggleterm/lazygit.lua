local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({cmd = "lazygit", hidden = true})

return {
  instance = lazygit,
  toggle = function ()
    lazygit:toggle()
  end
}
