return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {"3rd/image.nvim", opts = {}},
  },
  lazy = false,
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    close_if_last_window = true,
    source_selector = {
      truncation_character = "…",
      winbar = true,
      content_layout = "center",
      sources = {
        {
          source = "filesystem",                                -- string
          display_name = " 󰉓 Files "                            -- string | nil
        },
        {
          source = "git_status",                                -- string
          display_name = " 󰊢 Git "                              -- string | nil
        },
      }
    },
    window = {
      mappings = {
        ["i"] = "run_command",
        ["Y"] = "copy_relative_path",
        ["<S-l>"] = "next_source",
        ["<S-h>"] = "prev_source",

        ["H"] = false,
        ["S"] = false,
        ["<"] = false,
        [">"] = false,
      }
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {},
      },
      follow_current_file = {
        enabled = true
      }
    },
    commands = {
      run_command = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.api.nvim_input(": " .. path .. "<Home>")
      end,
      copy_relative_path = function(state)
        vim.fn.setreg("+", vim.fn.fnamemodify(state.tree:get_node().path, ":."))
        vim.notify("Copied relative path!")
      end,
      toggle = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" then
          state.commands.toggle_directory(state, node)
        else
          state.commands.run_command(state)
        end
      end
    }
  },
  config = function(_, opts)
    local neotree = require("neo-tree")
    neotree.setup(opts)

    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })
    -- vim.keymap.set("n", "<leader>f", "<cmd>Neotree reveal<CR>", { desc = "Reveal in NeoTree" })
    -- vim.keymap.set("n", "<leader>r", "<cmd>Neotree reveal<CR>", { desc = "Reveal in NeoTree" })
  end
}
