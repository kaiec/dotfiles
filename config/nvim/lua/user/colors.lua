vim.opt.background='dark'
vim.opt.termguicolors=true

vim.cmd("colorscheme OceanicNext")

-- Transparent Background
vim.cmd("hi Normal guibg=none ctermbg=none")
vim.cmd("hi NonText guibg=none ctermbg=none")
vim.cmd("hi EndOfBuffer guibg=none ctermbg=none")
vim.cmd("hi Folded guibg=none ctermbg=none")
vim.cmd("hi LineNr guibg=none ctermbg=none")

-- Warn color in insert mode

vim.cmd('highlight  CursorLine ctermbg=124 ctermfg=15')
vim.cmd('autocmd InsertEnter * set cursorline')
vim.cmd('autocmd InsertLeave * set nocursorline')

