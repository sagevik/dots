
-- Tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Colorscheme
vim.cmd('colorscheme slate')

-- Transparent background
vim.cmd('highlight Normal ctermbg=NONE guibg=NONE')

-- Add Neovim-specific Lua configurations below
-- Enable line numbers and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Set cursorline and color
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', {bg = '#2e2e2e'})
