local M = {}

M.general = {
  n = {
    [";"] = { "."},
    ["<C-b>"] = {"<cmd> NvimTreeToggle<CR>" ,"Toggle nvimtree"},
    ["<C-p>"] = {"<cmd> Telescope find_files <CR>"},
    ["<C-h>"] = {"<cmd> TmuxNavigateLeft<CR>"},
    ["<C-j>"] = {"<cmd> TmuxNavigateDown<CR>"},
    ["<C-k>"] = {"<cmd> TmuxNavigateUp<CR>"},
    ["<C-l>"] = {"<cmd> TmuxNavigateRight<CR>"},


  },
}

-- more keybinds!

return M
