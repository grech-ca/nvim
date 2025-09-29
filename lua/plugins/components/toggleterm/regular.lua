local Terminal = require("toggleterm.terminal").Terminal
local regularTerminal = Terminal:new({hidden = true})

return {
  instance = regularTerminal,
  toggle = function ()
    regularTerminal:toggle()
  end
}
