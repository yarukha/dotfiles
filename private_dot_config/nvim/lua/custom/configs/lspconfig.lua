local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers =
  { "html", "cssls", "tsserver", "clangd", "jedi_language_server", "metals", "ocamllsp", "typst_lsp", "hls", "bashls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.typst_lsp.setup{
  on_attach = on_attach,
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
--
-- lspconfig.pyright.setup { blabla}
