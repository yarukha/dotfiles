local prover_plugins = require("plugins.provers")
local utils_plugins = require("plugins.utils")

-- THESE SHOULD BE ORDERED BY IMPORTANCE, WITH THE ONES MORE LIKELY TO BE REMOVED ON TOP
-- MAYBE EVEN MAKE A SEPARATE CONFIG FILE FOR PLUGINS WE NEVER CHANGE

local all_plugins = vim.list_extend({}, prover_plugins)
all_plugins = vim.list_extend(all_plugins, utils_plugins)
table.insert(all_plugins, {
	-- images
	{ "3rd/image.nvim" },
	-- vim spreadsheet editing, use <leader>+sc
	{ "mipmip/vim-scimark", event = { "BufReadPre *.norg", "BufNewFile *.norg" } },

	-- new surround actions, use ysiw ""
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- enable transparency
	{ "xiyaowong/transparent.nvim", lazy = false },

	-- :Linediff to diff two blocks
	"AndrewRadev/linediff.vim",

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

	-- BELOW SHOULD NOT BE CHANGED
	--
	--
	--

	-- lsp config
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	-- formatting
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = require("configs.conform").formatters_by_ft,
			})
		end,
	},

	-- treesitter config
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
})

return all_plugins
