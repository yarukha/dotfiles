-- THESE SHOULD BE ORDERED BY IMPORTANCE, WITH THE ONES MORE LIKELY TO BE REMOVED ON TOP
-- MAYBE EVEN MAKE A SEPARATE CONFIG FILE FOR PLUGINS WE NEVER CHANGE

return {

	-- lazygit inside nvim
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

	-- vim spreadsheet editing, use <leader>+sc
	{ "mipmip/vim-scimark", event = { "BufReadPre *.norg", "BufNewFile *.norg" } },

	-- Lean proofs
	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },

		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",

			-- optional dependencies:

			-- a completion engine
			--    hrsh7th/nvim-cmp or Saghen/blink.cmp are popular choices

			-- 'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
			-- 'andymass/vim-matchup',          -- for enhanced % motion behavior
			-- 'andrewradev/switch.vim',        -- for switch support
			-- 'tomtom/tcomment_vim',           -- for commenting
		},

		---@type lean.Config
		opts = { -- see below for full configuration options
			mappings = true,
		},
	},

	-- Agda proofs
	"ashinkarov/nvim-agda",
	-- Isabelle proofs
	"Treeniks/isabelle-lsp.nvim",
	-- coq proofs
	{ "whonore/Coqtail" },
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
	-- note taking akin to emacss org mode
	-- {
	-- 	"nvim-neorg/neorg",
	-- 	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	-- 	version = "*", -- Pin Neorg to the latest stable release
	-- 	config = require("neorg").setup({
	-- 		load = {
	-- 			["core.defaults"] = {},
	-- 			["core.concealer"] = {}, -- We added this line!
	-- 		},
	-- 	}),
	-- },
	-- translates ascii symbols into unicode
	-- { "tlaplus-community/tlaplus-nvim-plugin", lazy = false },

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
}
