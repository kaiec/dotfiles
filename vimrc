:set encoding=utf-8
:set fileencoding=utf-8

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
" Plugin 'johngrib/vim-game-snake', {'pinned': 1}
Plugin 'suan/vim-instant-markdown'
Plugin 'vimwiki/vimwiki'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tmhedberg/SimpylFold'
Plugin 'python-mode/python-mode'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" SEE :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line




syntax on
filetype plugin indent on
set showcmd
let mapleader = ","

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

	
" Markdown support for .md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" NERDTree toggle
map <C-n> :NERDTreeFind<CR>
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
nmap <F12> :NERDTree ~/Dropbox/Notizen<CR>
nmap <S-F12> :e ~/Dropbox/Notizen/scratch.md<CR>Go<CR>### <C-R>=strftime('%Y-%m-%d %H:%M:')<CR> 
map <LEADER>d :put=strftime('%Y-%m-%d')<CR>10la

set laststatus=2

" ------------ KEY MAPPINGS ---------------------

nnoremap ö :
nnoremap Ö :
vnoremap ö :
vnoremap Ö :
" Use ijkl as arrow key. j for insert mode
" noremap k j
" noremap i k
" noremap h i
" noremap j h

" Let's try to get rid of the arrows...
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Up> <nop>
noremap <Down> <nop>
noremap! <Left> <nop>
noremap! <Right> <nop>
noremap! <Up> <nop>
noremap! <Down> <nop>
noremap! <PageDown> <nop>
noremap <PageDown> <nop>
noremap! <PageUp> <nop>
noremap <PageUp> <nop>
noremap! <Down> <nop>
" let g:BASH_Ctrl_j = 'off'
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
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

" ------------ FOLDING --------------------------
" Enable folding with the spacebar
nnoremap <space> za

" ------------- Python --------------------------
let g:SimpylFold_docstring_preview=1
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" ------------- HTML, CSS ------------------------
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2


" ------------ Windows specific -----------------
if has("win32") || has("win64")
    set guifont=Consolas:h16:cANSI
    set background=dark
    colorscheme solarized
    :set guioptions-=m  "remove menu bar
    :set guioptions-=T  "remove toolbar
    :set guioptions-=r  "remove right-hand scroll bar
    :set guioptions-=L  "remove left-hand scroll bar
endif

" ------------ MISC ---------------------
command! VRC :e ~/.vim/vimrc

