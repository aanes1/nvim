return {
	"anAcc22/sakura.nvim",
	dependencies = { "rktjmp/lush.nvim" },
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("sakura")
		local purple = "#a289a1"
		local bg = "#191719"

		local highlights = {
			--general
			ModeMsg = { fg = purple },
			CursorLineNr = { fg = purple },
			WinSeparator = { fg = bg },

			-- git signs
			GitSignsAdd = { fg = purple },
			GitSignsAddNr = { fg = purple },
			GitSignsAddLn = { fg = purple },
			GitSignsChange = { fg = purple },
			GitSignsChangeNr = { fg = purple },
			GitSignsChangeLn = { fg = purple },
			GitSignsChangedelete = { fg = purple },

			-- file tree
			NvimTreeNormal = { bg = bg },
			NvimTreeGitDirty = { fg = purple },
			NvimTreeGitStaged = { fg = purple },
			NvimTreeGitMerge = { fg = purple },
			NvimTreeGitRenamed = { fg = purple },
			NvimTreeGitNew = { fg = purple },
			NvimTreeGitDeleted = { fg = purple },
			NvimTreeSpecialFile = { bold = true },
		}

		-- set highlight colors
		for group, colors in pairs(highlights) do
			vim.api.nvim_set_hl(0, group, colors)
		end
	end,
}
