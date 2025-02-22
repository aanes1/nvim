return {
	"anAcc22/sakura.nvim",
	dependencies = { "rktjmp/lush.nvim" },
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("sakura")
		local purple = "#a289a1"

		local highlights = {
			--general
			ModeMsg = { fg = purple },
			CursorLineNr = { fg = purple },

			-- git signs
			GitSignsAdd = { fg = purple },
			GitSignsAddNr = { fg = purple },
			GitSignsAddLn = { fg = purple },
			GitSignsChange = { fg = purple },
			GitSignsChangeNr = { fg = purple },
			GitSignsChangeLn = { fg = purple },
			GitSignsChangedelete = { fg = purple },
		}

		-- set highlight colors
		for group, colors in pairs(highlights) do
			vim.api.nvim_set_hl(0, group, colors)
		end
	end,
}
