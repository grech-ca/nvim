-- lua/plugins/gitsigns.lua
return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = "VeryLazy",
  config = function()
    local gitsigns = require('gitsigns')
    gitsigns.setup({
      preview_config = {
        border = "rounded",
        style = "minimal",
      },
      -- Show deleted lines as virtual text
      show_deleted = false, -- Toggle with <Leader>gD
    })

    -- Blame
    vim.keymap.set('n', '<Leader>gl', function()
      gitsigns.blame_line({ full = false })
    end, { desc = 'Git blame line' })

    -- Diff preview (inline in current buffer)
    vim.keymap.set('n', '<Leader>gp', gitsigns.preview_hunk_inline, { desc = 'Preview hunk inline' })
    vim.keymap.set('n', '<Leader>gP', gitsigns.preview_hunk, { desc = 'Preview hunk (popup)' })

    -- Toggle deleted lines visibility
    vim.keymap.set('n', '<Leader>gD', gitsigns.toggle_deleted, { desc = 'Toggle deleted lines' })

    -- Toggle word diff
    vim.keymap.set('n', '<Leader>gw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff' })

    -- Navigate between hunks
    vim.keymap.set('n', ']g', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(gitsigns.next_hunk)
      return '<Ignore>'
    end, { expr = true, desc = 'Next git hunk' })

    vim.keymap.set('n', '[g', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(gitsigns.prev_hunk)
      return '<Ignore>'
    end, { expr = true, desc = 'Previous git hunk' })

    -- Stage/reset hunks (for quick edits)
    vim.keymap.set('n', '<Leader>gs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
    vim.keymap.set('n', '<Leader>gr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
    vim.keymap.set('n', '<Leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })

    -- Visual mode: stage/reset selection
    vim.keymap.set('v', '<Leader>gs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'Stage selected' })
    vim.keymap.set('v', '<Leader>gr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'Reset selected' })
  end
}
