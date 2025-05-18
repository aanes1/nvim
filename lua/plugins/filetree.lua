return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local filetree = require("nvim-tree")

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		filetree.setup({
			hijack_cursor = true,
			view = {
				width = 35,
				side = "right",
			},
			renderer = {
				root_folder_label = function(path)
					return vim.fn.fnamemodify(path, ":t")
				end,
				highlight_git = "all",
				icons = {
					web_devicons = {
						file = {
							color = false,
						},
					},
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
			filters = {
				dotfiles = true,
			},
		})
		vim.opt.fillchars:append({ vert = " " }) -- remove window seperator
	end,
}
