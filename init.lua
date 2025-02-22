vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

local opt = vim.opt

-- appearance
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.background = "dark"
opt.fillchars = "eob: "
opt.laststatus = 0
opt.pumheight = 8

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.wrap = false

-- better search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- persistent copy & undo
opt.clipboard = "unnamedplus"
opt.undofile = true

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- gitsigns
	{ "lewis6991/gitsigns.nvim" },
	-- colorscheme
	{
		"anAcc22/sakura.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("sakura")

			local bg = "#191719"
			local highlights = {
				WinSeparator = { fg = bg },
				NvimTreeNormal = { bg = bg },
			}

			-- set highlight colors
			for group, colors in pairs(highlights) do
				vim.api.nvim_set_hl(0, group, colors)
			end
		end,
	},
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"c",
				"rust",
				"python",
				"lua",
				"javascript",
				"typescript",
				"html",
				"css",
				"svelte",
				"gitignore",
				"toml",
				"json",
				"make",
				"markdown",
				"yaml",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
	-- lsp
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", vim.lsp.buf.definition, "goto definition")
					map("gD", vim.lsp.buf.declaration, "goto declaration")
					map("gt", vim.lsp.buf.type_definition, "goto type")
					map("K", vim.lsp.buf.hover, "show docs")
					map("J", vim.diagnostic.open_float, "show error")
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				clangd = {},
				pyright = {},
				rust_analyzer = {},
				ts_ls = {},
				lua_ls = {},
				html = {},
				cssls = {},
				tailwindcss = {},
				svelte = {},
			}
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"prettier",
				"stylua",
				"isort",
				"black",
				"clang-format",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	-- autoformat
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.bo[bufnr].filetype == "c" then
					return {
						timeout_ms = 1000,
						lsp_format = "never",
						lsp_fallback = false,
						async = false,
					}
				end

				return {
					timeout_ms = 1000,
					lsp_format = "fallback",
					lsp_fallback = true,
					async = false,
				}
			end,
			formatters = {
				rustfmt = {
					command = "rustfmt",
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
			},
		},
	},
	-- cmp
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					documentation = false,
				},
				formatting = {
					fields = { "abbr", "kind" },
					format = lspkind.cmp_format({
						maxwidth = 20,
						ellipsis_char = "...",
					}),
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},
	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local nvimtree = require("nvim-tree")

			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			nvimtree.setup({
				view = {
					width = 35,
					side = "right",
				},
				filters = {
					dotfiles = true,
				},
				renderer = {
					root_folder_label = function(path)
						return vim.fn.fnamemodify(path, ":t")
					end,
					icons = {
						glyphs = {
							git = {
								unstaged = "",
								staged = "",
								unmerged = "",
								renamed = "",
								untracked = "",
								deleted = "",
								ignored = "",
							},
						},
					},
				},
			})
		end,
	},
	-- terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<C-b>]],
		},
	},
})
