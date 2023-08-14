local overrides = require "custom.configs.overrides"

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
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "ocaml",
        "python",
        "c",
        "latex",
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
    "f3fora/nvim-texlabconfig",
    config = function()
      require("texlabconfig").setup {}
    end,
    ft = { 'tex', 'bib' }, -- Lazy-load on filetype
    build = "go build -o ~/.local/bin/",
    -- build = 'go build -o ~/.bin/' if e.g. ~/.bin/ is in $PATH
  },
}

return plugins
