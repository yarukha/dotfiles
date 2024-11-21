local null_ls = require "null-ls"

local b = null_ls.builtins

local helpers = require "null-ls.helpers"
local methods = require "null-ls.methods"

local typstfmt = helpers.make_builtin {
  name = "typstfmt",
  meta = {
    url = "https://github.com/astrale-sharp/typstfmt",
    description = "Basic formatter for the Typst language with a future!",
  },
  method = methods.internal.FORMATTING,
  filetypes = { "typst" },
  generator_opts = { command = "typstfmt", args = { "--stdout" }, to_stdin = true },
  factory = helpers.formatter_factory,
}

local sources = {

  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "toml" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,
  -- cpp
  b.formatting.clang_format,
  -- ocaml
  b.formatting.ocamlformat,
  --bash
  b.formatting.shfmt,
  --latex
  require("none-ls.formatting.latexindent"),
  --fsarhp
  b.formatting.fantomas,
  --markdown
  b.formatting.mdformat,

  --typst
  typstfmt,
  --rust
  -- b.formatting.rustfmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
