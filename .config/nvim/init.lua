
-- Colorscheme
vim.cmd('colorscheme slate')
-- Transparent background
vim.cmd('highlight Normal ctermbg=NONE guibg=NONE')

-- Add Neovim-specific Lua configurations below
vim.opt.number = true  -- Enable line numbers
vim.opt.relativenumber = true  -- Enable relative line numbers

-- Set cursorline and color
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', {bg = '#2e2e2e'})
