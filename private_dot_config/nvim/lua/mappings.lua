require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

map("n", "<C-b>", "<cmd> NvimTreeToggle<CR>", { desc = "Toggle nvimtree" })
map("n", "<leader>e", "<cmd> setlocal spell!<CR>", { desc = "Toggle spellcheck" })
map("n", "gC", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { desc = "Goto context" })
map("n", "cc", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
map("n", "gn", function()
	vim.diagnostic.goto_next({ float = { border = "rounded" }, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Goto next" })

map("n", "gN", function()
	vim.diagnostic.goto_prev({ float = { border = "rounded" }, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Goto prev" })

map("n", "<leader>fw", function()
	require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "live grep (w/args)" })

map("n", "K", function()
	vim.lsp.buf.hover()
end, { desc = "LSP hover" })

vim.keymap.set("", "<leader>fm", function()
	require("conform").format({ async = true, lsp_fallback = true })
end)
