execute pathogen#infect()
syntax on
filetype plugin indent on
set showcmd
let mapleader = ","

" Markdown support for .md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" NERDTree toggle
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

" vimwiki - Personal Wiki for Vim
" https://github.com/vimwiki/vimwiki
set nocompatible

" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" helppage -> :h vimwiki-syntax 

" vim-instant-markdown - Instant Markdown previews from Vim
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>

" Notizen
map <F11> :NERDTree

set laststatus=2

" ------------ COLOR SCHEME ---------------------

" colorscheme greenwint

" ------------ LINE NUMBERS ---------------------
set number relativenumber
" https://jeffkreeftmeijer.com/vim-number/
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
highlight LineNr ctermfg=5 ctermbg=4
highlight CursorLineNr ctermfg=5 ctermbg=4

" ------------ LINE LIMIT -----------------------
set colorcolumn=81
highlight ColorColumn ctermbg=4 ctermfg=255
