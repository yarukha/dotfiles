-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "clangd",
  "jedi_language_server",
  "metals",
  "ocamllsp",
  "tinymist",
  "hls",
  "bashls",
  "rust_analyzer",
  "fsautocomplete",
  "markdown_oxide",
  "denols",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- lspconfig.typst_lsp.setup {
--   on_attach = on_attach,
-- }

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

lspconfig.texlab.setup {
  -- filetypes = { "tex", "sty", "bib" },
  settings = {
    texlab = {
      auxDirectory = "../build",
      bibtexFormatter = "texlab",
      build = {
        args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
        executable = "tectonic",
        -- forwardSearchAfter = false,
        -- onSave = true,
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = false,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      -- forwardSearch = {
      --   executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
      --   args = {"%l","%p","%f"},
      -- },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = true,
      },
    },
  },
}
