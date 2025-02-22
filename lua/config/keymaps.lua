vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
