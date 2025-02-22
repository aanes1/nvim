vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
