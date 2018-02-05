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
