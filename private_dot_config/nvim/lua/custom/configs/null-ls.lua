local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "toml","markdown" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
  b.formatting.ocamlformat,
  b.formatting.latexindent,

  b.formatting.nixpkgs_fmt,
  b.formatting.fish_indent,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
