vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("n", "gt", ":BufferLineCycleNext<CR>", { desc = "Goto next buffer" })
keymap.set("n", "gT", ":BufferLineCyclePrev<CR>", { desc = "Goto prev buffer" })

keymap.set("t", "<C-h>", "<C-\\><C-n><C-h>", { desc = "Navigate left" })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-j>", { desc = "Navigate down" })
keymap.set("t", "<C-k>", "<C-\\><C-n><C-k>", { desc = "Navigate up" })
keymap.set("t", "<C-l>", "<C-\\><C-n><C-l>", { desc = "Navigate right" })
