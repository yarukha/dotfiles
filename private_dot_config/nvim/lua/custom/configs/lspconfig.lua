-- :help lspconfig-all to see list of available lsps
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "nil_ls", "clangd", "ocamllsp", "marksman", "yamlls", "bashls","hls","typst_lsp" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
        },
        onSave = true,
        forwardSearchAfter = false,
      },
      auxDirectory = ".",
      forwardSearch = {
        executable = "okular",
        args = { "--unique", "file:%p#src:%l%f" },
      },
      chktex = {
        onOpenAndSave = true,
        onEdit = true,
      },
      diagnosticsDelay = 300,
      latexFormatter = "latexindent",
      latexindent = {
        ["local"] = nil, -- local is a reserved keyword
        modifyLineBreaks = false,
      },
      bibtexFormatter = "texlab",
      formatterLineLength = 80,
    },
  },
}
