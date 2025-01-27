-- Resize buffer window with Alt + vim keys
vim.api.nvim_set_keymap('n', '<M-S-k>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-j>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-h>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-l>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Line wrap
vim.opt.wrap = false

-- Enable folding
vim.opt.foldenable = true
-- Set folding method (manual, indent, syntax, marker)
vim.opt.foldmethod = "manual"
-- Set fold level (99 to keep all folds open by default)
vim.opt.foldlevel = 0
-- Define custom markers if using marker folding
-- vim.opt.foldmarker = "{{{,}}}"

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
