return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			notify_on_error = false,
			formatters = {
				rustfmt = {
					command = "rustfmt",
				},
			},
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
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
		})
	end,
}
