
vim.opt.modeline=false -- no support for modelines (vim comments)

vim.opt.mouse='a'
vim.opt.inccommand='nosplit' -- show preview for s replacements


vim.opt.whichwrap:append '<,>,[,]' -- wrap to next line with cursor keys
vim.opt.spell=false

-- line numbers
vim.opt.number=true
vim.opt.relativenumber=false 

-- Undo files
vim.opt.undofile=true
vim.opt.undodir=os.getenv('HOME') .. '/.vimundo/'

-- builtin completion
vim.opt.completeopt='longest,menuone'
vim.keymap.set('i', '<CR>',  function() return vim.fn.pumvisible() == 1 and "<C-y>" or "<C-g>u<CR>" end, {expr=true, remap=false, silent=true})
vim.opt.wildmode='longest:full,full' -- complete to longest plus menu


vim.opt.linebreak=true -- break at word boundaries

-- if hidden is not set, TextEdit might fail. (LSP)
vim.opt.hidden=true

-- no backup files
vim.opt.backup=false
vim.opt.writebackup=false

vim.opt.updatetime=300 -- idle time until swapfile is written
vim.opt.shortmess:append 'c' -- no ins-completion-menu messages
vim.opt.signcolumn='auto' -- default is auto

-- Restore cursor position, see help:last-position-jump
vim.cmd([[
    autocmd BufRead * autocmd FileType <buffer> ++once
    \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
    ]])

-- status line config
vim.opt.statusline=""
vim.opt.statusline:append '%#PmenuSel#'
-- vim.opt.statusline:append '%{StatuslineGit()}'
vim.opt.statusline:append '%#CursorColumn#'
vim.opt.statusline:append ' %f'
vim.opt.statusline:append ' %m'
vim.opt.statusline:append '%='
vim.opt.statusline:append '%#CursorColumn#'
vim.opt.statusline:append ' %y'
vim.opt.statusline:append ' %{&fileencoding?&fileencoding:&encoding}'
vim.opt.statusline:append ' [%{&fileformat}]'
vim.opt.statusline:append ' %p%%'
vim.opt.statusline:append ' %l:%c'
vim.opt.statusline:append ' '
-- vim.opt.statusline:append '%#warningmsg#'
-- vim.opt.statusline:append '%{SyntasticStatuslineFlag()}'
-- vim.opt.statusline:append '%*'


