return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				style_preset = bufferline.style_preset.minimal,
				buffer_close_icon = "",
				modified_icon = "",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				color_icons = false,
			},
		})
	end,
}
