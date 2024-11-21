local overrides = require "custom.configs.overrides"
local telescope = require "telescope"

---@type NvPluginSpec[]
local plugins = {
  {
    "AndrewRadev/linediff.vim",
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      }

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },

  {
    "3rd/image.nvim",
    config = function()
      -- ...
    end,
  },
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

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-frecency.nvim",
      },
    },
    opts = function(_, opts)
      opts.extensions = {
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
        },
        -- ... also accepts theme settings, for example:
        theme = "ivy", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      }
    end,
    keys = {
      {
        "<leader>fw",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Grep (root dir)",
      },
    },
    config = function(_, opts)
      local tele = require "telescope"
      tele.setup(opts)
      tele.load_extension "live_grep_args"
      tele.load_extension "media_files"
      tele.load_extension "frecency"
    end,
  },
  {
    "lervag/vimtex",
    init = function()
      -- Use init for configuration, don't use the more common "config".
    end,
  },
  { "typicode/bg.nvim",      lazy = false },
  { "sindrets/diffview.nvim" },
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
        "nvimtools/none-ls.nvim",
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
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
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
      ignore_install = { "org" },
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
