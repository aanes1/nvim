return {
	"anAcc22/sakura.nvim",
	dependencies = { "rktjmp/lush.nvim" },
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("sakura")
	end,
}
