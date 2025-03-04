return {
	{ "tlaplus-community/tlaplus-nvim-plugin", lazy = false },
	{ "xiyaowong/transparent.nvim", lazy = false },
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = require("configs.conform").formatters_by_ft,
			})
		end,
	},
	"AndrewRadev/linediff.vim",

	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
		opts = { separator = "-" },
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
		opts = {
			git = {
				enable = true,
			},

			renderer = {
				highlight_git = true,
				icons = {
					show = {
						git = true,
					},
				},
			},
		},
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
	},

	{
		"lervag/vimtex",
		init = function()
			-- Use init for configuration, don't use the more common "config".
		end,
	},
	{ "typicode/bg.nvim", lazy = false },
	{ "sindrets/diffview.nvim" },
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
}
