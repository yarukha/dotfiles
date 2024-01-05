local overrides = require "custom.configs.overrides"
local leet_arg = "leetcode.nvim"
---@type NvPluginSpec[]
local plugins = {

  -- plugins/telescope.lua:
  {
    "nosduco/remote-sshfs.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("remote-sshfs").setup {}
      require("telescope").load_extension "remote-sshfs"
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-null-ls").setup {
        handlers = {},
      }
    end,
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
  },
  -- Override plugin definition options
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
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
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

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
