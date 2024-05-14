local overrides = require "custom.configs.overrides"
local telescope = require "telescope"

---@type NvPluginSpec[]
local plugins = {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- { "Ionide/Ionide-vim" },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    opts = { separator = "-" },
  },
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },
  {
    "nvim-telescope/telescope-media-files.nvim",
    config = function()
      telescope.load_extension "media_files"
    end,
  },

  {
    "davvid/telescope-git-grep.nvim",
    config = function()
      telescope.load_extension "frecency"
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      telescope.load_extension "frecency"
    end,
  },

  {
    "lervag/vimtex",
    init = function()
      -- Use init for configuration, don't use the more common "config".
    end,
  },
  { "typicode/bg.nvim", lazy = false },
  { "sindrets/diffview.nvim" },
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
    opts = {
      auto_install = true,
      ensure_installed = {
        "c",
        "lua",
        "python",
        "vim",
        "ocaml",
        "ocaml_interface",
        "ocamllex",
        "menhir",
        "haskell",
        "git_config",
      },
      highlight = { enable = true },
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
}

return plugins
