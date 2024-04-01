---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<C-b>"] = { "<cmd> NvimTreeToggle<CR>", "Toggle nvimtree" },
    -- ["<C-p>"] = { "<cmd> Telescope find_files <CR>" },
    ["<leader>e"] = { "<cmd> setlocal spell!<CR>" },
    -- ["<leader>g"] = { "<cmd> Telescope live_grep <CR>" },
    ["<leader>i"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["gn"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" }, severity = vim.diagnostic.severity.ERROR }
      end,
      "Goto next",
    },
    ["gN"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" }, severity = vim.diagnostic.severity.ERROR }
      end,
      "Goto prev",
    },
  },
  t = {
    ["<leader>i"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },
  },
}

-- more keybinds!

return M
