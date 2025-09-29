local M = {}

M.filtered_code_action = function()
  local blacklist = {
    -- Typescript
    "^Move to a new file$",
    "Inline variable",
    "^Fix this [a-zA-Z-\\d/]+ problem$",
    "^Convert to named function$",
    "^Convert named imports to namespace import$",
    "Convert to template string",
    "Extract to function in module scope",
    "Extract to inner function in function '.*'",
    "Extract to constant in enclosing scope",
    "Extract to constant in module scope",
    "Disable .* for this line",
    "Disable .* for the entire file",
    "Show documentation for .*",
    "Convert named imports to default import",

    -- Prettier
    "Disable prettier/prettier for the entire file",
    "Disable prettier/prettier for this line",
    "Show documentation for prettier/prettier",
    "Fix all prettier/prettier problems",
  }

  vim.lsp.buf.code_action({
    filter = function(action)
      for _, pattern in ipairs(blacklist) do
        if action.title:match(pattern) then
          return false
        end
      end
      return true
    end,
  })
end

return M
