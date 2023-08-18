-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
--
vim.opt.scrolloff = 8
vim.opt.spelllang = "fr"
vim.opt.textwidth = 100
vim.opt.colorcolumn = "100"
vim.cmd [[command W :execute ':silent w !sudo tee % > /dev/null' | :edit!]]
vim.api.nvim_create_autocmd({
  "BufWinLeave",
}, {
  pattern = "*.tex",
  callback = function()
    if vim.fn.expand "%" ~= "" then
      vim.cmd "mkview"
    end
  end,
})
vim.api.nvim_create_autocmd({
  "BufWinEnter",
}, {
  pattern = "*.tex",
  callback = function()
    if vim.fn.expand "%" ~= "" then
      vim.cmd "silent loadview"
    end
  end,
})
