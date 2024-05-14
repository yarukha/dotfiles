vim.opt.scrolloff = 8
vim.opt.spelllang = "fr"
-- vim.opt.textwidth = 100
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.loader.enable()

local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.fs,*.fsx,*.fsi",
  command = [[set filetype=fsharp]],
})

-- vim.cmd [[command W :execute ':silent w !sudo tee % > /dev/null' | :edit!]]

-- vim.filetype.add { extension = { typ = "typst" } }

-- vim.api.nvim_create_autocmd({
--   "BufWinLeave",
-- }, {
--   pattern = "*.tex",
--   callback = function()
--     if vim.fn.expand "%" ~= "" then
--       vim.cmd "mkview"
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd({
--   "BufWinEnter",
-- }, {
--   pattern = "*.tex",
--   callback = function()
--     if vim.fn.expand "%" ~= "" then
--       vim.cmd "silent loadview"
--     end
--   end,
-- })
