return {
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
}
