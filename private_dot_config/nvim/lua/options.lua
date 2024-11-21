require "nvchad.options"

-- add yours here!

vim.opt.scrolloff = 8
vim.opt.spelllang = "en"
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

-- disable semantic tokens
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})


