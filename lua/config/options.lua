local opt = vim.opt

opt.number = true
opt.cursorline = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false
opt.signcolumn = "yes"

-- colors
opt.termguicolors = true
opt.background = "dark"

-- search
opt.ignorecase = true
opt.smartcase = true

-- remove bloat
opt.fillchars = "eob: "
opt.laststatus = 0
opt.swapfile = false

-- persistent copy/undo
opt.clipboard = "unnamedplus"
opt.undofile = true

-- smart indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
