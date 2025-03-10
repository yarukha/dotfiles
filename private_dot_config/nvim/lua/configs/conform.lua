return {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    yml = { "prettier"},
    html = { "prettier" },
    cpp = { "clang-format" },
    ocaml = { "ocamlformat" },
    typst = { "typstyle" },
    bash = { "beautysh" },
    latex = { "latexindent" },
    fsharp = { "fantomas" },
    haskell = { "formolu" },
    nix = { "nixfmt" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}
