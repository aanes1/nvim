return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	config = function()
		local transparent = require("transparent")
		transparent.setup({
			extra_groups = {
				"NvimTreeNormal",
				"BufferLineSeparator",
				"BufferLineSeparatorVisible",
				"BufferLineSeparatorSelected",
			},
		})
		transparent.clear_prefix("BufferLine")
	end,
}
