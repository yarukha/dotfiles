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

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "toml" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,
  -- cpp
  b.formatting.clang_format,
  -- ocaml
  b.formatting.ocamlformat,
  -- haskell
  b.formatting.fourmolu,
  --bash
  b.formatting.beautysh,
  --latex
  b.formatting.latexindent,

  --typst
  typstfmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
