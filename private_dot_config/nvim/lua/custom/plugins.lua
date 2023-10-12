local overrides = require "custom.configs.overrides"
local games = require "custom.games"

---@type NvPluginSpec[]
local plugins = {


  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override_by_extension = {
        ["ml"] = {
          icon = "🐫",
          name = "ocaml",
        },
      },
      override_by_filename = {
        ["dune"] = {
          icon = "💩",
          name = "dune",
        },
      },
    },
  },
  {
    "NvChad/nvterm",
    enabled = false,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "lua-language-server", "marksman", "yaml-language-server", "bash-language-server" } },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- config = function()
    --   local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    --   parser_config.typst = {
    --     install_info = {
    --       url = "https://github.com/SeniorMars/tree-sitter-typst", -- local path or git repo
    --       files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    --       -- optional entries:
    --       branch = "main", -- default branch in case of git repo if different from master
    --       generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    --       requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    --     },
    --     filetype = "typst", -- if filetype does not match the parser name
    --   }
    -- end,
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "ocaml",
        "python",
        "c",
        "latex",
        "elm",
        -- "typst",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  { "christoomey/vim-tmux-navigator", lazy = false },
  {
    "VidocqH/lsp-lens.nvim",
    config = function()
      require("lsp-lens").setup {
        enable = true,
        include_declaration = false, -- Reference include declaration
        sections = { -- Enable / Disable specific request
          definition = true,
          references = false,
          implements = true,
        },
        ignore_filetype = {
          "prisma",
        },
      }
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {}
    end,
    lazy = false,
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
  },
  {
    "dstein64/vim-startuptime",
  },

  games,
}

return plugins
